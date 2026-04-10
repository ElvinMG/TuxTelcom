-- ============================================
-- DATA WAREHOUSE - TUXTELCOM
-- Proyecto Final - Bases de Datos II
-- Topologia: Estrella
-- ============================================

CREATE DATABASE DWH_TUXTELCOM;
GO

USE DWH_TUXTELCOM;
GO

-- ============================================
-- DIMENSIONES
-- ============================================

-- 1. DIMENSION TIEMPO
-- Incluye temporada para responder P3
CREATE TABLE dim_tiempo (
    sk_tiempo     INT         IDENTITY(1,1) NOT NULL,
    fecha         DATE        NOT NULL,
    dia           INT         NOT NULL,
    mes           INT         NOT NULL,
    anio          INT         NOT NULL,
    trimestre     INT         NOT NULL,
    nombre_dia    VARCHAR(15) NOT NULL,
    nombre_mes    VARCHAR(15) NOT NULL,
    temporada     VARCHAR(30) NULL,   -- SEMANA_SANTA / VACACIONES_VERANO / NAVIDAD / FIESTAS_PATRIAS / TEMPORADA_NORMAL
    es_fin_semana INT         DEFAULT 0,
    es_feriado_hn INT         DEFAULT 0,
    PRIMARY KEY (sk_tiempo),
    CONSTRAINT uq_dim_tiempo_fecha UNIQUE (fecha)
);
GO

-- Tabla auxiliar de feriados de Honduras
-- Es mas claro tenerlos separados que meterlos todos en un IIF gigante
CREATE TABLE dim_feriados_hn (
    fecha       DATE         NOT NULL,
    descripcion VARCHAR(80)  NOT NULL,
    PRIMARY KEY (fecha)
);
GO

INSERT INTO dim_feriados_hn (fecha, descripcion) VALUES
('2022-01-01', 'Anio Nuevo'),
('2022-04-14', 'Jueves Santo'),
('2022-04-15', 'Viernes Santo'),
('2022-05-01', 'Dia del Trabajo'),
('2022-09-15', 'Dia de Independencia'),
('2022-10-03', 'Dia del Ejercito'),
('2022-10-12', 'Dia de las Americas'),
('2022-10-21', 'Dia de las Fuerzas Armadas'),
('2022-12-25', 'Navidad'),
('2023-01-01', 'Anio Nuevo'),
('2023-04-06', 'Jueves Santo'),
('2023-04-07', 'Viernes Santo'),
('2023-05-01', 'Dia del Trabajo'),
('2023-09-15', 'Dia de Independencia'),
('2023-10-03', 'Dia del Ejercito'),
('2023-10-12', 'Dia de las Americas'),
('2023-10-21', 'Dia de las Fuerzas Armadas'),
('2023-12-25', 'Navidad'),
('2024-01-01', 'Anio Nuevo'),
('2024-03-28', 'Jueves Santo'),
('2024-03-29', 'Viernes Santo'),
('2024-05-01', 'Dia del Trabajo'),
('2024-09-15', 'Dia de Independencia'),
('2024-10-03', 'Dia del Ejercito'),
('2024-10-12', 'Dia de las Americas'),
('2024-10-21', 'Dia de las Fuerzas Armadas'),
('2024-12-25', 'Navidad');
GO

-- 2. DIMENSION CLIENTE (SCD Tipo 1)
-- rango_edad para P6, region_hn para P9
CREATE TABLE dim_cliente (
    sk_cliente      INT          IDENTITY(1,1) NOT NULL,
    nk_cliente_id   INT          NOT NULL,
    nombre_completo VARCHAR(200) NOT NULL,
    genero          VARCHAR(15)  NULL,
    rango_edad      VARCHAR(20)  NOT NULL,   -- 18-25 / 26-35 / 36-45 / 46-60 / 60+
    edad_actual     INT          NULL,
    departamento    VARCHAR(70)  NOT NULL,
    municipio       VARCHAR(70)  NOT NULL,
    region_hn       VARCHAR(40)  NULL,       -- Norte / Central / Sur / Occidente
    estado_cliente  VARCHAR(20)  NOT NULL,
    fecha_registro  DATE         NOT NULL,
    PRIMARY KEY (sk_cliente)
);
GO

