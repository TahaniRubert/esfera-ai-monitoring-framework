/*
KPI 6 – Cost per Interaction

Definition:
Estimates the average and total cost of AI usage
based on token consumption.

Pricing Model Used:
- $0.50 USD per 1M input tokens (prompt)
- $3.00 USD per 1M output tokens (response)

An interaction is defined as:
One user prompt + one AI response.

Interpretation:
Average cost per interaction provides a baseline
for monitoring cost efficiency as usage scales.

Values should be interpreted as an initial benchmark,
since historical token data is limited.

Source:
conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_tiempos_tokens_vw
*/

SELECT
  COUNT(*) AS total_interactions,
  ROUND(
    AVG(
      (prompt_token_count / 1000000.0 * 0.50) +
      (candidates_token_count / 1000000.0 * 3.00)
    ),
    6
  ) AS avg_cost_per_interaction_usd,
  ROUND(
    SUM(
      (prompt_token_count / 1000000.0 * 0.50) +
      (candidates_token_count / 1000000.0 * 3.00)
    ),
    6
  ) AS total_cost_usd
FROM `conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_tiempos_tokens_vw`;
