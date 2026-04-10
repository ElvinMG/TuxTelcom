-- ============================================
-- ETL - CARGA DEL DATA WAREHOUSE TUXTELCOM
-- Proyecto Final - Bases de Datos II
-- Origen:  STG_TUXTELCOM
-- Destino: DWH_TUXTELCOM
-- ============================================

USE DWH_TUXTELCOM;
GO

-- ============================================
-- MIEMBRO DESCONOCIDO (Unknown Member)
-- Se usa cuando una clave foranea no tiene
-- coincidencia en la dimension correspondiente
-- ============================================

SET IDENTITY_INSERT dim_sucursal ON;
IF NOT EXISTS (SELECT 1 FROM dim_sucursal WHERE sk_sucursal = -1)
    INSERT INTO dim_sucursal (sk_sucursal, nk_sucursal_id, nombre_sucursal, departamento, municipio, tipo_sucursal)
    VALUES (-1, -1, 'Desconocido', 'Desconocido', 'Desconocido', 'Desconocido');
SET IDENTITY_INSERT dim_sucursal OFF;
GO

SET IDENTITY_INSERT dim_plan ON;
IF NOT EXISTS (SELECT 1 FROM dim_plan WHERE sk_plan = -1)
    INSERT INTO dim_plan (sk_plan, nk_plan_id, nombre_plan, tipo_plan, categoria_precio, precio_mensual,
                          tiene_voz, tiene_datos_moviles, tiene_llamadas_ilimitadas,
                          tiene_redes_sociales, tiene_internet_hogar, tiene_tv,
                          datos_gb_incluidos, velocidad_mbps)
    VALUES (-1, -1, 'Desconocido', 'Desconocido', 'Desconocido', 0, 0, 0, 0, 0, 0, 0, 0, 0);
SET IDENTITY_INSERT dim_plan OFF;
GO

SET IDENTITY_INSERT dim_servicio ON;
IF NOT EXISTS (SELECT 1 FROM dim_servicio WHERE sk_servicio = -1)
    INSERT INTO dim_servicio (sk_servicio, nk_tipo_servicio_id, nombre_servicio, descripcion)
    VALUES (-1, -1, 'Desconocido', 'Servicio no identificado');
SET IDENTITY_INSERT dim_servicio OFF;
GO

SET IDENTITY_INSERT dim_cliente ON;
IF NOT EXISTS (SELECT 1 FROM dim_cliente WHERE sk_cliente = -1)
    INSERT INTO dim_cliente (sk_cliente, nk_cliente_id, nombre_completo, genero, rango_edad,
                             edad_actual, departamento, municipio, region_hn,
                             estado_cliente, fecha_registro)
    VALUES (-1, -1, 'Desconocido', 'Desconocido', 'Desconocido',
            0, 'Desconocido', 'Desconocido', 'Desconocido', 'Desconocido', '1900-01-01');
SET IDENTITY_INSERT dim_cliente OFF;
GO

SET IDENTITY_INSERT dim_canal_pago ON;
IF NOT EXISTS (SELECT 1 FROM dim_canal_pago WHERE sk_canal_pago = -1)
    INSERT INTO dim_canal_pago (sk_canal_pago, metodo_pago, canal_detalle, tipo_canal)
    VALUES (-1, 'Desconocido', 'Desconocido', 'Desconocido');
SET IDENTITY_INSERT dim_canal_pago OFF;
GO

SET IDENTITY_INSERT dim_motivo_cancelacion ON;
IF NOT EXISTS (SELECT 1 FROM dim_motivo_cancelacion WHERE sk_motivo = -1)
    INSERT INTO dim_motivo_cancelacion (sk_motivo, motivo_codigo, motivo_descripcion)
    VALUES (-1, 'DESCONOCIDO', 'Motivo no especificado');
SET IDENTITY_INSERT dim_motivo_cancelacion OFF;
GO

-- ============================================
-- ETL 1: DIMENSION SUCURSAL
-- ============================================