-- 3. DIMENSION PLAN
-- Para P2, P7
CREATE TABLE dim_plan (
    sk_plan                   INT           IDENTITY(1,1) NOT NULL,
    nk_plan_id                INT           NOT NULL,
    nombre_plan               VARCHAR(100)  NOT NULL,
    tipo_plan                 VARCHAR(20)   NOT NULL,   -- PREPAGO / POSTPAGO
    categoria_precio          VARCHAR(20)   NOT NULL,   -- BASICO / MEDIO / PREMIUM
    precio_mensual            DECIMAL(10,2) NOT NULL,
    tiene_voz                 INT           DEFAULT 0,
    tiene_datos_moviles       INT           DEFAULT 0,
    tiene_llamadas_ilimitadas INT           DEFAULT 0,
    tiene_redes_sociales      INT           DEFAULT 0,
    tiene_internet_hogar      INT           DEFAULT 0,
    tiene_tv                  INT           DEFAULT 0,
    datos_gb_incluidos        DECIMAL(8,2)  DEFAULT 0,
    velocidad_mbps            DECIMAL(8,2)  DEFAULT 0,
    PRIMARY KEY (sk_plan)
);
GO

-- 4. DIMENSION SERVICIO
CREATE TABLE dim_servicio (
    sk_servicio         INT          IDENTITY(1,1) NOT NULL,
    nk_tipo_servicio_id INT          NOT NULL,
    nombre_servicio     VARCHAR(50)  NOT NULL,
    descripcion         VARCHAR(200) NULL,
    PRIMARY KEY (sk_servicio)
);
GO

-- 5. DIMENSION CANAL DE PAGO
-- Para P4: pago en linea vs presencial
CREATE TABLE dim_canal_pago (
    sk_canal_pago INT         IDENTITY(1,1) NOT NULL,
    metodo_pago   VARCHAR(20) NOT NULL,   -- EN_LINEA / PRESENCIAL
    canal_detalle VARCHAR(50) NOT NULL,   -- APP_MOVIL / PORTAL_WEB / SUCURSAL / AGENTE_AUTORIZADO
    tipo_canal    VARCHAR(30) NULL,       -- DIGITAL / FISICO
    PRIMARY KEY (sk_canal_pago)
);
GO

-- 6. DIMENSION SUCURSAL
CREATE TABLE dim_sucursal (
    sk_sucursal     INT          IDENTITY(1,1) NOT NULL,
    nk_sucursal_id  INT          NOT NULL,
    nombre_sucursal VARCHAR(100) NOT NULL,
    departamento    VARCHAR(70)  NOT NULL,
    municipio       VARCHAR(70)  NOT NULL,
    tipo_sucursal   VARCHAR(30)  NULL,
    PRIMARY KEY (sk_sucursal)
);
GO

-- 7. DIMENSION MOTIVO DE CANCELACION
-- Para P1
CREATE TABLE dim_motivo_cancelacion (
    sk_motivo          INT          IDENTITY(1,1) NOT NULL,
    motivo_codigo      VARCHAR(30)  NOT NULL,
    motivo_descripcion VARCHAR(150) NOT NULL,
    PRIMARY KEY (sk_motivo)
);
GO

-- ============================================
-- TABLAS DE HECHOS
-- ============================================

-- HECHO: CONTRATOS
-- Responde P1, P2, P3, P5, P7, P8, P9
CREATE TABLE fact_contratos (
    sk_contrato           BIGINT   IDENTITY(1,1) NOT NULL,
    sk_tiempo_inicio      INT      NOT NULL,
    sk_cliente            INT      NOT NULL,
    sk_plan               INT      NOT NULL,
    sk_servicio           INT      NOT NULL,
    sk_sucursal           INT      NULL,
    sk_motivo_cancelacion INT      NULL,
    nk_contrato_id        INT      NOT NULL,
    fue_cancelado         INT      DEFAULT 0,
    meses_permanencia     INT      NULL,
    es_prepago            INT      DEFAULT 0,
    canal_venta           VARCHAR(40) NULL,
    tuvo_reclamos_previos INT      DEFAULT 0,
    PRIMARY KEY (sk_contrato),
    CONSTRAINT fk_fco_tiempo   FOREIGN KEY (sk_tiempo_inicio)     REFERENCES dim_tiempo(sk_tiempo),
    CONSTRAINT fk_fco_cliente  FOREIGN KEY (sk_cliente)            REFERENCES dim_cliente(sk_cliente),
    CONSTRAINT fk_fco_plan     FOREIGN KEY (sk_plan)               REFERENCES dim_plan(sk_plan),
    CONSTRAINT fk_fco_servicio FOREIGN KEY (sk_servicio)           REFERENCES dim_servicio(sk_servicio),
    CONSTRAINT fk_fco_sucursal FOREIGN KEY (sk_sucursal)           REFERENCES dim_sucursal(sk_sucursal),
    CONSTRAINT fk_fco_motivo   FOREIGN KEY (sk_motivo_cancelacion) REFERENCES dim_motivo_cancelacion(sk_motivo)
);
GO

