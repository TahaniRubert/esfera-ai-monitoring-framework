/*
KPI 1 – Satisfactory Response Rate

Definition:
Percentage of sessions where:
- The user made 1–2 real queries
- No explicit ERROR was recorded

Session definition:
A new session starts when:
- The user has no previous message
- OR more than 10 minutes have passed between messages

Real query definition:
A message is considered a real query if:
- It has 20 or more characters
- OR it contains a question mark (?)

Source:
conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_producto_vw
*/

WITH base AS (
  SELECT
    UserId,
    event_ts,
    message,
    Error,
    LAG(event_ts) OVER (
      PARTITION BY UserId
      ORDER BY event_ts
    ) AS prev_ts
  FROM `conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_producto_vw`
),

sessions AS (
  SELECT
    UserId,
    event_ts,
    message,
    Error,
    IF(
      prev_ts IS NULL
      OR TIMESTAMP_DIFF(event_ts, prev_ts, MINUTE) > 10,
      1,
      0
    ) AS new_session_flag
  FROM base
),

session_ids AS (
  SELECT
    UserId,
    event_ts,
    message,
    Error,
    SUM(new_session_flag) OVER (
      PARTITION BY UserId
      ORDER BY event_ts
    ) AS session_id
  FROM sessions
),

session_metrics AS (
  SELECT
    UserId,
    session_id,
    COUNTIF(
      (LENGTH(message) >= 20 OR message LIKE '%?%')
    ) AS real_queries,
    MAX(CASE WHEN TRIM(UPPER(Error)) = 'ERROR' THEN 1 ELSE 0 END) AS has_error
  FROM session_ids
  GROUP BY UserId, session_id
)

SELECT
  COUNTIF(real_queries BETWEEN 1 AND 2 AND has_error = 0)
  / COUNT(*) AS satisfactory_response_rate
FROM session_metrics;
