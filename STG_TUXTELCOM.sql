-- ============================================
-- BASE DE DATOS STAGING - TUXTELCOM
-- Proyecto Final - Bases de Datos II
-- ============================================

CREATE DATABASE STG_TUXTELCOM;
GO

USE STG_TUXTELCOM;
GO

-- ============================================
-- TABLAS DE STAGING
-- ============================================

-- Sucursales de la empresa
CREATE TABLE stg_sucursales (
    sucursal_id INT NOT NULL,
    nombre_sucursal VARCHAR(100) NOT NULL,
    departamento VARCHAR(70) NOT NULL,
    municipio VARCHAR(70) NOT NULL,
    direccion VARCHAR(300) NULL,
    telefono VARCHAR(15) NULL,
    tipo_sucursal VARCHAR(30) NULL,   -- PROPIA / AGENTE_AUTORIZADO
    estado VARCHAR(20) NULL,   -- ACTIVA / INACTIVA
    fecha_apertura  DATE NULL,
    PRIMARY KEY (sucursal_id)
);
GO

-- Clientes registrados
CREATE TABLE stg_clientes (
    cliente_id INT NOT NULL,
    cedula_identidad VARCHAR(30) NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero CHAR(1) NULL,    -- M / F
    email VARCHAR(100) NULL,
    telefono_contacto VARCHAR(20) NULL,
    departamento VARCHAR(70) NOT NULL,
    municipio VARCHAR(70) NOT NULL,
    direccion VARCHAR(300) NOT NULL,
    fecha_registro DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,  -- ACTIVO / INACTIVO
    PRIMARY KEY (cliente_id)
);
GO

-- Tipos de servicio (movil, fijo, internet, tv)
CREATE TABLE stg_tipo_servicio (
    tipo_servicio_id INT NOT NULL,
    nombre_servicio VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200) NULL,
    activo INT DEFAULT 1,
    PRIMARY KEY (tipo_servicio_id)
);
GO

-- Planes comerciales de la empresa
CREATE TABLE stg_planes (
    plan_id INT NOT NULL,
    tipo_servicio_id INT NOT NULL,
    nombre_plan VARCHAR(100) NOT NULL,
    tipo_plan VARCHAR(20) NOT NULL,  -- PREPAGO / POSTPAGO
    categoria_precio VARCHAR(20) NOT NULL,  -- BASICO / MEDIO / PREMIUM
    precio_mensual DECIMAL(10,2) NOT NULL,
    minutos_incluidos INT DEFAULT 0,
    sms_incluidos INT DEFAULT 0,
    datos_gb DECIMAL(8,2) DEFAULT 0,
    velocidad_mbps DECIMAL(8,2) DEFAULT 0,
    canales_tv INT DEFAULT 0,
    incluye_llamadas_ilimitadas INT DEFAULT 0,
    incluye_redes_sociales INT DEFAULT 0,
    vigencia_dias INT DEFAULT 30,
    activo INT DEFAULT 1,
    fecha_lanzamiento DATE NULL,
    PRIMARY KEY (plan_id),
    CONSTRAINT fk_plan_servicio FOREIGN KEY (tipo_servicio_id)
        REFERENCES stg_tipo_servicio(tipo_servicio_id)
);
GO

-- Contratos de clientes con planes
CREATE TABLE stg_contratos (
    contrato_id INT NOT NULL,
    cliente_id  INT NOT NULL,
    plan_id INT NOT NULL,
    numero_linea VARCHAR(20) NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    estado_contrato VARCHAR(20) NOT NULL, -- ACTIVO / CANCELADO / SUSPENDIDO
    fecha_cancelacion DATE NULL,
    motivo_cancelacion VARCHAR(30) NULL, -- PRECIO / COBERTURA / SERVICIO / PORTABILIDAD / OTRO
    meses_permanencia INT NULL,  -- calculado al momento de cancelar
    canal_venta VARCHAR(40) NULL,  -- SUCURSAL / WEB / APP / CALL_CENTER
    sucursal_id INT NULL,
    PRIMARY KEY (contrato_id),
    CONSTRAINT fk_cont_cliente  FOREIGN KEY (cliente_id)  REFERENCES stg_clientes(cliente_id),
    CONSTRAINT fk_cont_plan     FOREIGN KEY (plan_id)     REFERENCES stg_planes(plan_id),
    CONSTRAINT fk_cont_sucursal FOREIGN KEY (sucursal_id) REFERENCES stg_sucursales(sucursal_id)
);
GO