-- HECHO: PAGOS
-- Responde P4, P10
CREATE TABLE fact_pagos (
    sk_pago         BIGINT        IDENTITY(1,1) NOT NULL,
    sk_tiempo       INT           NOT NULL,
    sk_cliente      INT           NOT NULL,
    sk_plan         INT           NOT NULL,
    sk_servicio     INT           NOT NULL,
    sk_canal_pago   INT           NOT NULL,
    nk_pago_id      BIGINT        NOT NULL,
    monto           DECIMAL(12,2) NOT NULL,
    pago_completado INT           DEFAULT 1,
    PRIMARY KEY (sk_pago),
    CONSTRAINT fk_fp_tiempo   FOREIGN KEY (sk_tiempo)     REFERENCES dim_tiempo(sk_tiempo),
    CONSTRAINT fk_fp_cliente  FOREIGN KEY (sk_cliente)    REFERENCES dim_cliente(sk_cliente),
    CONSTRAINT fk_fp_plan     FOREIGN KEY (sk_plan)       REFERENCES dim_plan(sk_plan),
    CONSTRAINT fk_fp_servicio FOREIGN KEY (sk_servicio)   REFERENCES dim_servicio(sk_servicio),
    CONSTRAINT fk_fp_canal    FOREIGN KEY (sk_canal_pago) REFERENCES dim_canal_pago(sk_canal_pago)
);
GO

-- HECHO: CONSUMOS
-- Responde P5, P6
CREATE TABLE fact_consumos (
    sk_consumo       BIGINT        IDENTITY(1,1) NOT NULL,
    sk_tiempo        INT           NOT NULL,
    sk_cliente       INT           NOT NULL,
    sk_plan          INT           NOT NULL,
    sk_servicio      INT           NOT NULL,
    nk_consumo_id    BIGINT        NOT NULL,
    tipo_consumo     VARCHAR(30)   NOT NULL,
    duracion_minutos DECIMAL(10,2) DEFAULT 0,
    cantidad_gb      DECIMAL(12,4) DEFAULT 0,
    cantidad_sms     INT           DEFAULT 0,
    horas_tv         DECIMAL(8,2)  DEFAULT 0,
    PRIMARY KEY (sk_consumo),
    CONSTRAINT fk_fcon_tiempo   FOREIGN KEY (sk_tiempo)   REFERENCES dim_tiempo(sk_tiempo),
    CONSTRAINT fk_fcon_cliente  FOREIGN KEY (sk_cliente)  REFERENCES dim_cliente(sk_cliente),
    CONSTRAINT fk_fcon_plan     FOREIGN KEY (sk_plan)     REFERENCES dim_plan(sk_plan),
    CONSTRAINT fk_fcon_servicio FOREIGN KEY (sk_servicio) REFERENCES dim_servicio(sk_servicio)
);
GO

-- ============================================
-- DATOS FIJOS DE DIMENSIONES
-- ============================================

INSERT INTO dim_servicio (nk_tipo_servicio_id, nombre_servicio, descripcion) VALUES
(1, 'MOVIL',    'Telefonia movil: llamadas, SMS y datos moviles'),
(2, 'FIJO',     'Telefonia fija residencial y empresarial'),
(3, 'INTERNET', 'Internet de banda ancha para el hogar'),
(4, 'TV',       'Television por cable');
GO

INSERT INTO dim_canal_pago (metodo_pago, canal_detalle, tipo_canal) VALUES
('EN_LINEA',   'APP_MOVIL',         'DIGITAL'),
('EN_LINEA',   'PORTAL_WEB',        'DIGITAL'),
('PRESENCIAL', 'SUCURSAL',          'FISICO'),
('PRESENCIAL', 'AGENTE_AUTORIZADO', 'FISICO');
GO

