import streamlit as st
import pandas as pd
import pyodbc
import os
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.graph_objects as go

# Configuración de la aplicación.
st.set_page_config(page_title="Dashboard Clientes - CLTV", layout="wide")
st.title('Dashboard de Segmentación de Clientes.')
current_dir = os.path.dirname(__file__)
csv_path = os.path.abspath(os.path.join(current_dir, "..", "data", "client_insights_cluster.csv"))
df = pd.read_csv(csv_path)

# Resumen general de los datos.
st.subheader('Resumen general.')
col1, col2, col3 = st.columns(3)
col1.metric('Total de clientes', df.shape[0])
col2.metric('Número de Clusters', df['Cluster'].nunique())
col3.metric('CLTV medio global', f"{df['CLTV_5_anios'].mean():,.0f} €")

# Distribución de clientes por segmento.
st.subheader('Distribución de clientes por segmento.')
clientes_por_cluster = df['Cluster_Nombre'].value_counts().sort_index()
fig1 = px.bar(clientes_por_cluster, x=clientes_por_cluster.index, y=clientes_por_cluster.values,
              labels={'x': 'Segmento de Cliente', 'y': 'Número de clientes'})
st.plotly_chart(fig1, use_container_width=True)

# CLTV medio por segmento.
st.subheader('CLTV medio a 5 años por segmento.')
cltv_summary = df.groupby('Cluster_Nombre')['CLTV_5_anios'].mean().reset_index()
fig2 = px.bar(cltv_summary, x='Cluster_Nombre', y='CLTV_5_anios',
              labels={'CLTV_5_anios': 'CLTV medio (€)'})
st.plotly_chart(fig2, use_container_width=True)

# Perfil detallado de variables clave por segmento.
st.subheader('Perfil de variables clave por segmento.')
variables = ['Edad', 'RENTA_MEDIA_ESTIMADA', 'numventas', 'margen_total', 'dias_relacion']
perfil_detallado = df.groupby('Cluster_Nombre')[variables].mean().reset_index()

fig3 = go.Figure()
for var in variables:
    fig3.add_trace(go.Bar(
        x=perfil_detallado['Cluster_Nombre'],
        y=perfil_detallado[var],
        name=var
    ))
fig3.update_layout(barmode='group', title="Perfil detallado por segmento.")
st.plotly_chart(fig3, use_container_width=True)

# Distribución del CLTV por segmento.
st.subheader('Distribución del CLTV por segmento.')
cluster_selected = st.selectbox('Seleccione un segmento.', df['Cluster_Nombre'].unique())

fig4 = px.histogram(df[df['Cluster_Nombre'] == cluster_selected], x='CLTV_5_anios', nbins=30, 
                    title=f'Distribución del CLTV a 5 años - {cluster_selected}.')
st.plotly_chart(fig4, use_container_width=True)

# Visualización de los componentes principales (PCA).
if 'PCA1' in df.columns and 'PCA2' in df.columns:
    st.subheader('Visualización PCA - Segmentación.')
    fig5 = px.scatter(df, x='PCA1', y='PCA2', color='Cluster_Nombre',
                      labels={'PCA1': 'Componente Principal 1', 'PCA2': 'Componente Principal 2'})
    st.plotly_chart(fig5, use_container_width=True)
else:
    st.info("Las columnas PCA1 y PCA2 no se encontraron en la tabla.")

# Análisis e interpretación de los clusters.
st.subheader('Perfil de los clusters.')
st.markdown("""
| Cluster                     | Perfil Socioeconómico                             | Comportamiento Comercial                                              | Interpretación Estratégica                                            |
|-----------------------------|----------------------------------------------------|-----------------------------------------------------------------------|----------------------------------------------------------------------|
| **Clientes Ocasionales**    | Edad media elevada, renta media moderada           | Pocas compras, relación histórica corta, margen total intermedio      | Clientes estables pero con escaso vínculo; potencial de desarrollo    |
| **Clientes Premium**        | Clientes jóvenes, renta media más alta             | Compras moderadas, relación prolongada, alta capacidad adquisitiva    | Segmento estratégico prioritario para fidelización y mantenimiento   |
| **Clientes Rentables**      | Edad elevada, renta media alta                     | Pocas compras, relación reciente, margen positivo                     | Clientes rentables con potencial de crecimiento si se fidelizan      |
| **Clientes Bajo Potencial** | Edad intermedia, renta media más baja              | Alta frecuencia de compras, relación histórica muy larga, margen bajo | Clientes muy activos pero poco rentables; optimización de costes     |
""")
