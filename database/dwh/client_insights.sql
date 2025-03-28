-- Declaración de Variables.
DECLARE
    -- Tasa de descuento para cálculos financieros.
    @discount_rate FLOAT = 0.07,

    -- Coeficientes del modelo de churn.
    @b_intercepto FLOAT,
    @b_pvp FLOAT,
    @b_edad FLOAT,
    @b_km FLOAT,
    @b_revisiones FLOAT;

-- Carga de Coeficientes: Extracción de los coeficientes del modelo previamente entrenado.
SELECT
    @b_intercepto = MAX(CASE WHEN Variable = 'Intercepto' THEN Coeficiente END),
    @b_pvp        = MAX(CASE WHEN Variable = 'PVP' THEN Coeficiente END),
    @b_edad       = MAX(CASE WHEN Variable = 'avg_car_age' THEN Coeficiente END),
    @b_km         = MAX(CASE WHEN Variable = 'avg_km_revision' THEN Coeficiente END),
    @b_revisiones = MAX(CASE WHEN Variable = 'avg_revisiones' THEN Coeficiente END)
FROM churn_coef;

-- CTE Retención: Calcular la probabilidad de retención para cada cliente.
WITH retencion_cte AS (
    SELECT
        c.Customer_ID,
        LEAST(1, GREATEST(0,
            1 - (
                @b_intercepto +
                AVG(f.PVP) * @b_pvp +
                MAX(f.Car_Age) * @b_edad +
                AVG(f.km_ultima_revision) * @b_km +
                AVG(f.Revisiones) * @b_revisiones
            )
        )) AS retencion_estimado
    FROM dim_client c
    LEFT JOIN fact_sales f ON c.Customer_ID = f.Customer_ID
    GROUP BY c.Customer_ID
)

-- Consulta principal: Generar el dataset de clientes con sus métricas y segmentaciones.
SELECT
    c.Customer_ID,
    c.Edad,
    c.GENERO,
    c.STATUS_SOCIAL,
    c.RENTA_MEDIA_ESTIMADA,

    -- Datos Demográficos.
    c.CODIGO_POSTAL,
    c.poblacion,
    c.provincia,
    c.lat,
    c.lon,
    c.Max_Mosaic_G AS Segmento_Principal,

    -- Métricas de Ventas: KPIs de compras históricas.
    COUNT(DISTINCT f.CODE) AS numventas,
    COUNT(DISTINCT f.Id_Producto) AS numero_coches,
    AVG(f.PVP) AS pvp_medio,
    AVG(f.COSTE_VENTA_NO_IMPUESTOS) AS coste_medio_sin_impuestos,
    AVG(CASE
        WHEN f.COSTE_VENTA_NO_IMPUESTOS > 0
        THEN 100 * (f.COSTE_VENTA_NO_IMPUESTOS - f.PVP) / f.COSTE_VENTA_NO_IMPUESTOS
        ELSE NULL
    END) AS descuento_medio,

    -- Postventa: Métricas de fidelización y uso del servicio.
    AVG(f.Revisiones) AS avg_revisiones,
    CASE
        WHEN AVG(f.Revisiones) > 0 THEN c.Edad / NULLIF(AVG(f.Revisiones), 0)
        ELSE NULL
    END AS ratio_edad_rev,
    AVG(f.km_ultima_revision) AS km_rev,

    -- Leads: Clientes potenciales.
    MAX(CASE WHEN f.Fue_Lead = 1 THEN 1 ELSE 0 END) AS lead_algunavez,
    MAX(f.Lead_compra) AS lead_compra,

    -- Indicadores Financieros: Rentabilidad por cliente.
    AVG(f.Margen_Eur_bruto) AS margenbruto_pu,
    SUM(f.Margen_Eur) AS margen_total,
    AVG(f.Margen_Eur) AS margen_pu,

    -- Edad Último Coche.
    MAX(f.Car_Age) AS edad_ultimocoche,

    -- Fechas Clave.
    MIN(CONVERT(DATE, f.Sales_Date)) AS primera_compra,
    MAX(CONVERT(DATE, f.Sales_Date)) AS ultima_compra,
    DATEDIFF(DAY,
        MIN(CONVERT(DATE, f.Sales_Date)),
        MAX(CONVERT(DATE, f.Sales_Date))) AS dias_relacion,

    -- Modelo Predictivo: Probabilidad de Churn y Retención.
        -- CHURN.
    LEAST(1, GREATEST(0, 1 - r.retencion_estimado)) AS churn_estimado,
        -- RETENCIÓN DESDE EL CTE
    r.retencion_estimado,

    -- CLTV (Customer Lifetime Value): Valor del cliente a lo largo de 5 años.
    AVG(f.Margen_Eur) * (
        POWER(r.retencion_estimado, 1) / POWER(1 + @discount_rate, 1) +
        POWER(r.retencion_estimado, 2) / POWER(1 + @discount_rate, 2) +
        POWER(r.retencion_estimado, 3) / POWER(1 + @discount_rate, 3) +
        POWER(r.retencion_estimado, 4) / POWER(1 + @discount_rate, 4) +
        POWER(r.retencion_estimado, 5) / POWER(1 + @discount_rate, 5)
    ) AS CLTV_5_anios

FROM dim_client c
LEFT JOIN fact_sales f ON c.Customer_ID = f.Customer_ID
LEFT JOIN retencion_cte r ON c.Customer_ID = r.Customer_ID

GROUP BY
    c.Customer_ID,
    c.Edad,
    c.GENERO,
    c.STATUS_SOCIAL,
    c.RENTA_MEDIA_ESTIMADA,
    c.CODIGO_POSTAL,
    c.poblacion,
    c.provincia,
    c.lat,
    c.lon,
    c.Max_Mosaic_G,
    r.retencion_estimado;