CREATE PROCEDURE etl_dim_sucursal
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE dim_sucursal;

        -- Reinsertamos el miembro desconocido despues del truncate
        SET IDENTITY_INSERT dim_sucursal ON;
        INSERT INTO dim_sucursal (sk_sucursal, nk_sucursal_id, nombre_sucursal, departamento, municipio, tipo_sucursal)
        VALUES (-1, -1, 'Desconocido', 'Desconocido', 'Desconocido', 'Desconocido');
        SET IDENTITY_INSERT dim_sucursal OFF;

        INSERT INTO dim_sucursal (nk_sucursal_id, nombre_sucursal, departamento, municipio, tipo_sucursal)
        SELECT
            sucursal_id,
            nombre_sucursal,
            departamento,
            municipio,
            ISNULL(tipo_sucursal, 'PROPIA')
        FROM STG_TUXTELCOM.dbo.stg_sucursales;

        COMMIT TRANSACTION;
        PRINT 'etl_dim_sucursal: OK - ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' registros';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'etl_dim_sucursal: ERROR - ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- ============================================
-- ETL 2: DIMENSION PLAN
-- ============================================

CREATE PROCEDURE etl_dim_plan
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE dim_plan;

        SET IDENTITY_INSERT dim_plan ON;
        INSERT INTO dim_plan (sk_plan, nk_plan_id, nombre_plan, tipo_plan, categoria_precio, precio_mensual,
                              tiene_voz, tiene_datos_moviles, tiene_llamadas_ilimitadas,
                              tiene_redes_sociales, tiene_internet_hogar, tiene_tv,
                              datos_gb_incluidos, velocidad_mbps)
        VALUES (-1, -1, 'Desconocido', 'Desconocido', 'Desconocido', 0, 0, 0, 0, 0, 0, 0, 0, 0);
        SET IDENTITY_INSERT dim_plan OFF;

        INSERT INTO dim_plan (
            nk_plan_id, nombre_plan, tipo_plan, categoria_precio, precio_mensual,
            tiene_voz, tiene_datos_moviles, tiene_llamadas_ilimitadas,
            tiene_redes_sociales, tiene_internet_hogar, tiene_tv,
            datos_gb_incluidos, velocidad_mbps
        )
        SELECT
            p.plan_id,
            p.nombre_plan,
            p.tipo_plan,
            p.categoria_precio,
            p.precio_mensual,
            CASE WHEN p.minutos_incluidos > 0 OR p.incluye_llamadas_ilimitadas = 1 THEN 1 ELSE 0 END,
            CASE WHEN p.datos_gb > 0 AND ts.nombre_servicio = 'MOVIL' THEN 1 ELSE 0 END,
            p.incluye_llamadas_ilimitadas,
            p.incluye_redes_sociales,
            CASE WHEN p.velocidad_mbps > 0 THEN 1 ELSE 0 END,
            CASE WHEN p.canales_tv > 0 THEN 1 ELSE 0 END,
            p.datos_gb,
            p.velocidad_mbps
        FROM STG_TUXTELCOM.dbo.stg_planes p
        JOIN STG_TUXTELCOM.dbo.stg_tipo_servicio ts
            ON ts.tipo_servicio_id = p.tipo_servicio_id;

        COMMIT TRANSACTION;
        PRINT 'etl_dim_plan: OK - ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' registros';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'etl_dim_plan: ERROR - ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- ============================================
-- ETL 3: DIMENSION CLIENTE (SCD Tipo 1)
-- ============================================

