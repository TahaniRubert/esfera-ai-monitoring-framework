/*
KPI 2 – Reformulation Rate

Definition:
Percentage of sessions where users made more than one real query.

Interpretation:
A higher reformulation rate may indicate:
- Users needing to rephrase their questions
- Friction in initial responses
- Iterative clarification behavior

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
    LENGTH(message) AS msg_length,
    LAG(event_ts) OVER (
      PARTITION BY UserId
      ORDER BY event_ts
    ) AS prev_ts
  FROM `conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_producto_vw`
),

filtered_base AS (
  SELECT *
  FROM base
  WHERE msg_length >= 20
     OR message LIKE '%?%'
),

sessions AS (
  SELECT
    UserId,
    event_ts,
    IF(
      prev_ts IS NULL
      OR TIMESTAMP_DIFF(event_ts, prev_ts, MINUTE) > 10,
      1,
      0
    ) AS new_session_flag
  FROM filtered_base
),

session_ids AS (
  SELECT
    UserId,
    event_ts,
    SUM(new_session_flag) OVER (
      PARTITION BY UserId
      ORDER BY event_ts
    ) AS session_id
  FROM sessions
),

session_counts AS (
  SELECT
    UserId,
    session_id,
    COUNT(*) AS queries_in_session
  FROM session_ids
  GROUP BY UserId, session_id
)

SELECT
  COUNTIF(queries_in_session > 1) / COUNT(*) AS reformulation_rate
FROM session_counts;
