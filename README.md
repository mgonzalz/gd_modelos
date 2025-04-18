# **Segmentación Inteligente de Clientes Telecomunicaciones.**

*Un enfoque no supervisado para identificar patrones latentes y activar decisiones comerciales.*

## **Descripción General del Proyecto.**

Este proyecto aborda el reto de comprender y segmentar la base de clientes de una empresa de **telecomunicaciones** en un entorno donde **no existe una etiqueta de comportamiento clara**. A través de técnicas de aprendizaje no supervisado, se han identificado perfiles latentes que permiten personalizar estrategias de fidelización, adquisición y pricing.

La solución se estructura en una **pipeline modular**, aplicando técnicas propias del **análisis multivariante**, el **clustering**, la **validación topológica** y la **visualización estratégica**, para convertir datos dispersos en información accionable.

## **Objetivos Técnicos y Estratégicos.**

- Reducir la complejidad dimensional de los datos manteniendo su estructura explicativa.
- Agrupar a los clientes en clusters homogéneos a partir de sus características latentes.
- Validar la calidad del modelo mediante técnicas visuales y métricas de estabilidad.
- Interpretar cada grupo para la activación en campañas y dashboards de negocio.

## **Metodología Aplicada.**

1. **Preprocesamiento y transformación de variables.**
    - Limpieza, imputación y normalización.
    - Codificación de variables: ordinal, one-hot y binaria.
    - Recodificación semántica para visualización en Power BI.

2. **Reducción de dimensionalidad.**
    - Aplicación de **PCA (Principal Component Analysis)**
    - Validación visual con **t-SNE** para comprobar la separación no lineal de los datos.

3. **Segmentación de clientes.**
    - Aplicación de **K-Means Clustering** optimizado por:
        - Método del Codo (Elbow).
        - Índice de Silueta.

4. **Análisis post-clustering.**
    - Cálculo del **índice de comportamiento relativo** por variable:
    $$
    \text{Índice} = \frac{\text{Media en el cluster}}{\text{Media global}}
    $$
    - Interpretación estratégica de cada cluster a partir de insights técnicos y de negocio.
    - Generación de **naming dual** para cada grupo: Ej.: "*Golden Offline*" ↔ "Adultos premium no digitalizados"

## **Visualización Estratégica.**

- Diseño e implementación de un dashboard interactivo en **Power BI**.
- Visualización por cluster: edad, ingresos, gasto, zona, abandono, campañas...
- Activación directa del análisis para equipos comerciales y de marketing.

> [Accede al dashboard y PDF explicativo](https://github.com/mgonzalz/gd_modelos/tree/02_segmentaci%C3%B3n/dashboard)

## **Futuras Integraciones.**

- **App en Streamlit** para predicción del cluster de nuevos clientes en tiempo real.
- **API REST embebida** para conectar el modelo con sistemas CRM o automatización de campañas.
- Integración con **N8N Agents** para orquestación de flujos comerciales automáticos.

## **Accesos y Recursos.**

- **Repositorio del proyecto**: [github.com/mgonzalz/gd_modelos/tree/02_segmentación](https://github.com/mgonzalz/gd_modelos/tree/02_segmentaci%C3%B3n)

- **Notebooks principales.**
    1. `Data Preprocessing` – Limpieza y codificación.
    2. `Segmentation Model` – PCA, t-SNE, clustering.
    3. `Cluster Analysis` – Interpretación estratégica y naming.