-- Pagos realizados por los clientes
CREATE TABLE stg_pagos (
    pago_id BIGINT NOT NULL,
    contrato_id INT NOT NULL,
    cliente_id INT NOT NULL,
    fecha_pago DATETIME NOT NULL,
    monto DECIMAL(12,2) NOT NULL,
    metodo_pago VARCHAR(20) NOT NULL,   -- EN_LINEA / PRESENCIAL
    canal_pago VARCHAR(50) NOT NULL,   -- APP_MOVIL / PORTAL_WEB / SUCURSAL / AGENTE_AUTORIZADO
    sucursal_id INT NULL,
    referencia_pago VARCHAR(60) NULL,
    estado_pago VARCHAR(20) NOT NULL,   -- COMPLETADO / FALLIDO / PENDIENTE
    PRIMARY KEY (pago_id),
    CONSTRAINT fk_pago_contrato FOREIGN KEY (contrato_id) REFERENCES stg_contratos(contrato_id),
    CONSTRAINT fk_pago_cliente  FOREIGN KEY (cliente_id)  REFERENCES stg_clientes(cliente_id),
    CONSTRAINT fk_pago_sucursal FOREIGN KEY (sucursal_id) REFERENCES stg_sucursales(sucursal_id)
);
GO

-- Consumos registrados por contrato
CREATE TABLE stg_consumos (
    consumo_id BIGINT NOT NULL,
    contrato_id INT NOT NULL,
    cliente_id INT NOT NULL,
    fecha_consumo DATE NOT NULL,
    tipo_consumo VARCHAR(30) NOT NULL,  -- VOZ / SMS / DATOS / TV / INTERNET_FIJO
    duracion_segundos INT DEFAULT 0,
    cantidad_mb DECIMAL(12,4) DEFAULT 0,
    cantidad_sms INT DEFAULT 0,
    horas_tv DECIMAL(8,2)  DEFAULT 0,
    incluido_plan INT DEFAULT 1,
    costo_extra DECIMAL(10,4) DEFAULT 0,
    PRIMARY KEY (consumo_id),
    CONSTRAINT fk_con_contrato FOREIGN KEY (contrato_id) REFERENCES stg_contratos(contrato_id),
    CONSTRAINT fk_con_cliente  FOREIGN KEY (cliente_id)  REFERENCES stg_clientes(cliente_id)
);
GO

-- Reclamos de clientes
-- Solo lo basico para saber si el cliente tuvo problemas antes de cancelar (apoya P1)
CREATE TABLE stg_reclamos (
    reclamo_id INT NOT NULL,
    cliente_id INT NOT NULL,
    contrato_id INT NOT NULL,
    fecha_reclamo DATETIME NOT NULL,
    tipo_reclamo VARCHAR(60) NOT NULL, -- FACTURACION / COBERTURA / VELOCIDAD / ATENCION / OTRO
    estado_reclamo VARCHAR(20) NOT NULL, -- ABIERTO / EN_PROCESO / RESUELTO
    PRIMARY KEY (reclamo_id),
    CONSTRAINT fk_rec_cliente  FOREIGN KEY (cliente_id)  REFERENCES stg_clientes(cliente_id),
    CONSTRAINT fk_rec_contrato FOREIGN KEY (contrato_id) REFERENCES stg_contratos(contrato_id)
);
GO

-- ============================================
-- DATOS BASE
-- ============================================

INSERT INTO stg_tipo_servicio (tipo_servicio_id, nombre_servicio, descripcion, activo) VALUES
(1, 'MOVIL','Telefonia movil con llamadas y datos', 1),
(2, 'FIJO', 'Telefonia fija residencial y empresarial', 1),
(3, 'INTERNET', 'Internet de banda ancha para el hogar', 1),
(4, 'TV', 'Television por cable', 1);
GO

SELECT 'stg_tipo_servicio' AS tabla, COUNT(*) AS registros FROM stg_tipo_servicio;
GO
