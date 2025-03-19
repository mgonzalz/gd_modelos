# **Identificación de Fuentes de Datos.**

## **Sistemas Involucrados.**

Este proyecto se basa en la integración de datos de cuatro sistemas principales:

- **ERP**: Se refiere a las tablas que contienen datos relacionados con ventas, costos, productos, inventario y gestión financiera.
- **CRM**: Se refiere a las tablas que contienen datos relacionados con clientes, interacciones y comportamiento.
- **Logística**: Se refiere a las tablas que contienen datos relacionados con transporte, distribución y ubicaciones.
- **Postventa**: Se refiere a las tablas que contienen datos relacionados con mantenimiento, revisiones, quejas y seguimiento de clientes después de la venta.

Este formato te permitirá identificar claramente el ámbito y sistema fuente de cada tabla, lo que facilitará la consolidación de datos en el Data Warehouse y el análisis del ciclo de vida del producto.

## **Tablas Relevantes y su Relación con los Sistemas.**

Aquí tienes la tabla con la información de cada tabla del archivo **Datalake.xlsx**, asignando el ámbito y sistema fuente correspondiente:

| **Tabla**           | **Descripción**                                                                 | **Sistema Fuente** |
|----------------------|--------------------------------------------------------------------------------|--------------------|
| `001_sales`         | Contiene datos sobre ventas, costos, impuestos, garantías y detalles de productos vendidos. | ERP                |
| `002_date`          | Almacena información de fechas, días de la semana, festivos y meses.           | ERP (o sistema de gestión de tiempos) |
| `003_clientes`      | Contiene datos demográficos y de comportamiento de los clientes.               | CRM                |
| `004_rev`           | Registra información sobre revisiones y mantenimiento de vehículos.            | Postventa          |
| `005_cp`            | Almacena datos de códigos postales, ubicaciones y provincias.                  | Logística          |
| `006_producto`      | Contiene detalles de productos, como categorías, modelos y características.    | ERP                |
| `007_costes`        | Registra costos de transporte, márgenes y gastos de marketing.                 | ERP                |
| `008_cac`           | Almacena información sobre quejas y tiempo en taller.                          | Postventa          |
| `009_motivo_venta`  | Contiene motivos de venta y sus identificadores.                               | ERP                |
| `010_forma_pago`    | Registra formas de pago y sus grupos.                                          | ERP                |
| `011_tienda`        | Almacena datos de tiendas, provincias y zonas.                                 | ERP                |
| `012_provincia`     | Contiene descripciones de provincias y sus identificadores.                    | ERP                |
| `013_zona`          | Almacena información sobre zonas y sus identificadores.                        | ERP                |
| `014_categoría_producto` | Contiene categorías de productos y equipamientos.                         | ERP                |
| `015_fuel`          | Almacena tipos de combustible y sus identificadores.                           | ERP                |
| `016_origen_venta`  | Registra el origen de las ventas y sus identificadores.                        | ERP                |
| `017_logist`        | Contiene datos de logística, fechas de producción y ventas.                    | Logística          |
| `018_edad`          | Almacena información sobre la edad de los vehículos y fechas de venta.         | Postventa          |
| `019_Mosaic`        | Contiene datos de segmentación de clientes basados en características demográficas y de comportamiento. | CRM                |

## **Descripción de Tablas Clave.**

A continuación, se presenta una descripción detallada de las **tablas clave**, junto con su relevancia en el contexto del proyecto de construcción de un entorno analítico (DWH) y cálculo del **Customer Lifetime Value (CLTV)**.

### **Tabla `001_sales`.**

