SELECT 
  cs_type_id,
  external_id,
  enterprise_id,
  created_at
FROM 
  `prd.retiree`
WHERE
  created_at >= '2024-12-05 00:00:00'
  -- created_at >= '2024-12-24 00:00:00'
  AND cs_type_id = 'retiree'
  -- 以下、必要なenterprise_idをコメントアウト解除して使用
  -- AND enterprise_id = '0576774bedab43beaa27477b9a7908af' -- リクルート
  -- AND enterprise_id = 'eb57548cfe17467da960011a3140d094' -- 郵政
  -- AND enterprise_id = 'b4207907cc9245c99990c2f38b83ea77' -- 北海道電力
  -- AND enterprise_id = '3579e9c9ba624e20bd1dfd9475ca46e6' -- 南都
  -- AND enterprise_id = 'b7387ab2ef9c4cbc8fde48a4ee53ba2a' -- 中部電力
  -- AND enterprise_id = 'd8e612f91d944721ad8dd97d1edf91c7' -- 山田&パートナーズ
  -- AND enterprise_id = '6a884596936d4bad9c28c689049dffdc' -- 三菱電機
  -- AND enterprise_id = '4a7e74a41d8044939c6ee7dfe254cab6' -- 三菱重工
  -- AND enterprise_id = '19b8f423711d4bfd8ca2df291e46388c' -- 三菱HCキャピタル
  -- AND enterprise_id = '0db59e73bb9647549e67dd72feb88930' -- ポールトゥウィン
  -- AND enterprise_id = '8ea2a44dd27543db9a94d0213a6d798b' -- プロテリアル
  -- AND enterprise_id = 'ec441f4fbaff48378c0f424c702acb33' -- パナソニック コネクト
  -- AND enterprise_id = '285c4148badc4aea88339e7f48540c20' -- デンソーテン
  -- AND enterprise_id = '6a9e92bf83d648ceba9f793117b1ab18' -- ダイセル
  -- AND enterprise_id = '91431aae0e524d5fadd710cccc29fa04' -- ジェイテクト
  -- AND enterprise_id = '4c9694f63ce346ffa9160c1b899075fa' -- カプコン
  -- AND enterprise_id = '75e12f5c479440629a38d5f708538b60' -- オークマ
  -- AND enterprise_id = '9bdd4efd9f5248aa8fa95b85ee6985dd' -- エームサービス
  -- AND enterprise_id = 'dd4e4f58d5a9408f9454e4e69e5cd405' -- NECネッツエスアイ
  -- AND enterprise_id = '0d14fd93976d4348b3dd9b8fbf88228e' -- Mixi
ORDER BY
  created_at ASC;
