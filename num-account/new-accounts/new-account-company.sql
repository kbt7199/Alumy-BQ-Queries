WITH enterprises AS (
  SELECT '0576774bedab43beaa27477b9a7908af' AS enterprise_id, 'リクルート' AS enterprise_name UNION ALL
  SELECT 'eb57548cfe17467da960011a3140d094', '郵政' UNION ALL
  SELECT 'b4207907cc9245c99990c2f38b83ea77', '北海道電力' UNION ALL
  SELECT '3579e9c9ba624e20bd1dfd9475ca46e6', '南都' UNION ALL
  SELECT 'b7387ab2ef9c4cbc8fde48a4ee53ba2a', '中部電力' UNION ALL
  SELECT 'd8e612f91d944721ad8dd97d1edf91c7', '山田&パートナーズ' UNION ALL
  SELECT '6a884596936d4bad9c28c689049dffdc', '三菱電機' UNION ALL
  SELECT '4a7e74a41d8044939c6ee7dfe254cab6', '三菱重工' UNION ALL
  SELECT '19b8f423711d4bfd8ca2df291e46388c', '三菱HCキャピタル' UNION ALL
  SELECT '0db59e73bb9647549e67dd72feb88930', 'ポールトゥウィン' UNION ALL
  SELECT '8ea2a44dd27543db9a94d0213a6d798b', 'プロテリアル' UNION ALL
  SELECT 'ec441f4fbaff48378c0f424c702acb33', 'パナソニック コネクト' UNION ALL
  SELECT '285c4148badc4aea88339e7f48540c20', 'デンソーテン' UNION ALL
  SELECT '6a9e92bf83d648ceba9f793117b1ab18', 'ダイセル' UNION ALL
  SELECT '91431aae0e524d5fadd710cccc29fa04', 'ジェイテクト' UNION ALL
  SELECT '4c9694f63ce346ffa9160c1b899075fa', 'カプコン' UNION ALL
  SELECT '75e12f5c479440629a38d5f708538b60', 'オークマ' UNION ALL
  SELECT '9bdd4efd9f5248aa8fa95b85ee6985dd', 'エームサービス' UNION ALL
  SELECT 'dd4e4f58d5a9408f9454e4e69e5cd405', 'NECネッツエスアイ' UNION ALL
  SELECT '0d14fd93976d4348b3dd9b8fbf88228e', 'Mixi'

)

SELECT 
  e.enterprise_name,
  e.enterprise_id,
  COUNT(r.created_at) AS record_count
FROM 
  enterprises e
LEFT JOIN 
  `prd.retiree` r
ON 
  e.enterprise_id = r.enterprise_id
  -- AND r.created_at >= '2024-12-05 00:00:00'
  AND r.created_at >= '2024-12-24 00:00:00'
  AND r.cs_type_id = 'retiree'
GROUP BY 
  e.enterprise_name, e.enterprise_id;
