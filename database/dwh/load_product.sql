-- COMPROBACIÓN DE DIMENSIÓN: SELECT COUNT(*) AS Num_Product FROM [DATAEX].[006_producto];
/*TIPO DE DATOS:
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('006_producto', '007_costes', '014_categoría_producto', '015_fuel')
AND TABLE_SCHEMA = 'DATAEX';
*/
-- CONSTRUCCIÓN PRODUCT DIMENSION:
SELECT
    producto.Id_Producto,          -- PK producto
    producto.Code_,                -- PK alternativo
    producto.Kw,
    producto.TIPO_CARROCERIA,
    producto.TRANSMISION_ID,

    -- Categoría.
    -- categoria_producto.Grade_ID,
    categoria_producto.Equipamiento,

    -- Tipo de combustible.
    fuel.FUEL,

    -- Costes asociados.
    costes.Margen,
    costes.Costetransporte,
    costes.Margendistribuidor,
    costes.GastosMarketing,
    costes.Mantenimiento_medio,
    costes.Comisión_Marca

FROM [DATAEX].[006_producto] producto
LEFT JOIN [DATAEX].[007_costes] costes ON producto.Modelo = costes.Modelo -- Join con Costes (*:1).
LEFT JOIN [DATAEX].[014_categoría_producto] categoria_producto ON producto.CATEGORIA_ID = categoria_producto.CATEGORIA_ID -- Join con Categoría Producto (*:1).
LEFT JOIN [DATAEX].[015_fuel] fuel ON producto.Fuel_ID = fuel.Fuel_ID; -- Join con Fuel (*:1).