CREATE PROCEDURE etl_dim_cliente
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        TRUNCATE TABLE dim_cliente;

        SET IDENTITY_INSERT dim_cliente ON;
        INSERT INTO dim_cliente (sk_cliente, nk_cliente_id, nombre_completo, genero, rango_edad,
                                 edad_actual, departamento, municipio, region_hn,
                                 estado_cliente, fecha_registro)
        VALUES (-1, -1, 'Desconocido', 'Desconocido', 'Desconocido',
                0, 'Desconocido', 'Desconocido', 'Desconocido', 'Desconocido', '1900-01-01');
        SET IDENTITY_INSERT dim_cliente OFF;

        INSERT INTO dim_cliente (
            nk_cliente_id, nombre_completo, genero, rango_edad, edad_actual,
            departamento, municipio, region_hn, estado_cliente, fecha_registro
        )
        SELECT
            c.cliente_id,
            -- Concatenacion con + (mas natural para un estudiante que CONCAT)
            c.nombre + ' ' + c.apellido,
            CASE c.genero
                WHEN 'M' THEN 'Masculino'
                WHEN 'F' THEN 'Femenino'
                ELSE 'No especificado'
            END,
            -- Rangos de edad para responder P6
            CASE
                WHEN DATEDIFF(YEAR, c.fecha_nacimiento, GETDATE()) BETWEEN 18 AND 25 THEN '18-25'
                WHEN DATEDIFF(YEAR, c.fecha_nacimiento, GETDATE()) BETWEEN 26 AND 35 THEN '26-35'
                WHEN DATEDIFF(YEAR, c.fecha_nacimiento, GETDATE()) BETWEEN 36 AND 45 THEN '36-45'
                WHEN DATEDIFF(YEAR, c.fecha_nacimiento, GETDATE()) BETWEEN 46 AND 60 THEN '46-60'
                ELSE '60+'
            END,
            DATEDIFF(YEAR, c.fecha_nacimiento, GETDATE()),
            c.departamento,
            c.municipio,
            -- Region de Honduras para responder P9
            CASE c.departamento
                WHEN 'Cortes'            THEN 'Norte'
                WHEN 'Atlantida'         THEN 'Norte'
                WHEN 'Colon'             THEN 'Norte'
                WHEN 'Yoro'              THEN 'Norte'
                WHEN 'Francisco Morazan' THEN 'Central'
                WHEN 'Comayagua'         THEN 'Central'
                WHEN 'El Paraiso'        THEN 'Central'
                WHEN 'Olancho'           THEN 'Central'
                WHEN 'Choluteca'         THEN 'Sur'
                WHEN 'Valle'             THEN 'Sur'
                WHEN 'Copan'             THEN 'Occidente'
                WHEN 'Lempira'           THEN 'Occidente'
                WHEN 'Intibuca'          THEN 'Occidente'
                WHEN 'Santa Barbara'     THEN 'Occidente'
                ELSE 'Central'
            END,
            c.estado,
            c.fecha_registro
        FROM STG_TUXTELCOM.dbo.stg_clientes c;

        COMMIT TRANSACTION;
        PRINT 'etl_dim_cliente: OK - ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' registros';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'etl_dim_cliente: ERROR - ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- ============================================
-- ETL 4: FACT_CONTRATOS
-- ============================================

