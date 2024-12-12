-- 企業名に「郵政」を含む企業のIDを取得
WITH 
enterprise_filter AS (
  SELECT em.enterprise_id
  FROM `master.enterprise_master` em
  WHERE em.enterprise_name LIKE '%郵政%'
), 

-- 退職者のログイン履歴を取得し、前回のログイン日をLAG関数で取得
retiree_login AS (
  SELECT rl.retiree_id, rl.created_at AS login_date, 
         LAG(rl.created_at) OVER (PARTITION BY rl.retiree_id ORDER BY rl.created_at) AS prev_login_date
  FROM `prd.retiree_login_history` rl
  JOIN `prd.retiree` r ON rl.retiree_id = r.id
  JOIN enterprise_filter ef ON r.enterprise_id = ef.enterprise_id
), 

-- 1年以上ログインが無く、その後再ログインした退職者を特定し、次にログインした日を記録
inactive_retirees AS (
  SELECT retiree_id, MIN(login_date) AS first_login_after_inactivity
  FROM retiree_login
  WHERE TIMESTAMP_DIFF(login_date, prev_login_date, DAY) > 365
  GROUP BY retiree_id
), 

-- 直近1年間でログインがない退職者を特定
recently_inactive_retirees AS (
  SELECT r.id AS retiree_id
  FROM `prd.retiree` r
  JOIN enterprise_filter ef ON r.enterprise_id = ef.enterprise_id
  WHERE TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), r.last_login_date, DAY) > 365
),

-- 1度もログインしたことがない退職者を特定
never_logged_in_retirees AS (
  SELECT r.id AS retiree_id
  FROM `prd.retiree` r
  LEFT JOIN `prd.retiree_login_history` rl ON r.id = rl.retiree_id
  JOIN enterprise_filter ef ON r.enterprise_id = ef.enterprise_id
  WHERE rl.retiree_id IS NULL
),

-- 再ログイン後に「郵政」を含む企業名のapplication_requirementに応募した退職者の応募情報を取得
retiree_applications AS (
  SELECT ra.retiree_id, ra.created_at AS application_date
  FROM `prd.retiree_application` ra
  JOIN inactive_retirees ir ON ra.retiree_id = ir.retiree_id
  JOIN `prd.application_requirement` ar ON ra.application_requirement_id = ar.id
  JOIN enterprise_filter ef ON ar.enterprise_id = ef.enterprise_id
  WHERE ra.created_at > ir.first_login_after_inactivity
)


SELECT 
  (SELECT COUNT(DISTINCT retiree_id) 
   FROM inactive_retirees) AS retirees_with_inactivity,

  (SELECT COUNT(DISTINCT retiree_id) 
   FROM recently_inactive_retirees) AS retirees_inactive_last_year,

  (SELECT COUNT(DISTINCT retiree_id) 
   FROM never_logged_in_retirees) AS never_logged_in_retirees_count,

  (
    SELECT 
      ROUND(
        (COUNT(DISTINCT retiree_id) 
        / (COUNT(DISTINCT retiree_id) + (SELECT COUNT(DISTINCT retiree_id) FROM recently_inactive_retirees))) * 100, 1
      ) 
    FROM inactive_retirees
  ) AS inactivity_relogin_ratio_percentage,

  (SELECT COUNT(DISTINCT retiree_id) 
   FROM retiree_applications) AS total_retirees_applied_after_relogin,

  (
    SELECT 
      ROUND(
        (COUNT(DISTINCT retiree_id) 
        / ((SELECT COUNT(DISTINCT retiree_id) FROM inactive_retirees) 
           + (SELECT COUNT(DISTINCT retiree_id) FROM never_logged_in_retirees))) * 100, 1
      )
    FROM retiree_applications
  ) AS applied_after_relogin_percentage
;

