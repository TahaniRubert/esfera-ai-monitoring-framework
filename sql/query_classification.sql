/*
Query Classification – Topic Distribution

This query classifies AI user messages into business dimensions 
using keyword-based heuristic logic.

Dimensions:
- Orientation / Usage
- Project Progress
- Financial
- Planning
- Operational
- Reporting
- Support

Source:
conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_producto_vw
*/

WITH base AS (
  SELECT
    IF(LOWER(message) LIKE '%en que proyecto%' OR LOWER(message) LIKE '%que proyecto%' OR
       LOWER(message) LIKE '%modulos%' OR LOWER(message) LIKE '%funciones%' OR
       LOWER(message) LIKE '%que puedo consultar%' OR LOWER(message) LIKE '%como funciona%' OR
       LOWER(message) LIKE '%como usar%', 1, 0) AS dim_orientacion,

    IF(LOWER(message) LIKE '%avance%' OR LOWER(message) LIKE '%progreso%' OR
       LOWER(message) LIKE '%como vamos%' OR LOWER(message) LIKE '%estado%', 1, 0) AS dim_avance,

    IF(LOWER(message) LIKE '%presupuesto%' OR LOWER(message) LIKE '%costo%' OR
       LOWER(message) LIKE '%gasto%' OR LOWER(message) LIKE '%material%' OR
       LOWER(message) LIKE '%proveedor%' OR LOWER(message) LIKE '%pago%' OR
       LOWER(message) LIKE '%stock%' OR LOWER(message) LIKE '%inventario%' OR
       LOWER(message) LIKE '%item mas caro%' OR LOWER(message) LIKE '%item mas barato%', 1, 0) AS dim_finanzas,

    IF(LOWER(message) LIKE '%cronograma%' OR LOWER(message) LIKE '%plazo%' OR
       LOWER(message) LIKE '%fecha%' OR LOWER(message) LIKE '%cuando%', 1, 0) AS dim_planificacion,

    IF(LOWER(message) LIKE '%ingresar%' OR LOWER(message) LIKE '%cargar%' OR
       LOWER(message) LIKE '%editar%' OR LOWER(message) LIKE '%modificar%', 1, 0) AS dim_operacion,

    IF(LOWER(message) LIKE '%resum%' OR LOWER(message) LIKE '%reporte%' OR
       LOWER(message) LIKE '%grafico%' OR LOWER(message) LIKE '%dashboard%', 1, 0) AS dim_reportes,

    IF(LOWER(message) LIKE '%hablar con%' OR LOWER(message) LIKE '%soporte%' OR
       LOWER(message) LIKE '%agente%', 1, 0) AS dim_soporte

  FROM `conductive-bank-469015-r4.esfera_IA.logs_ai_esfera_producto_vw`
  WHERE message IS NOT NULL
),

totals AS (
  SELECT
    SUM(dim_orientacion) AS orientacion,
    SUM(dim_avance) AS avance,
    SUM(dim_finanzas) AS finanzas,
    SUM(dim_planificacion) AS planificacion,
    SUM(dim_operacion) AS operacion,
    SUM(dim_reportes) AS reportes,
    SUM(dim_soporte) AS soporte
  FROM base
),

grand_total AS (
  SELECT
    orientacion + avance + finanzas + planificacion + operacion + reportes + soporte AS total
  FROM totals
)

SELECT
  'Orientation' AS dimension,
  ROUND(100 * orientacion / total, 1) AS pct_topic
FROM totals, grand_total

UNION ALL
SELECT 'Project Progress', ROUND(100 * avance / total, 1) FROM totals, grand_total
UNION ALL
SELECT 'Financial', ROUND(100 * finanzas / total, 1) FROM totals, grand_total
UNION ALL
SELECT 'Planning', ROUND(100 * planificacion / total, 1) FROM totals, grand_total
UNION ALL
SELECT 'Operational', ROUND(100 * operacion / total, 1) FROM totals, grand_total
UNION ALL
SELECT 'Reporting', ROUND(100 * reportes / total, 1) FROM totals, grand_total
UNION ALL
SELECT 'Support', ROUND(100 * soporte / total, 1) FROM totals, grand_total;
