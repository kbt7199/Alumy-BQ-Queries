-- 企業毎の退職者の登録者数、応募者数、入社人数

DECLARE start_date TIMESTAMP DEFAULT TIMESTAMP('2022-02-01 00:00:00'); -- 開始日をTIMESTAMP型に統一
DECLARE end_date TIMESTAMP DEFAULT TIMESTAMP('2025-01-31 00:00:00'); -- 開始日をTIMESTAMP型に統一

-- DECLARE end_date DATE DEFAULT '2025-01-31';   -- 終了日を指定

WITH filtered_application AS (
  SELECT * 
  FROM `prd.retiree_application`
  WHERE created_at BETWEEN start_date AND end_date -- 期間フィルタ
)
SELECT 
  e.enterprise_name,
  COUNT(r.id) AS registered_count,
  COUNT(DISTINCT ra.retiree_id) AS applicant_count,
  COUNT(DISTINCT CASE WHEN ra.intention_confirm_date IS NOT NULL THEN ra.retiree_id END) AS hired_count
FROM `master.enterprise_master` e
LEFT JOIN `prd.retiree` r 
  ON e.enterprise_id = r.enterprise_id
--   AND r.cs_type_id = 'retiree'
LEFT JOIN filtered_application ra
  ON r.id = ra.retiree_id
WHERE e.enterprise_name NOT IN (
  '(株)内部テスト', 
  'カムバックコーディネータ', 
  '(株)Alumyデモ', 
  '(株)内部テスト2(子)', 
  '(株)内部テスト3(子)', 
  '(株)内部テスト4'
)
GROUP BY e.enterprise_name
-- ORDER BY registered_count DESC;
-- ORDER BY applicant_count DESC;
ORDER BY hired_count DESC;
