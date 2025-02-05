-- 最初からの登録者数 --

SELECT COUNT(*) AS total_registered_users
FROM `prd.retiree`
WHERE
  created_at >= '2023-06-01 00:00:00';
