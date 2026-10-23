CREATE TABLE daily_metrics AS
WITH r AS (
  SELECT date, coin, close, volume,
         close * 1.0 / LAG(close) OVER (PARTITION BY coin ORDER BY date) - 1 AS daily_return
  FROM prices),
g AS (
  SELECT *,
         close * 100.0 / FIRST_VALUE(close) OVER (PARTITION BY coin ORDER BY date) AS growth_100,
         MAX(close) OVER (PARTITION BY coin ORDER BY date
                          ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS peak
  FROM r)
SELECT date, coin, close, volume, daily_return, growth_100,
       close * 1.0 / peak - 1 AS drawdown
FROM g;

CREATE TABLE monthly_returns AS
WITH m AS (
  SELECT coin, substr(date,1,7) AS ym, close,
         ROW_NUMBER() OVER (PARTITION BY coin, substr(date,1,7) ORDER BY date DESC) AS rn
  FROM prices),
e AS (SELECT coin, ym, close FROM m WHERE rn = 1)
SELECT coin, ym, substr(ym,1,4) AS year, substr(ym,6,2) AS month,
       close * 1.0 / LAG(close) OVER (PARTITION BY coin ORDER BY ym) - 1 AS monthly_return
FROM e;

CREATE TABLE summary AS
SELECT coin,
       MIN(date) AS start_date, MAX(date) AS end_date, COUNT(daily_return) AS days,
       MAX(CASE WHEN date = (SELECT MAX(date) FROM prices) THEN growth_100 END) / 100.0 - 1 AS total_return,
       AVG(daily_return) AS avg_daily_return,
       AVG(daily_return * daily_return) - AVG(daily_return) * AVG(daily_return) AS daily_variance,
       MIN(drawdown) AS max_drawdown,
       MAX(daily_return) AS best_day, MIN(daily_return) AS worst_day,
       ROUND(100.0 * SUM(CASE WHEN daily_return > 0 THEN 1 ELSE 0 END) / COUNT(daily_return), 1) AS pct_days_up
FROM daily_metrics GROUP BY coin;