CREATE PROCEDURE etl_fact_contratos
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO fact_contratos (
            sk_tiempo_inicio, sk_cliente, sk_plan, sk_servicio,
            sk_sucursal, sk_motivo_cancelacion,
            nk_contrato_id, fue_cancelado, meses_permanencia,
            es_prepago, canal_venta, tuvo_reclamos_previos
        )
        SELECT
            COALESCE(dt.sk_tiempo,  -1),
            COALESCE(dc.sk_cliente, -1),
            COALESCE(dp.sk_plan,    -1),
            COALESCE(dsv.sk_servicio, -1),
            COALESCE(dsu.sk_sucursal, -1),
            COALESCE(dmc.sk_motivo, -1),
            co.contrato_id,
            CASE WHEN co.estado_contrato = 'CANCELADO' THEN 1 ELSE 0 END,
            co.meses_permanencia,
            CASE WHEN pl.tipo_plan = 'PREPAGO' THEN 1 ELSE 0 END,
            co.canal_venta,
            -- Si el cliente tuvo algun reclamo asociado a este contrato (apoya P1)
            CASE WHEN EXISTS (
                SELECT 1 FROM STG_TUXTELCOM.dbo.stg_reclamos r
                WHERE r.contrato_id = co.contrato_id
            ) THEN 1 ELSE 0 END
        FROM STG_TUXTELCOM.dbo.stg_contratos co
        LEFT JOIN dim_tiempo dt
            ON dt.fecha = co.fecha_inicio
        LEFT JOIN dim_cliente dc
            ON dc.nk_cliente_id = co.cliente_id
        LEFT JOIN dim_plan dp
            ON dp.nk_plan_id = co.plan_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_planes pl
            ON pl.plan_id = co.plan_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_tipo_servicio ts
            ON ts.tipo_servicio_id = pl.tipo_servicio_id
        LEFT JOIN dim_servicio dsv
            ON dsv.nombre_servicio = ts.nombre_servicio
        LEFT JOIN dim_sucursal dsu
            ON dsu.nk_sucursal_id = co.sucursal_id
        LEFT JOIN dim_motivo_cancelacion dmc
            ON dmc.motivo_codigo = co.motivo_cancelacion
        -- Evitar duplicados si se ejecuta mas de una vez
        WHERE NOT EXISTS (
            SELECT 1 FROM fact_contratos fc2
            WHERE fc2.nk_contrato_id = co.contrato_id
        );

        COMMIT TRANSACTION;
        PRINT 'etl_fact_contratos: OK - ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' registros';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'etl_fact_contratos: ERROR - ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- ============================================
-- ETL 5: FACT_PAGOS
-- ============================================

CREATE PROCEDURE etl_fact_pagos
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO fact_pagos (
            sk_tiempo, sk_cliente, sk_plan, sk_servicio,
            sk_canal_pago, nk_pago_id, monto, pago_completado
        )
        SELECT
            COALESCE(dt.sk_tiempo,       -1),
            COALESCE(dc.sk_cliente,      -1),
            COALESCE(dp.sk_plan,         -1),
            COALESCE(dsv.sk_servicio,    -1),
            COALESCE(dcp.sk_canal_pago,  -1),
            pg.pago_id,
            pg.monto,
            CASE WHEN pg.estado_pago = 'COMPLETADO' THEN 1 ELSE 0 END
        FROM STG_TUXTELCOM.dbo.stg_pagos pg
        LEFT JOIN dim_tiempo dt
            ON dt.fecha = CAST(pg.fecha_pago AS DATE)
        LEFT JOIN dim_cliente dc
            ON dc.nk_cliente_id = pg.cliente_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_contratos co
            ON co.contrato_id = pg.contrato_id
        LEFT JOIN dim_plan dp
            ON dp.nk_plan_id = co.plan_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_planes pl
            ON pl.plan_id = co.plan_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_tipo_servicio ts
            ON ts.tipo_servicio_id = pl.tipo_servicio_id
        LEFT JOIN dim_servicio dsv
            ON dsv.nombre_servicio = ts.nombre_servicio
        LEFT JOIN dim_canal_pago dcp
            ON dcp.metodo_pago   = pg.metodo_pago
           AND dcp.canal_detalle = pg.canal_pago
        WHERE NOT EXISTS (
            SELECT 1 FROM fact_pagos fp2
            WHERE fp2.nk_pago_id = pg.pago_id
        );

        COMMIT TRANSACTION;
        PRINT 'etl_fact_pagos: OK - ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' registros';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'etl_fact_pagos: ERROR - ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- ============================================
-- ETL 6: FACT_CONSUMOS
-- ============================================

