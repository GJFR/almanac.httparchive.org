#standardSQL
# Prevalence of server redirects from HTTP to HTTPS over Jan 2021 to Sept 2021
SELECT
  client,
  date,
  COUNT(DISTINCT url) AS total_http_urls_on_page,
  COUNT(DISTINCT(CASE WHEN resp_location LIKE "https://%" THEN url END)) AS count_https_redirect,
  COUNT(DISTINCT(CASE WHEN resp_location LIKE "https://%" THEN url END)) / COUNT(DISTINCT url) AS pct_https_redirect
FROM
  `httparchive.sample_data.requests`
WHERE
  date BETWEEN "2021-01-01" AND "2021-09-01" AND
  status BETWEEN 300 AND 399 AND
  url LIKE "http://%"
GROUP BY
  client,
  date
ORDER BY
  client,
  date