| **Campo**                     | **Tipo de Dato** | **Descripción**                                                                 | **Valores Únicos** | **Valores Repetidos** | **Observaciones**                                                                 |
|--------------------------------|------------------|---------------------------------------------------------------------------------|--------------------|------------------------|-----------------------------------------------------------------------------------|
| `CODE`                        | varchar(50)      | Código único asociado a la venta.                                               | 58,049             | 0                      | No hay valores repetidos. Cada fila tiene un código único.                         |
| `Sales_Date`                  | varchar(50)      | Fecha en que se realizó la venta.                                               | 2,135              | 55,914                | Hay muchas fechas repetidas, lo que sugiere múltiples ventas en las mismas fechas. |
| `Customer_ID`                 | int              | Identificador único del cliente.                                                | 44,053             | 13,996                | Algunos clientes realizaron múltiples compras.                                     |
| `Id_Producto`                 | varchar(50)      | Identificador único del producto vendido.                                       | 404                | 57,645                | Solo hay 404 productos únicos, lo que indica que muchos productos se vendieron repetidamente. |
| `PVP`                         | int              | Precio de venta al público (Precio final del producto).                         | 1,011              | 57,038                | Hay muchos precios repetidos, lo que sugiere que los productos tienen precios fijos o similares. |
| `MOTIVO_VENTA_ID`             | int              | Identificador del motivo de la venta.                                           | 2                  | 58,047                | Solo hay 2 motivos de venta, lo que indica poca diversidad en este campo.          |
| `FORMA_PAGO_ID`               | int              | Identificador de la forma de pago utilizada.                                    | 4                  | 58,045                | Solo hay 4 formas de pago, lo que sugiere que la mayoría de las ventas usan estas opciones. |
| `SEGURO_BATERIA_LARGO_PLAZO`  | varchar(50)      | Indica si se incluyó un seguro de batería a largo plazo (SI/NO).                | 2                  | 58,047                | Solo hay 2 valores posibles (SI/NO), lo que indica poca diversidad en este campo.  |
| `MANTENIMIENTO_GRATUITO`      | int              | Indica si el mantenimiento es gratuito (0 = No, 4 = Sí).                        | 2                  | 58,047                | Solo hay 2 valores posibles (0/4), lo que indica poca diversidad en este campo.    |
| `FIN_GARANTIA`                | varchar(50)      | Fecha de finalización de la garantía del producto.                              | 2,135              | 55,914                | Las fechas de fin de garantía están repetidas, lo que sugiere que muchos productos tienen la misma fecha de garantía. |
| `COSTE_VENTA_NO_IMPUESTOS`    | int              | Coste de venta sin incluir impuestos.                                           | 2,273              | 55,776                | Hay muchos costos repetidos, lo que sugiere que los productos tienen costos similares. |
| `IMPUESTOS`                   | int              | Impuestos aplicados a la venta.                                                 | 1                  | 58,048                | Solo hay un valor único, lo que indica que todos los registros tienen el mismo impuesto. |
| `TIENDA_ID`                   | int              | Identificador de la tienda donde se realizó la venta.                           | 12                 | 58,037                | Solo hay 12 tiendas únicas, lo que sugiere que las ventas se concentran en estas tiendas. |
| `Code_`                       | varchar(50)      | Código adicional asociado al producto (posiblemente redundante).                | 404                | 57,645                | Solo hay 404 códigos únicos, lo que indica que muchos productos tienen el mismo código. |
| `EXTENSION_GARANTIA`          | varchar(50)      | Indica si se incluyó una extensión de garantía (SI/NO).                         | 4                  | 58,045                | Solo hay 4 valores posibles, lo que sugiere poca diversidad en este campo.         |
| `BASE_DATE`                   | varchar(50)      | Fecha base asociada a la venta (posiblemente fecha de registro).                | 1                  | 58,048                | Solo hay una fecha base, lo que indica que todos los registros comparten la misma fecha base. |
| `EN_GARANTIA`                 | varchar(50)      | Indica si el producto está en garantía (SI/NO).                                 | 2                  | 58,047                | Solo hay 2 valores posibles (SI/NO), lo que indica poca diversidad en este campo.  |

**Relevancia General de la Tabla:**

- **Análisis de Ventas:** Esta tabla es fundamental para analizar el comportamiento de las ventas, identificar productos más rentables y entender las tendencias temporales.
- **Cálculo del CLTV:** Proporciona datos clave para calcular el Customer Lifetime Value (CLTV), como ingresos por cliente, frecuencia de compra y márgenes de beneficio.
- **Gestión de Postventa:** Los campos relacionados con garantías y mantenimiento permiten evaluar la eficacia de los servicios postventa y su impacto en la fidelización del cliente.
- **Optimización de Estrategias:** Los datos sobre formas de pago, motivos de venta y servicios adicionales ayudan a optimizar estrategias comerciales y de marketing.

### **Tabla `003_clientes`.**

