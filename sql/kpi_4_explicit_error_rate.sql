/*
KPI 4 – Explicit Error Rate

Definition:
Percentage of interactions where the system explicitly returned an ERROR.

Interpretation:
Measures system stability at the logging level.
A low value indicates strong technical reliability.
This metric does NOT measure semantic quality issues,
only explicit system failures recorded in the logs.

Source:
conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_producto_vw
*/

SELECT
  COUNTIF(TRIM(UPPER(Error)) = 'ERROR') / COUNT(*) AS explicit_error_rate
FROM `conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_producto_vw`;
