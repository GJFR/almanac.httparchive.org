#standardSQL
# Prevalence of landing pages over HTTPS that initiate at least one request over HTTP and distribution over ranking.
SELECT
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') THEN page END)) AS count_http_requests,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') THEN page END)) / COUNT(DISTINCT page) AS pct_http_requests,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 1000 THEN page END)) AS count_top_1k,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 1000 THEN page END)) / COUNT(DISTINCT page) AS pct_top_1k,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 10000 THEN page END)) AS count_top_10k,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 10000 THEN page END)) / COUNT(DISTINCT page) AS pct_top_10k,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 100000 THEN page END)) AS count_top_100k,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 100000 THEN page END)) / COUNT(DISTINCT page) AS pct_top_100k,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 1000000 THEN page END)) AS count_top_1m,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 1000000 THEN page END)) / COUNT(DISTINCT page) AS pct_top_1m,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 10000000 THEN page END)) AS count_top_10m,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') AND rank = 10000000 THEN page END)) / COUNT(DISTINCT page) AS pct_top_10m
FROM
  `httparchive.almanac.requests`
WHERE
  date = '2021-07-01'
GROUP BY
  client