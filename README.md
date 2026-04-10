# DWH_TUXTELCOM - Proyecto Data Warehouse

**Asignatura:** Bases de Datos II  
**Rubro:** Telecomunicaciones (TUXTELCOM)  
**Tecnologías:** SQL Server, SSIS, Power BI

---

## 📌 Descripción del Proyecto

Este proyecto consiste en la implementación de un **Data Warehouse** para una empresa de telecomunicaciones. Se utilizó una arquitectura **estrella (star schema)** para responder preguntas de negocio relacionadas con:

- Factores de cancelación de servicios (P1)
- Planes prepago más contratados (P2)
- Épocas del año con mayor demanda (P3)
- Preferencia de pago (online vs presencial) (P4)
- Servicios con más demanda (P5)
- Uso por rango de edad (P6)
- Paquetes más atractivos (P7)
- Permanencia promedio antes de cancelar (P8)
- Contrataciones por departamento (P9)
- Ingresos por servicio y mes (P10)

---

## ✅ Trabajo Completado

| Componente | Estado | Descripción |
|------------|--------|-------------|
| **Base de datos Staging** | ✅ Completado | `STG_TUXTELCOM` con 8 tablas y datos de prueba |
| **Base de datos DWH** | ✅ Completado | `DWH_TUXTELCOM` con topología estrella (7 dimensiones + 3 hechos) |
| **Scripts ETL (SQL)** | ✅ Completado | Procedimientos almacenados que cargan datos desde Staging al DWH |
| **Carga de datos** | ✅ Completado | 30+ clientes, 50+ pagos, 40+ consumos, etc. |
| **Vistas analíticas** | ✅ Completado | 10 vistas que responden las preguntas de negocio |
| **Conexiones SSIS** | ✅ Completado | Conexiones a `STG_TUXTELCOM` y `DWH_TUXTELCOM` | el que trabaje el ssis tiene que hacer sus propias

---

## ❌ Trabajo Pendiente

| Componente | Estado | Tiempo estimado | Instrucciones |
|------------|--------|----------------|---------------|
| **Proyecto SSIS** | ❌ Pendiente | 3-4 horas | Ver manual abajo |
| **Reportes Power BI** | ❌ Pendiente | 2-3 horas | Ver manual abajo |
| **Diagramas relacionales** | ❌ Pendiente | 30-45 min | Ver manual abajo |
| **Informe del proyecto** | ❌ Pendiente | 2-3 horas | Ver manual abajo |
| **PowerPoint exposición** | ❌ Pendiente | 1-2 horas | Ver manual abajo |

---

## 📖 Manual de Trabajo Pendiente
## IMPORTANTE, ESTO SOLO ES UNA DESCRIPCION DE LO QUE SE DEBE HACER, SI SE NECESITA ALGO MAS USTEDES DEBEN INVESTIGARLO Y HACER LOS CAMBIOS NECESARIO PARA NO PERDER PUNTO, SOLO ES UN MANUAL NO ES UNA ORDEN IMPUESTA 
### 1. Proyecto SSIS (Visual Studio 2019)

**Objetivo:** Crear un paquete SSIS que automatice la carga desde Staging al DWH.

**Pasos:**

1. Abrir Visual Studio 2019 → Nuevo proyecto → Integration Services Project
2. Nombre: `DWH_TUXTELCOM_ETL`
3. En Connection Managers, verificar las dos conexiones:
   - `STG_TUXTELCOM` (origen) asi los tengo yo
   - `DWH_TUXTELCOM` (destino) "    "    "
4. Crear los siguientes Data Flow Tasks en el Control Flow (en este orden):

5. Para cada Data Flow Task:
   - **OLE DB Source** → tabla origen del Staging
   - **OLE DB Destination** → tabla destino del DWH
   - Configurar mapeo de columnas
6. Ejecutar (F5) y verificar que todo sea verde ✅

**Estructura de cada Data Flow:** 

| Data Flow | Origen (STG) | Destino (DWH) | Observación |
|-----------|--------------|---------------|-------------|
| DFT_dim_sucursal | stg_sucursales | dim_sucursal | Directo |
| DFT_dim_plan | stg_planes + lookup | dim_plan | Necesita Lookup a stg_tipo_servicio |
| DFT_dim_cliente | stg_clientes | dim_cliente | Calcular edad y rango_edad |
| DFT_fact_contratos | stg_contratos + 6 lookups | fact_contratos | Buscar surrogate keys |
| DFT_fact_pagos | stg_pagos + lookups | fact_pagos | Buscar surrogate keys |
| DFT_fact_consumos | stg_consumos + lookups | fact_consumos | Buscar surrogate keys |

---

### 2. Reportes Power BI

**Objetivo:** Visualizar las respuestas a las 10 preguntas de negocio.

**Pasos:**

1. Abrir **Power BI Desktop**
2. Obtener datos → SQL Server
3. Servidor: `localhost\SQLEXPRESS`
4. Base de datos: `DWH_TUXTELCOM`
5. Seleccionar todas las tablas (`dim_*` y `fact_*`)
6. **Relaciones** (verificar que Power BI las detecte automáticamente):

7. Crear las siguientes visualizaciones (mínimo 5):

| Pregunta | Visualización sugerida |
|----------|----------------------|
| P1 | Barras: Cancelaciones por motivo |
| P2 | Tabla: Planes prepago más contratados |
| P3 | Línea: Contrataciones por mes |
| P4 | Circular o anillo: % online vs presencial |
| P5 | Barras: Servicios con más contratos |
| P10 | Línea: Ingresos por servicio a lo largo del tiempo |

8. Guardar como `DWH_TUXTELCOM_Reportes.pbix`

---

### 3. Diagramas Relacionales

**Objetivo:** Documentar visualmente la estructura de Staging y DWH.

**Herramienta sugerida:** [draw.io](https://app.diagrams.net/) (gratis, sin instalación)

**Diagrama de Staging - tablas a incluir:**
-stg_sucursales
-stg_clientes
-stg_tipo_servicio
-stg_planes
-stg_contratos
-stg_pagos
-stg_consumos
-stg_reclamos

**Diagrama del DWH - tablas a incluir:**

Dimensiones:
-dim_tiempo
-dim_cliente
-dim_plan
-dim_servicio
-dim_canal_pago
-dim_sucursal
-dim_motivo_cancelacion

Hechos:
-fact_contratos
-fact_pagos
-fact_consumos


**Instrucciones en draw.io:**
1. Nuevo diagrama → "Blank Diagram"
2. Arrastrar figuras "Table" desde la izquierda
3. Dibujar relaciones (líneas) entre PK y FK
4. Exportar como PNG o PDF

---

### 4. Informe del Proyecto

**Objetivo:** Documentar todo el proyecto en un documento formal.

**Estructura sugerida (Word o Google Docs):**

