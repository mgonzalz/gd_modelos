# **Modelo de Datos Dimensional y Estimación de CLTV en el Sector Automotriz.**

## **Descripción General.**

Este repositorio documenta el desarrollo de una solución analítica orientada al sector automotriz, cuyo objetivo es consolidar, transformar y modelar datos provenientes de distintos sistemas operacionales. La arquitectura desarrollada permite estimar la probabilidad de abandono (churn), calcular el Customer Lifetime Value (CLTV) y segmentar clientes según patrones de comportamiento. El análisis se complementa con una capa de visualización interactiva orientada a la toma de decisiones estratégicas.

Para más detalles, consulte la [memoria técnica del proyecto](report/gestion_datos_modelo_dwh.pdf).

## **Accesos y Recursos.**

- Repositorio del proyecto: [https://github.com/mgonzalz/gd_modelos/tree/01_modelo-relacional](https://github.com/mgonzalz/gd_modelos/tree/01_modelo-relacional)
- Aplicación interactiva: [https://dashboard-clients.streamlit.app/](https://dashboard-clients.streamlit.app/)

## **Objetivos del Proyecto.**

- Unificar y consolidar datos operacionales procedentes de sistemas ERP, CRM, logística y postventa.
- Modelar la información bajo una estructura dimensional orientada a la explotación analítica.
- Estimar métricas clave como la probabilidad de abandono y el CLTV a medio plazo.
- Identificar segmentos de clientes mediante técnicas de aprendizaje no supervisado.
- Desarrollar herramientas de visualización que permitan una lectura estratégica de los resultados.

## **Arquitectura Técnica.**

El flujo de trabajo se estructura en las siguientes etapas:

1. **Extracción de datos** desde un entorno de lectura en Azure SQL Database.
2. **Transformación y carga** de los datos a un entorno local (SQL Server), mediante un pipeline ETL.
3. **Modelado dimensional**, bajo un esquema en estrella compuesto por una tabla de hechos (`FactSales`) y cuatro dimensiones:
   - Cliente (`Customer`)
   - Producto (`Product`)
   - Tiempo (`Time`)
   - Geografía (`Geo`)
4. **Cálculo de métricas analíticas**, incluyendo Churn y CLTV.
5. **Segmentación de clientes** utilizando reducción de dimensionalidad (PCA) y clustering (K-Means).
6. **Visualización** mediante Power BI y Streamlit.

## **Modelado Predictivo y Estimación del CLTV.**

La probabilidad de abandono se modela mediante regresión lineal multivariable, generando un valor continuo entre 0 y 1. Esta probabilidad alimenta la fórmula de estimación del CLTV, la cual considera ingresos históricos, margen promedio y tasa de retención, ajustada con una tasa de descuento sectorial (7%).

La vista analítica unificada (`Visión Cliente`) integra los siguientes atributos:

- Datos demográficos y socioeconómicos.
- Variables de comportamiento (frecuencia de revisiones, historial de compras).
- Probabilidad de churn calculada.
- Métricas agregadas por cliente.

## **Segmentación Avanzada.**

El conjunto de clientes es segmentado aplicando:

- **Análisis de Componentes Principales (PCA)** para reducción de dimensionalidad.
- **K-Means Clustering** con determinación óptima de 4 segmentos diferenciados según valor potencial y riesgo de abandono.

Los segmentos resultantes han sido integrados en la vista consolidada y están disponibles para consulta tanto en SQL Server como en la aplicación Streamlit.

## **Visualización.**

Se han desarrollado dos entornos de análisis visual:

- **Power BI**: dashboards con indicadores agregados, histogramas de CLTV, análisis por cohortes temporales y geográficos.
- **Streamlit**: aplicación interactiva que permite explorar perfiles de cliente, atributos clave y simulaciones de CLTV.

## **Plan de Mejora y Escalabilidad.**

Con el fin de evolucionar el proyecto hacia un entorno productivo y escalable, se definen las siguientes líneas de actuación:

- Contenerización del entorno analítico mediante Docker.
- Migración de la base de datos consolidada a servicios gestionados en la nube (Azure SQL, Amazon RDS).
- Automatización del pipeline ETL mediante Azure Data Factory.

## **Estructura del Repositorio.**

```bash
├── data/ # Conjuntos de datos para visualización.
├── databases/
│ └── dwh/ # Scripts SQL del modelo dimensional y vistas analíticas.
│ └── er/ # Esquema del modelo entidad-relación.
├── preprocessing/ # Consulta para la creación de una tabla para predicción de Churn.
├── notebooks/ # Documentación técnica y análisis exploratorio en Jupyter.
├── dashboard/ # Archivos Power BI (.pbix).
├── streamlit_app/ # Código fuente de la aplicación Streamlit.
└── README.md # Documento técnico principal.
```

## **Autoría.**

El presente trabajo ha sido desarrollado en el marco de la asignatura *Gestión de Datos*, por:

**María González García** - Fecha de entrega: 29 de marzo de 2025.