| **Campo**                     | **Tipo de Dato** | **Descripción**                                                                 | **Valores Únicos** | **Valores Repetidos** | **Observaciones**                                                                 |
|--------------------------------|------------------|---------------------------------------------------------------------------------|--------------------|------------------------|-----------------------------------------------------------------------------------|
| `Customer_ID`                 | int              | Identificador único del cliente.                                                | 44,053             | 0                      | No hay valores repetidos. Cada fila representa un cliente único.                  |
| `Edad`                        | int              | Edad del cliente.                                                               | 59                 | 43,994                | Muchos clientes comparten la misma edad, lo que sugiere una distribución común.   |
| `RENTA_MEDIA_ESTIMADA`        | int              | Renta media estimada del cliente.                                               | 9,352              | 34,701                | Hay muchos valores repetidos, lo que indica que varios clientes tienen ingresos similares. |
| `ENCUESTA_ZONA_CLIENTE_VENTA` | int              | Resultados de encuestas relacionadas con la zona de venta.                      | 201                | 43,852                | La mayoría de los valores están repetidos, lo que sugiere respuestas comunes.     |
| `ENCUESTA_CLIENTE_ZONA_TALLER`| int              | Resultados de encuestas relacionadas con la zona de taller.                     | 205                | 43,848                | Similar a la encuesta de venta, con muchos valores repetidos.                     |
| `GENERO`                      | varchar(50)      | Género del cliente (F = Femenino, M = Masculino).                               | 3                  | 44,050                | Solo hay 3 valores posibles, indicando que hay nulos.         |
| `CODIGO_POSTAL`               | varchar(50)      | Código postal del cliente.                                                      | 4,603              | 39,450                | Muchos clientes comparten el mismo código postal, lo que sugiere concentración geográfica. |
| `Fecha_nacimiento`            | varchar(50)      | Fecha de nacimiento del cliente.                                                | 59                 | 43,994                | Similar a la edad, muchos clientes comparten la misma fecha de nacimiento.        |
| `STATUS_SOCIAL`               | varchar(50)      | Estatus social del cliente (A, B, C, etc.).                                     | 13                 | 44,040                | Solo hay 13 valores posibles, lo que indica poca diversidad en este campo. Existe la presencia de nulos.       |

**Relevancia General de la Tabla:**

- **Segmentación de Clientes**: Esta tabla es fundamental para segmentar clientes por edad, género, ingresos, ubicación y estatus social.
- **Análisis Demográfico**: Proporciona información clave para entender la composición demográfica de la base de clientes.
- **Personalización de Estrategias**: Los datos de ingresos, género y estatus social permiten personalizar estrategias de marketing y ventas.
- **Análisis Geográfico**: El código postal permite realizar análisis de concentración geográfica y optimizar la logística y distribución.

### **Tabla `004_rev`.**

| **Campo**                     | **Tipo de Dato** | **Descripción**                                                                 | **Valores Únicos** | **Valores Repetidos** | **Observaciones**                                                                 |
|--------------------------------|------------------|---------------------------------------------------------------------------------|--------------------|------------------------|-----------------------------------------------------------------------------------|
| `Revisiones`                  | int              | Número de revisiones realizadas.                                                | 9                  | 58,040                | La mayoría de los valores son 0, lo que indica que muchos vehículos no han tenido revisiones. |
| `Km_medio_por_revision`       | int              | Kilometraje medio entre revisiones.                                             | 21,561             | 36,488                | Muchos valores repetidos, lo que sugiere que los vehículos tienen patrones de uso similares. |
| `km_ultima_revision`          | int              | Kilometraje en la última revisión.                                              | 25,988             | 32,061                | Similar al campo anterior, con muchos valores repetidos.                          |
| `CODE`                        | varchar(50)      | Código único asociado a la revisión.                                            | 58,049             | 0                      | No hay valores repetidos. Cada fila tiene un código único.                         |
| `DIAS_DESDE_ULTIMA_REVISION`  | int              | Días transcurridos desde la última revisión.                                    | 1,468              | 56,581                | Muchos valores repetidos, lo que indica que muchos vehículos tienen patrones de revisión similares. |
| `DATE_UTIMA_REV`              | varchar(50)      | Fecha de la última revisión.                                                    | 1,468              | 56,581                | Similar al campo anterior, con muchos valores repetidos.                          |

**Relevancia General de la Tabla:**

- **Gestión de Mantenimiento**: Esta tabla es fundamental para gestionar el mantenimiento de los vehículos, identificar patrones de uso y planificar revisiones.
- **Análisis de Kilometraje**: Proporciona información clave para entender el uso de los vehículos y su impacto en el mantenimiento.
- **Planificación de Revisiones**: Los datos sobre días desde la última revisión y fechas de revisión permiten planificar mantenimientos preventivos y evitar fallos.

### **Tabla `005_cp`.**

