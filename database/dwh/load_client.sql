-- COMPROBACIÓN DE DIMENSIÓN: SELECT COUNT(*) AS Num_Clients FROM [DATAEX].[003_clientes];
/*TIPO DE DATOS:
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('003_clientes', '005_cp', '019_mosaic')
AND TABLE_SCHEMA = 'DATAEX';
*/
SELECT
    cliente.Customer_ID,                                              -- PK Cliente ID (003_clientes).
    cliente.Edad,
    CONVERT(DATE, cliente.Fecha_nacimiento, 103) AS Fecha_nacimiento,           -- Formato DD/MM/YYYY.
    cliente.GENERO,
    cliente.STATUS_SOCIAL,
    cliente.RENTA_MEDIA_ESTIMADA,
    cliente.ENCUESTA_ZONA_CLIENTE_VENTA,
    cliente.ENCUESTA_CLIENTE_ZONA_TALLER,
    RIGHT('00000' + REPLACE(cliente.CODIGO_POSTAL, 'CP', ''), 5) AS CODIGO_POSTAL, -- Formato CPXXXXX.

    cp.poblacion,
    cp.provincia,
    CAST(cp.lat AS FLOAT) AS lat,     -- Latitud a FLOAT.
    CAST(cp.lon AS FLOAT) AS lon,     -- Longitud a FLOAT.

    mosaic.A,
    mosaic.B,
    mosaic.C,
    mosaic.D,
    mosaic.E,
    mosaic.F,
    mosaic.G,
    mosaic.H,
    mosaic.I,
    mosaic.J,
    mosaic.K,
    mosaic.U2,
    mosaic.Max_Mosaic_G,
    mosaic.Max_Mosaic2,
    mosaic.Renta_Media,
    mosaic.F2,
    mosaic.Mosaic_number
FROM [DATAEX].[003_clientes] cliente
LEFT JOIN [DATAEX].[005_cp] cp ON cliente.CODIGO_POSTAL = cp.CP -- Join con CODIGO_POSTAL (1:0..1).
LEFT JOIN [DATAEX].[019_mosaic] mosaic ON TRY_CAST(cp.codigopostalid AS INT) = mosaic.CP_value; -- Join con CP (1:0..1).
