-- COMPROBACIÓN DE DIMENSIÓN: SELECT COUNT(*) AS Num_Rows FROM [DATAEX].[001_sales];
/*TIPO DE DATOS:
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('001_sales', '004_rev', '008_cac',
                    '009_motivo_venta', '010_forma_pago', '017_logist',
                    '016_origen_venta', '018_edad', '006_producto', '007_costes')
AND TABLE_SCHEMA = 'DATAEX';
*/
SELECT
    sales.CODE,                          -- PK Venta ID (001_sales).
    sales.Code_,                         -- FK Tabla Producto.
    sales.COSTE_VENTA_NO_IMPUESTOS,
    sales.Customer_ID,                   -- FK Tabla Clientes.
    sales.EN_GARANTIA,
    sales.EXTENSION_GARANTIA,
    CONVERT(DATE, sales.FIN_GARANTIA, 103) AS Fin_Garantia,
    sales.Id_Producto,                   -- FK Tabla Producto.
    sales.IMPUESTOS,
    sales.MANTENIMIENTO_GRATUITO,
    sales.PVP,
    CONVERT(DATE, sales.Sales_Date, 103) AS Sales_Date,   -- FK Tabla Tiempo.
    sales.SEGURO_BATERIA_LARGO_PLAZO,
    sales.TIENDA_ID,                     -- FK Tabla Lugar.

    -- Revisiones.
    CONVERT(DATE, revisions.DATE_UTIMA_REV, 103) AS DATE_ULTIMA_REVISION,
    CAST(REPLACE(revisions.DIAS_DESDE_ULTIMA_REVISION, '.', '') AS INT) AS DIAS_DESDE_ULTIMA_REVISION,
    revisions.Km_medio_por_revision,
    revisions.km_ultima_revision,
    revisions.Revisiones,

    -- Quejas y Talleres.
    cac.DIAS_DESDE_LA_ULTIMA_ENTRADA_TALLER,
    cac.DIAS_EN_TALLER,
    cac.QUEJA,

    -- Motivo de Venta.
    motivo_venta.MOTIVO_VENTA,

    -- Forma de Pago.
    forma_pago.FORMA_PAGO,
    forma_pago.FORMA_PAGO_GRUPO,

    -- Logística.
    logist.Fue_Lead,
    logist.Lead_compra,
    CONVERT(DATE, logist.Logistic_date, 103) AS Logistic_date,
    CONVERT(DATE, logist.Prod_date, 103) AS Prod_date,
    logist.t_logist_days,
    logist.t_prod_date,
    logist.t_stock_dates,
    --Logística: Origen de la Venta.
    origen_venta.Origen,

    -- Edad del Coche.
    edad_coche.Car_Age,

    -- Enriquecimiento: Producto y Costes.
        -- Margen Bruto: Calcula el margen bruto de la venta antes de costes adicionales. Sirve para evaluar la rentabilidad básica del producto.
    ROUND(sales.PVP * (costes.Margen) * 0.01 * (1 - sales.IMPUESTOS / 100), 2) AS Margen_Eur_bruto,

        -- Margen Neto: Calcula el margen neto después de costes de venta, marketing, distribución y transporte. Sirve para conocer la rentabilidad real.
    ROUND(sales.PVP * (costes.Margen) * 0.01 * (1 - sales.IMPUESTOS / 100)
        - sales.COSTE_VENTA_NO_IMPUESTOS
        - (costes.Margendistribuidor * 0.01 + costes.GastosMarketing * 0.01 - costes.Comisión_Marca * 0.01) * sales.PVP * (1 - sales.IMPUESTOS / 100)
        - costes.Costetransporte, 2) AS Margen_Eur,

        -- Coste Total Venta: Suma todos los costes asociados a la venta (venta, marketing, distribución y transporte). Sirve para entender el coste real de cada venta.
    sales.COSTE_VENTA_NO_IMPUESTOS + (costes.Margendistribuidor * 0.01 + costes.GastosMarketing * 0.01 - costes.Comisión_Marca * 0.01) * sales.PVP * (1 - sales.IMPUESTOS / 100)
    + costes.Costetransporte AS Coste_Total_Venta,

        -- Tasa de Quejas: Indica si la venta generó una queja (1) o no (0). Sirve para identificar problemas de calidad o satisfacción del cliente.
    CASE WHEN cac.QUEJA IS NOT NULL THEN 1 ELSE 0 END AS Tasa_Quejas_Venta

FROM [DATAEX].[001_sales] sales
LEFT JOIN [DATAEX].[004_rev] revisions ON sales.CODE = revisions.CODE -- Join con Revisiones (1:1).
LEFT JOIN [DATAEX].[008_cac] cac ON sales.CODE = cac.CODE -- Join con Quejas y Talleres (1:0..1).
LEFT JOIN [DATAEX].[009_motivo_venta] motivo_venta ON sales.MOTIVO_VENTA_ID = motivo_venta.MOTIVO_VENTA_ID -- Join con Motivo de venta (*:1).
LEFT JOIN [DATAEX].[010_forma_pago] forma_pago ON sales.FORMA_PAGO_ID = forma_pago.FORMA_PAGO_ID -- Join con Forma de pago (*:1).
LEFT JOIN [DATAEX].[018_edad] edad_coche ON sales.CODE = edad_coche.CODE -- Join con Edad Coche (1:0..1).

-- Join con Logística (1:1) y después con Origen de venta (*:1).
LEFT JOIN [DATAEX].[017_logist] logist ON sales.CODE = logist.CODE
LEFT JOIN [DATAEX].[016_origen_venta] origen_venta ON logist.Origen_Compra_ID = origen_venta.Origen_Compra_ID

-- Fórmulas: Producto y Costes.
LEFT JOIN [DATAEX].[006_producto] producto ON sales.Id_Producto = producto.Id_Producto
LEFT JOIN [DATAEX].[007_costes] costes ON producto.Modelo = costes.Modelo;