| **Campo**                     | **Tipo de Dato** | **Descripción**                                                                 | **Valores Únicos** | **Valores Repetidos** | **Observaciones**                                                                 |
|--------------------------------|------------------|---------------------------------------------------------------------------------|--------------------|------------------------|-----------------------------------------------------------------------------------|
| `provincia`                   | varchar(50)      | Nombre de la provincia.                                                         | 52                 | 10,988                | Hay 52 provincias únicas, pero muchos registros comparten la misma provincia.     |
| `poblacion`                   | varchar(50)      | Nombre de la población o municipio.                                             | 6,116              | 4,924                 | Muchas poblaciones están repetidas, lo que sugiere que varias provincias comparten nombres de poblaciones. |
| `codigopostalid`              | varchar(50)      | Identificador único del código postal.                                          | 11,040             | 0                      | No hay valores repetidos. Cada fila tiene un código postal único.                 |
| `lat`                         | float            | Latitud de la ubicación.                                                        | 6,115              | 4,925                 | Muchas ubicaciones comparten la misma latitud, lo que sugiere que están cerca.    |
| `lon`                         | float            | Longitud de la ubicación.                                                       | 6,114              | 4,926                 | Similar a la latitud, muchas ubicaciones comparten la misma longitud.             |
| `CP`                          | varchar(50)      | Código postal.                                                                  | 11,040             | 0                      | No hay valores repetidos. Cada fila tiene un código postal único.                 |

**Observaciones Generales**:

- **Código Postal**: Los campos `codigopostalid` y `CP` tienen 11,040 valores únicos y 0 repetidos, lo que indica que cada fila representa un código postal único. Esto es útil para identificar ubicaciones específicas.

**Relevancia General de la Tabla:**

- **Análisis Geográfico**: Esta tabla es fundamental para realizar análisis geográficos, como la concentración de clientes o tiendas en ciertas áreas.
- **Segmentación por Ubicación**: Permite segmentar datos por provincia, población o código postal, lo que es útil para estrategias de marketing localizado.
- **Optimización Logística**: Las coordenadas geográficas permiten optimizar rutas de distribución y logística.

### **Tabla `017_logist`.**

| **Campo**                     | **Tipo de Dato** | **Descripción**                                                                 | **Valores Únicos** | **Valores Repetidos** | **Observaciones**                                                                 |
|--------------------------------|------------------|---------------------------------------------------------------------------------|--------------------|------------------------|-----------------------------------------------------------------------------------|
| `Fue_Lead`                    | int              | Indica si el cliente fue un lead (1 = Sí, 0 = No).                              | 2                  | 58,047                | Solo hay 2 valores posibles, lo que indica poca diversidad en este campo.         |
| `Lead_compra`                 | int              | Indica si el lead se convirtió en compra (1 = Sí, 0 = No).                      | 2                  | 58,047                | Similar al campo anterior, con solo 2 valores posibles.                           |
| `Origen_Compra_ID`            | int              | Identificador del origen de la compra.                                          | 2                  | 58,047                | Solo hay 2 valores posibles, lo que sugiere que las compras provienen de dos orígenes principales. |
| `t_prod_date`                 | int              | Días transcurridos desde la producción hasta la venta.                          | 46                 | 58,003                | Muchos valores repetidos, lo que indica que muchos productos tienen tiempos de producción similares. |
| `t_logist_days`               | int              | Días transcurridos en logística.                                                | 31                 | 58,018                | Muchos valores repetidos, lo que sugiere que los tiempos de logística son similares. |
| `t_stock_dates`               | int              | Días en stock antes de la venta.                                                | 76                 | 57,973                | Aunque hay más valores únicos, muchos valores están repetidos, lo que indica patrones similares en el tiempo en stock. |
| `CODE`                        | varchar(50)      | Código único asociado a la transacción.                                         | 58,049             | 0                      | No hay valores repetidos. Cada fila tiene un código único.                         |
| `Sales_Date`                  | varchar(50)      | Fecha de la venta.                                                              | 2,190              | 55,859                | Muchas fechas repetidas, lo que indica múltiples ventas en las mismas fechas.      |
| `Prod_date`                   | varchar(50)      | Fecha de producción.                                                            | 2,232              | 55,817                | Similar al campo `Sales_Date`, con muchas fechas repetidas.                        |
| `Logistic_date`               | varchar(50)      | Fecha de logística.                                                             | 2,250              | 55,799                | Similar a los campos anteriores, con muchas fechas repetidas.                      |

