/*
KPI 5 – AI Response Time

Definition:
Measures AI performance using two latency metrics:

1. TTFT (Time To First Token):
   Time in milliseconds until the model starts generating a response.

2. Total Duration:
   Total time in milliseconds for the complete response generation.

Interpretation:
TTFT reflects perceived responsiveness.
Total duration reflects full processing cost and system load.

These metrics serve as a technical performance baseline.
Due to limited historical logs with token metadata,
values should be interpreted as an initial benchmark.

Source:
conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_tiempos_tokens_vw
*/

SELECT
  COUNT(*) AS total_interactions,
  ROUND(AVG(ttft), 2) AS avg_ttft_ms,
  ROUND(AVG(duration_ms), 2) AS avg_duration_ms,
  ROUND(APPROX_QUANTILES(ttft, 100)[OFFSET(50)], 2) AS median_ttft_ms,
  ROUND(APPROX_QUANTILES(duration_ms, 100)[OFFSET(50)], 2) AS median_duration_ms
FROM `conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_tiempos_tokens_vw`;