INSERT INTO dim_motivo_cancelacion (motivo_codigo, motivo_descripcion) VALUES
('PRECIO',       'El cliente considera que el precio es muy alto'),
('COBERTURA',    'Problemas de senal o cobertura en la zona'),
('SERVICIO',     'Inconformidad con la calidad del servicio'),
('PORTABILIDAD', 'El cliente se cambio a otra empresa operadora'),
('OTRO',         'Motivo no especificado o diferente a los anteriores');
GO

-- ============================================
-- PROCEDIMIENTO PARA LLENAR DIM_TIEMPO
-- ============================================

CREATE PROCEDURE sp_llenar_dim_tiempo
    @fecha_inicio DATE,
    @fecha_fin    DATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @fecha DATE = @fecha_inicio;

    WHILE @fecha <= @fecha_fin
    BEGIN
        INSERT INTO dim_tiempo (
            fecha, dia, mes, anio, trimestre,
            nombre_dia, nombre_mes, temporada,
            es_fin_semana, es_feriado_hn
        )
        VALUES (
            @fecha,
            DAY(@fecha),
            MONTH(@fecha),
            YEAR(@fecha),
            DATEPART(QUARTER, @fecha),
            -- Nombre del dia con CASE estandar
            CASE DATEPART(WEEKDAY, @fecha)
                WHEN 1 THEN 'Domingo'
                WHEN 2 THEN 'Lunes'
                WHEN 3 THEN 'Martes'
                WHEN 4 THEN 'Miercoles'
                WHEN 5 THEN 'Jueves'
                WHEN 6 THEN 'Viernes'
                WHEN 7 THEN 'Sabado'
            END,
            -- Nombre del mes con CASE estandar
            CASE MONTH(@fecha)
                WHEN 1  THEN 'Enero'
                WHEN 2  THEN 'Febrero'
                WHEN 3  THEN 'Marzo'
                WHEN 4  THEN 'Abril'
                WHEN 5  THEN 'Mayo'
                WHEN 6  THEN 'Junio'
                WHEN 7  THEN 'Julio'
                WHEN 8  THEN 'Agosto'
                WHEN 9  THEN 'Septiembre'
                WHEN 10 THEN 'Octubre'
                WHEN 11 THEN 'Noviembre'
                WHEN 12 THEN 'Diciembre'
            END,
            -- Temporadas del anio (relevante para P3)
            CASE
                WHEN MONTH(@fecha) IN (3, 4)                              THEN 'SEMANA_SANTA'
                WHEN MONTH(@fecha) IN (6, 7)                              THEN 'VACACIONES_VERANO'
                WHEN MONTH(@fecha) = 9 AND DAY(@fecha) BETWEEN 12 AND 20  THEN 'FIESTAS_PATRIAS'
                WHEN MONTH(@fecha) = 12                                   THEN 'NAVIDAD'
                ELSE 'TEMPORADA_NORMAL'
            END,
            CASE WHEN DATEPART(WEEKDAY, @fecha) IN (1, 7) THEN 1 ELSE 0 END,
            -- Los feriados los buscamos en la tabla auxiliar
            CASE WHEN EXISTS (SELECT 1 FROM dim_feriados_hn WHERE fecha = @fecha) THEN 1 ELSE 0 END
        );

        SET @fecha = DATEADD(DAY, 1, @fecha);
    END
END
GO

-- Ejecutar para el rango del proyecto
EXEC sp_llenar_dim_tiempo '2022-01-01', '2024-12-31';
GO

-- Verificaciones rapidas
SELECT COUNT(*) AS total_fechas FROM dim_tiempo;
SELECT COUNT(*) AS total_feriados FROM dim_tiempo WHERE es_feriado_hn = 1;
SELECT * FROM dim_servicio;
SELECT * FROM dim_canal_pago;
SELECT * FROM dim_motivo_cancelacion;
GO

-- ============================================
-- VISTAS ANALITICAS - PREGUNTAS DE NEGOCIO
-- ============================================

-- P1: Cuales son los factores en la decision de cancelar un servicio
CREATE VIEW v_cancelaciones AS
SELECT
    dmc.motivo_descripcion,
    ds.nombre_servicio,
    dp.categoria_precio,
    dp.tipo_plan,
    COUNT(*) AS total_cancelaciones,
    AVG(CAST(fc.meses_permanencia AS DECIMAL(10,1))) AS promedio_meses_antes_cancelar,
    SUM(fc.tuvo_reclamos_previos) AS cancelaciones_con_reclamos_previos