**Relevancia General de la Tabla:**

- **Gestión de Leads y Conversiones**: Esta tabla es fundamental para analizar la eficacia de las estrategias de captación de leads y su conversión en ventas.
- **Optimización de la Cadena de Suministro**: Proporciona información clave para optimizar los tiempos de producción, logística y almacenamiento.
- **Análisis Temporal**: Permite analizar tendencias temporales en las ventas y la producción.

### **Tabla `019_Mosaic`.**

| **Campo**                     | **Tipo de Dato** | **Descripción**                                                                 | **Valores Únicos** | **Valores Repetidos** | **Observaciones**                                                                 |
|--------------------------------|------------------|---------------------------------------------------------------------------------|--------------------|------------------------|-----------------------------------------------------------------------------------|
| `CP`                          | varchar(50)      | Código postal.                                                                  | 6,457              | 0                      | No hay valores repetidos. Cada fila tiene un código postal único.                 |
| `CP_value`                    | int              | Valor asociado al código postal.                                                | 6,457              | 0                      | No hay valores repetidos. Cada fila tiene un valor único asociado al código postal. |
| `PROV`                        | int              | Identificador de la provincia.                                                  | 52                 | 6,405                  | Muchos valores repetidos, lo que indica que muchos códigos postales pertenecen a las mismas provincias. |
| `PROV_INE`                    | varchar(50)      | Nombre de la provincia según el INE.                                            | 52                 | 6,405                  | Similar al campo `PROV`, con muchos valores repetidos.                            |
| `A1`, `A2`, `A3`, `A4`        | float            | Variables de segmentación demográfica (A1, A2, A3, A4).                         | 130, 325, 216, 331 | 6,327, 6,132, 6,241, 6,126 | Muchos valores repetidos, lo que sugiere que estas variables tienen una distribución común. |
| `B10`, `B5`, `B6`, `B7`, `B8`, `B9` | float       | Variables de segmentación demográfica (B10, B5, B6, B7, B8, B9).                | 215, 77, 417, 155, 190, 131 | 6,242, 6,380, 6,040, 6,302, 6,267, 6,326 | Muchos valores repetidos, lo que indica patrones comunes en estas variables.      |
| `C11`, `C12`, `C13`, `C14`, `C15` | float         | Variables de segmentación demográfica (C11, C12, C13, C14, C15).                | 362, 349, 387, 197, 82 | 6,095, 6,108, 6,070, 6,260, 6,375 | Muchos valores repetidos, lo que sugiere que estas variables tienen una distribución común. |
| `D16`, `D17`, `D18`, `D19`    | float            | Variables de segmentación demográfica (D16, D17, D18, D19).                     | 284, 264, 439, 278 | 6,173, 6,193, 6,018, 6,179 | Muchos valores repetidos, lo que indica patrones comunes en estas variables.      |
| `E20`, `E21`, `E22`, `E23`, `E24` | float         | Variables de segmentación demográfica (E20, E21, E22, E23, E24).                | 248, 325, 364, 301, 217 | 6,209, 6,132, 6,093, 6,156, 6,240 | Muchos valores repetidos, lo que sugiere que estas variables tienen una distribución común. |
| `F25`, `F26`, `F27`           | float            | Variables de segmentación demográfica (F25, F26, F27).                          | 101, 98, 45        | 6,356, 6,359, 6,412    | Muchos valores repetidos, lo que indica patrones comunes en estas variables.      |
| `G28`, `G29`, `G30`           | float            | Variables de segmentación demográfica (G28, G29, G30).                          | 210, 337, 151      | 6,247, 6,120, 6,306    | Muchos valores repetidos, lo que sugiere que estas variables tienen una distribución común. |
| `H31`, `H32`, `H33`, `H34`, `H35`, `H36` | float | Variables de segmentación demográfica (H31, H32, H33, H34, H35, H36).           | 218, 288, 238, 179, 347, 67 | 6,239, 6,169, 6,219, 6,278, 6,110, 6,390 | Muchos valores repetidos, lo que indica patrones comunes en estas variables.      |
| `I37`, `I38`, `I39`, `I40`    | float            | Variables de segmentación demográfica (I37, I38, I39, I40).                     | 328, 188, 138, 228 | 6,129, 6,269, 6,319, 6,229 | Muchos valores repetidos, lo que sugiere que estas variables tienen una distribución común. |
| `J41`, `J42`, `J43`           | float            | Variables de segmentación demográfica (J41, J42, J43).                          | 62, 146, 60        | 6,395, 6,311, 6,397    | Muchos valores repetidos, lo que indica patrones comunes en estas variables.      |
| `K44`, `K45`, `K46`, `K47`, `K48`, `K49`, `K50` | float | Variables de segmentación demográfica (K44, K45, K46, K47, K48, K49, K50).      | 23, 59, 28, 15, 47, 38, 93 | 6,434, 6,398, 6,429, 6,442, 6,410, 6,419, 6,364 | Muchos valores repetidos, lo que indica patrones comunes en estas variables.      |
| `U`                           | float            | Variable de segmentación demográfica (U).                                       | 308                | 6,149                  | Muchos valores repetidos, lo que sugiere que esta variable tiene una distribución común. |
| `Max_Mosaic`                  | varchar(50)      | Segmentación principal del cliente.                                             | 51                 | 6,406                  | Muchos valores repetidos, lo que indica que muchos clientes comparten la misma segmentación principal. |
| `Max_Mosaic1`                 | float            | Valor asociado a la segmentación principal.                                      | 883                | 5,574                  | Muchos valores repetidos, lo que sugiere que muchos clientes tienen valores similares en esta variable. |
| `A`, `B`, `C`, `D`, `E`, `F`, `G`, `H`, `I`, `J`, `K` | float | Variables de segmentación demográfica (A, B, C, D, E, F, G, H, I, J, K).        | 607, 605, 759, 648, 596, 173, 453, 606, 480, 189, 137 | 5,850, 5,852, 5,698, 5,809, 5,861, 6,284, 6,004, 5,851, 5,977, 6,268, 6,320 | Muchos valores repetidos, lo que indica patrones comunes en estas variables.      |
| `U2`                          | float            | Variable de segmentación demográfica (U2).                                      | 308                | 6,149                  | Similar al campo `U`, con muchos valores repetidos.                               |
| `Max_Mosaic_G`                | varchar(50)      | Segmentación secundaria del cliente.                                            | 12                 | 6,445                  | Muchos valores repetidos, lo que indica que muchos clientes comparten la misma segmentación secundaria. |
| `Max_Mosaic2`                 | float            | Valor asociado a la segmentación secundaria.                                     | 893                | 5,564                  | Muchos valores repetidos, lo que sugiere que muchos clientes tienen valores similares en esta variable. |
| `Renta_Media`                 | float            | Renta media estimada del cliente.                                               | 4,526              | 1,931                  | Muchos valores repetidos, lo que indica que muchos clientes tienen ingresos similares. |
| `F2`                          | float            | Variable de segmentación demográfica (F2).                                      | 99                 | 6,358                  | Muchos valores repetidos, lo que sugiere que esta variable tiene una distribución común. |
| `Count`                       | float            | Conteo asociado a la segmentación.                                              | 303                | 6,154                  | Muchos valores repetidos, lo que indica que muchos clientes tienen valores similares en esta variable. |
| `Mosaic_number`               | float            | Número de segmentación.                                                         | 11                 | 6,446                  | Muchos valores repetidos, lo que indica que muchos clientes comparten el mismo número de segmentación. |
| `Check`                       | float            | Variable de verificación.                                                       | 1                  | 6,456                  | Solo hay un valor único, lo que indica que todos los registros tienen el mismo valor. |

**Observaciones Generales**:

- **Segmentación Demográfica**: La tabla contiene múltiples variables de segmentación demográfica (A1, A2, B10, etc.), muchas de las cuales tienen valores repetidos. Esto sugiere que los clientes comparten características demográficas similares, lo que puede ser útil para agruparlos en segmentos.
- **Código Postal Único**: Los campos `CP` y `CP_value` tienen 6,457 valores únicos y 0 repetidos, lo que indica que cada fila representa un código postal único. Esto es útil para análisis geográficos y de concentración de clientes.

**Relevancia General de la Tabla:**

- **Segmentación de Clientes**: Esta tabla es fundamental para segmentar clientes basándose en características demográficas y de ingresos.
- **Análisis Geográfico**: Proporciona información clave para realizar análisis geográficos y de concentración de clientes.
- **Personalización de Estrategias**: Los datos de segmentación permiten personalizar estrategias de marketing y ventas basadas en segmentos de clientes.

## **Relaciones Entre Tablas.**

Las relaciones entre las tablas se muestran en el **diagrama de entidad-relación (E-R)**, dónde se definen las claves primarias y foráneas, asegurando la integridad referencial de los datos.
