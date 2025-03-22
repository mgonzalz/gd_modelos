-- COMPROBACIÓN DE DIMENSIÓN: SELECT COUNT(*) AS Num_Dates FROM [DATAEX].[002_date];
/*TIPO DE DATOS:
SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = '002_date'
AND TABLE_SCHEMA = 'DATAEX';
*/
-- CONSTRUCCIÓN TIME DIMENSION:
SELECT
    -- Fechas básicas.
    CONVERT(DATE, Date, 103) AS Fecha,                                     -- Fecha original (DD/MM/YYYY)
    CONVERT(DATE, InicioMes, 103) AS InicioMes,
    CONVERT(DATE, FinMes, 103) AS FinMes,

    -- Componentes de fecha.
    Dia,
    Diadelasemana,
    Diadelesemana_desc,
    Mes,
    Mes_desc,
    Anno AS Año,
    Annomes AS Añomes,
    Week,

    -- Enriquecimiento: Creación de Nuevas Columnas.
    DATEPART(QUARTER, CONVERT(DATE, Date, 103)) AS Trimestre,              -- Trimestre del año (1-4)
    (DATEPART(DAY, CONVERT(DATE, Date, 103)) - 1) / 7 + 1 AS SemanaDelMes, -- Semana del mes (1-5)
    DATEPART(DAYOFYEAR, CONVERT(DATE, Date, 103)) AS DiaDelAño,            -- Día del año (1-365)
    DATEDIFF(
        DAY,
        DATEFROMPARTS(YEAR(CONVERT(DATE, Date, 103)), ((DATEPART(QUARTER, CONVERT(DATE, Date, 103)) - 1) * 3 + 1), 1),
        CONVERT(DATE, Date, 103)
    ) + 1 AS DiaDelTrimestre,                                              -- Día del trimestre (1-90)

    -- Clasificación.
    Findesemana,
    Festivo,
    Laboral

FROM [DATAEX].[002_date];
