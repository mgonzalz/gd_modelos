-- COMPROBACIÓN DE DIMENSIÓN: SELECT COUNT(DISTINCT PVP) AS TotalUnicosPVP FROM fact_sales;
/*TABLA FEATURES PVP:
Se agrupa por PVP porque es el índice de entrada para el modelo de regresión, cuyo objetivo es
estimar el churn medio en función de variables como la edad del coche, km y el margen por unidad asociadas
a ese PVP. La salida servirá como dataset de entrenamiento para una regresión lineal.
*/
-- CONSTRUCCIÓN FEATURES PVP:
    -- Declaración de variable para churn global.
SELECT
    fact.PVP,
    AVG(fact.Car_Age) AS avg_car_age,
    AVG(fact.Km_medio_por_revision) AS avg_km_revision,
    AVG(ISNULL(fact.Revisiones, 0)) AS avg_revisiones,

    -- Porcentaje de Churn: Incremento de churn por PVP.
    AVG(CAST(Churn AS FLOAT)) AS churn_percentage

FROM fact_sales fact
GROUP BY fact.PVP;