CREATE PROCEDURE etl_fact_consumos
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO fact_consumos (
            sk_tiempo, sk_cliente, sk_plan, sk_servicio,
            nk_consumo_id, tipo_consumo,
            duracion_minutos, cantidad_gb, cantidad_sms, horas_tv
        )
        SELECT
            COALESCE(dt.sk_tiempo,    -1),
            COALESCE(dc.sk_cliente,   -1),
            COALESCE(dp.sk_plan,      -1),
            COALESCE(dsv.sk_servicio, -1),
            con.consumo_id,
            con.tipo_consumo,
            -- Transformacion: segundos a minutos
            CAST(ISNULL(con.duracion_segundos, 0) AS DECIMAL(10,2)) / 60.0,
            -- Transformacion: MB a GB
            CAST(ISNULL(con.cantidad_mb, 0) AS DECIMAL(12,4)) / 1024.0,
            ISNULL(con.cantidad_sms, 0),
            ISNULL(con.horas_tv, 0)
        FROM STG_TUXTELCOM.dbo.stg_consumos con
        LEFT JOIN dim_tiempo dt
            ON dt.fecha = con.fecha_consumo
        LEFT JOIN dim_cliente dc
            ON dc.nk_cliente_id = con.cliente_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_contratos co
            ON co.contrato_id = con.contrato_id
        LEFT JOIN dim_plan dp
            ON dp.nk_plan_id = co.plan_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_planes pl
            ON pl.plan_id = co.plan_id
        LEFT JOIN STG_TUXTELCOM.dbo.stg_tipo_servicio ts
            ON ts.tipo_servicio_id = pl.tipo_servicio_id
        LEFT JOIN dim_servicio dsv
            ON dsv.nombre_servicio = ts.nombre_servicio
        WHERE NOT EXISTS (
            SELECT 1 FROM fact_consumos fc2
            WHERE fc2.nk_consumo_id = con.consumo_id
        );

        COMMIT TRANSACTION;
        PRINT 'etl_fact_consumos: OK - ' + CAST(@@ROWCOUNT AS VARCHAR(10)) + ' registros';
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        PRINT 'etl_fact_consumos: ERROR - ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- ============================================
-- PROCEDIMIENTO MAESTRO
-- Ejecuta todo el ETL en el orden correcto
-- ============================================

CREATE PROCEDURE etl_ejecutar_todo
AS
BEGIN
    SET NOCOUNT ON;
    PRINT '=== INICIO DEL PROCESO ETL ==='
    PRINT 'Fecha: ' + CONVERT(VARCHAR, GETDATE(), 120);
    PRINT '';

    PRINT '-- Cargando dimensiones --'
    EXEC etl_dim_sucursal;
    EXEC etl_dim_plan;
    EXEC etl_dim_cliente;

    PRINT '';
    PRINT '-- Cargando tablas de hechos --'
    EXEC etl_fact_contratos;
    EXEC etl_fact_pagos;
    EXEC etl_fact_consumos;

    PRINT '';
    PRINT '=== RESUMEN FINAL ==='
    SELECT 'dim_tiempo'             AS tabla, COUNT(*) AS registros FROM dim_tiempo
    UNION ALL
    SELECT 'dim_cliente',            COUNT(*) FROM dim_cliente
    UNION ALL
    SELECT 'dim_plan',               COUNT(*) FROM dim_plan
    UNION ALL
    SELECT 'dim_servicio',           COUNT(*) FROM dim_servicio
    UNION ALL
    SELECT 'dim_canal_pago',         COUNT(*) FROM dim_canal_pago
    UNION ALL
    SELECT 'dim_sucursal',           COUNT(*) FROM dim_sucursal
    UNION ALL
    SELECT 'dim_motivo_cancelacion', COUNT(*) FROM dim_motivo_cancelacion
    UNION ALL
    SELECT 'fact_contratos',         COUNT(*) FROM fact_contratos
    UNION ALL
    SELECT 'fact_pagos',             COUNT(*) FROM fact_pagos
    UNION ALL
    SELECT 'fact_consumos',          COUNT(*) FROM fact_consumos;
END
GO

-- ============================================
-- EJECUTAR
-- ============================================

EXEC etl_ejecutar_todo;
GO