FROM fact_contratos fc
JOIN dim_motivo_cancelacion dmc ON dmc.sk_motivo = fc.sk_motivo_cancelacion
JOIN dim_servicio ds ON ds.sk_servicio = fc.sk_servicio
JOIN dim_plan dp ON dp.sk_plan = fc.sk_plan
WHERE fc.fue_cancelado = 1
GROUP BY dmc.motivo_descripcion, ds.nombre_servicio, dp.categoria_precio, dp.tipo_plan;
GO

-- P2: Cuales son los tipos de planes prepago mas contratados
CREATE VIEW v_planes_prepago AS
SELECT
    dp.nombre_plan,
    dp.categoria_precio,
    ds.nombre_servicio,
    dp.precio_mensual,
    COUNT(*) AS total_contrataciones
FROM fact_contratos fc
JOIN dim_plan dp ON dp.sk_plan = fc.sk_plan
JOIN dim_servicio ds ON ds.sk_servicio = fc.sk_servicio
WHERE fc.es_prepago = 1
GROUP BY dp.nombre_plan, dp.categoria_precio, ds.nombre_servicio, dp.precio_mensual;
GO

-- P3: En que epoca del anio aumenta mas la demanda de servicios
CREATE VIEW v_demanda_por_epoca AS
SELECT
    dt.anio,
    dt.trimestre,
    dt.mes,
    dt.nombre_mes,
    dt.temporada,
    ds.nombre_servicio,
    COUNT(fc.sk_contrato) AS nuevos_contratos
FROM dim_tiempo dt
LEFT JOIN fact_contratos fc ON fc.sk_tiempo_inicio = dt.sk_tiempo
LEFT JOIN dim_servicio ds ON ds.sk_servicio = fc.sk_servicio
GROUP BY dt.anio, dt.trimestre, dt.mes, dt.nombre_mes, dt.temporada, ds.nombre_servicio;
GO

-- P4: Preferencia de pago en linea vs presencial
CREATE VIEW v_preferencia_pago AS
SELECT
    dcp.metodo_pago,
    dcp.canal_detalle,
    dcp.tipo_canal,
    COUNT(*) AS total_pagos,
    SUM(fp.monto) AS monto_total,
    AVG(fp.monto) AS monto_promedio
FROM fact_pagos fp
JOIN dim_canal_pago dcp ON dcp.sk_canal_pago = fp.sk_canal_pago
WHERE fp.pago_completado = 1
GROUP BY dcp.metodo_pago, dcp.canal_detalle, dcp.tipo_canal;
GO

-- P5: Cuales son los servicios con mas demanda por los clientes
CREATE VIEW v_demanda_servicios AS
SELECT
    ds.nombre_servicio,
    dp.tipo_plan,
    COUNT(*) AS total_contratos,
    SUM(CASE WHEN fc.fue_cancelado = 0 THEN 1 ELSE 0 END) AS contratos_activos
FROM fact_contratos fc
JOIN dim_servicio ds ON ds.sk_servicio = fc.sk_servicio
JOIN dim_plan dp ON dp.sk_plan = fc.sk_plan
GROUP BY ds.nombre_servicio, dp.tipo_plan;
GO

-- P6: Que rango de edad utiliza mas cada tipo de servicio
CREATE VIEW v_uso_por_edad AS
SELECT
    dc.rango_edad,
    ds.nombre_servicio,
    COUNT(DISTINCT fcon.sk_cliente) AS clientes_unicos,
    COUNT(fcon.sk_consumo) AS total_eventos,
    SUM(fcon.duracion_minutos) AS total_minutos_voz,
    SUM(fcon.cantidad_gb) AS total_gb,
    SUM(fcon.cantidad_sms) AS total_sms,
    SUM(fcon.horas_tv) AS total_horas_tv
FROM fact_consumos fcon
JOIN dim_cliente dc ON dc.sk_cliente = fcon.sk_cliente
JOIN dim_servicio ds ON ds.sk_servicio = fcon.sk_servicio
GROUP BY dc.rango_edad, ds.nombre_servicio;
GO

