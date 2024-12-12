SELECT 
  cs_type_id,
  external_id,
  enterprise_id,
  created_at
FROM 
  `prd.retiree`
WHERE
  created_at >= '2024-12-05 00:00:00'
  -- AND enterprise_id = '0576774bedab43beaa27477b9a7908af' -- リクルート
  AND enterprise_id = 'eb57548cfe17467da960011a3140d094' -- 郵政
  AND cs_type_id = 'retiree'
ORDER BY
  created_at ASC;