-- P7: Que tipos de paquetes son mas atractivos para los clientes
CREATE VIEW v_atractivo_paquetes AS
SELECT
    dp.nombre_plan,
    dp.categoria_precio,
    dp.tipo_plan,
    dp.precio_mensual,
    dp.tiene_voz,
    dp.tiene_datos_moviles,
    dp.tiene_llamadas_ilimitadas,
    dp.tiene_redes_sociales,
    dp.tiene_internet_hogar,
    dp.tiene_tv,
    COUNT(fc.sk_contrato) AS veces_contratado
FROM dim_plan dp
LEFT JOIN fact_contratos fc ON fc.sk_plan = dp.sk_plan
GROUP BY
    dp.nombre_plan, dp.categoria_precio, dp.tipo_plan, dp.precio_mensual,
    dp.tiene_voz, dp.tiene_datos_moviles, dp.tiene_llamadas_ilimitadas,
    dp.tiene_redes_sociales, dp.tiene_internet_hogar, dp.tiene_tv;
GO

-- P8: Tiempo promedio de permanencia antes de cancelar por tipo de servicio
CREATE VIEW v_permanencia_por_servicio AS
SELECT
    ds.nombre_servicio,
    dp.categoria_precio,
    dp.tipo_plan,
    COUNT(*) AS total_cancelaciones,
    AVG(CAST(fc.meses_permanencia AS DECIMAL(10,1))) AS promedio_meses,
    MIN(fc.meses_permanencia) AS minimo_meses,
    MAX(fc.meses_permanencia) AS maximo_meses
FROM fact_contratos fc
JOIN dim_servicio ds ON ds.sk_servicio = fc.sk_servicio
JOIN dim_plan dp ON dp.sk_plan = fc.sk_plan
WHERE fc.fue_cancelado = 1
  AND fc.meses_permanencia IS NOT NULL
GROUP BY ds.nombre_servicio, dp.categoria_precio, dp.tipo_plan;
GO

-- P9: Que departamento de Honduras tiene mas contrataciones nuevas por trimestre
CREATE VIEW v_contrataciones_por_departamento AS
SELECT
    dc.departamento,
    dc.region_hn,
    dt.anio,
    dt.trimestre,
    dt.nombre_mes,
    dt.mes,
    ds.nombre_servicio,
    COUNT(*) AS total_contrataciones,
    SUM(CASE WHEN fc.es_prepago = 1 THEN 1 ELSE 0 END) AS contratos_prepago,
    SUM(CASE WHEN fc.es_prepago = 0 THEN 1 ELSE 0 END) AS contratos_postpago
FROM fact_contratos fc
JOIN dim_cliente dc ON dc.sk_cliente = fc.sk_cliente
JOIN dim_tiempo dt ON dt.sk_tiempo = fc.sk_tiempo_inicio
JOIN dim_servicio ds ON ds.sk_servicio = fc.sk_servicio
GROUP BY dc.departamento, dc.region_hn, dt.anio, dt.trimestre, dt.nombre_mes, dt.mes, ds.nombre_servicio;
GO

-- P10: Cual es el ingreso total por tipo de servicio y mes
CREATE VIEW v_ingresos_por_servicio AS
SELECT
    ds.nombre_servicio,
    dp.categoria_precio,
    dt.anio,
    dt.trimestre,
    dt.mes,
    dt.nombre_mes,
    dt.temporada,
    COUNT(*) AS total_pagos,
    SUM(fp.monto) AS ingreso_total,
    AVG(fp.monto) AS ingreso_promedio
FROM fact_pagos fp
JOIN dim_servicio ds ON ds.sk_servicio = fp.sk_servicio
JOIN dim_plan dp ON dp.sk_plan = fp.sk_plan
JOIN dim_tiempo dt ON dt.sk_tiempo = fp.sk_tiempo
WHERE fp.pago_completado = 1
GROUP BY ds.nombre_servicio, dp.categoria_precio, dt.anio, dt.trimestre, dt.mes, dt.nombre_mes, dt.temporada;
GO

-- Verificacion de las vistas
SELECT * FROM v_cancelaciones;
SELECT * FROM v_planes_prepago;
SELECT * FROM v_demanda_por_epoca;
SELECT * FROM v_preferencia_pago;
SELECT * FROM v_demanda_servicios;
SELECT * FROM v_uso_por_edad;
SELECT * FROM v_atractivo_paquetes;
SELECT * FROM v_permanencia_por_servicio;
SELECT * FROM v_contrataciones_por_departamento;
SELECT * FROM v_ingresos_por_servicio;
GO
