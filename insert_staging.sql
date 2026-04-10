USE STG_TUXTELCOM;
GO

-- ============================================
-- 1. SUCURSALES (5 registros)
-- ============================================
INSERT INTO stg_sucursales (sucursal_id, nombre_sucursal, departamento, municipio, direccion, telefono, tipo_sucursal, estado, fecha_apertura) VALUES
(1, 'Sucursal Centro', 'Francisco Morazan', 'Tegucigalpa', 'Boulevard Juan Pablo II', '2230-1234', 'PROPIA', 'ACTIVA', '2020-01-15'),
(2, 'Sucursal Norte', 'Cortes', 'San Pedro Sula', 'Boulevard Morazan', '2550-5678', 'PROPIA', 'ACTIVA', '2020-03-20'),
(3, 'Sucursal Occidente', 'Copan', 'Santa Rosa de Copan', 'Barrio El Centro', '2660-4321', 'PROPIA', 'ACTIVA', '2020-06-10'),
(4, 'Agencia La Ceiba', 'Atlantida', 'La Ceiba', 'Barrio La Isla', '2440-9876', 'AGENTE_AUTORIZADO', 'ACTIVA', '2021-01-10'),
(5, 'Agencia Choluteca', 'Choluteca', 'Choluteca', 'Colonia Los Pinos', '2780-5432', 'AGENTE_AUTORIZADO', 'INACTIVA', '2021-03-15');
GO

-- ============================================
-- 2. CLIENTES (30 registros)
-- ============================================
INSERT INTO stg_clientes (cliente_id, cedula_identidad, nombre, apellido, fecha_nacimiento, genero, email, telefono_contacto, departamento, municipio, direccion, fecha_registro, estado) VALUES
(1, '0801-1990-12345', 'Juan', 'Perez', '1990-05-15', 'M', 'juan.perez@gmail.com', '9876-5432', 'Francisco Morazan', 'Tegucigalpa', 'Colonia Palmira', '2023-01-10', 'ACTIVO'),
(2, '0801-1985-67890', 'Maria', 'Lopez', '1985-08-20', 'F', 'maria.lopez@gmail.com', '9876-1234', 'Francisco Morazan', 'Tegucigalpa', 'Residencial Los Robles', '2023-01-15', 'ACTIVO'),
(3, '0501-1995-11121', 'Carlos', 'Ramirez', '1995-12-01', 'M', 'carlos.ram@yahoo.com', '9988-7766', 'Cortes', 'San Pedro Sula', 'Colonia Jardines', '2023-02-01', 'ACTIVO'),
(4, '0501-1980-22232', 'Ana', 'Martinez', '1980-03-10', 'F', 'ana.mtz@hotmail.com', '9988-5544', 'Cortes', 'San Pedro Sula', 'Residencial Villas', '2023-02-10', 'ACTIVO'),
(5, '1201-1992-33343', 'Luis', 'Fernandez', '1992-07-22', 'M', 'luis.fer@outlook.com', '9666-3322', 'Comayagua', 'Comayagua', 'Barrio La Merced', '2023-02-15', 'ACTIVO'),
(6, '0801-1988-44454', 'Elena', 'Garcia', '1988-11-30', 'F', 'elena.garcia@gmail.com', '9876-1111', 'Francisco Morazan', 'Tegucigalpa', 'Colonia Kennedy', '2023-03-01', 'ACTIVO'),
(7, '0501-1998-55565', 'Jose', 'Rodriguez', '1998-02-14', 'M', 'jose.rod@yahoo.com', '9988-2222', 'Cortes', 'San Pedro Sula', 'Barrio Guamilito', '2023-03-05', 'ACTIVO'),
(8, '0301-1993-66676', 'Martha', 'Sanchez', '1993-09-18', 'F', 'martha.san@gmail.com', '2777-8888', 'Copan', 'Santa Rosa de Copan', 'Colonia El Benque', '2023-03-10', 'ACTIVO'),
(9, '1601-1982-77787', 'Pedro', 'Morales', '1982-04-25', 'M', 'pedro.morales@hotmail.com', '2444-5555', 'Atlantida', 'La Ceiba', 'Barrio El Iman', '2023-03-15', 'ACTIVO'),
(10, '0801-2000-88898', 'Sofia', 'Castro', '2000-06-12', 'F', 'sofia.castro@gmail.com', '9876-6666', 'Francisco Morazan', 'Tegucigalpa', 'Residencial Lomas', '2023-04-01', 'ACTIVO'),
(11, '0501-1975-99909', 'Roberto', 'Ortega', '1975-10-05', 'M', 'roberto.ortega@gmail.com', '9988-9999', 'Cortes', 'San Pedro Sula', 'Colonia Trejo', '2023-04-05', 'ACTIVO'),
(12, '0801-1996-10112', 'Patricia', 'Flores', '1996-01-20', 'F', 'paty.flores@yahoo.com', '9876-7777', 'Francisco Morazan', 'Tegucigalpa', 'Colonia El Hatillo', '2023-04-10', 'ACTIVO'),
(13, '0201-1991-11123', 'Fernando', 'Mendoza', '1991-08-08', 'M', 'fer.mendoza@gmail.com', '2777-1111', 'Comayagua', 'Siguatepeque', 'Barrio El Centro', '2023-04-15', 'ACTIVO'),
(14, '0501-1987-12134', 'Carmen', 'Reyes', '1987-12-03', 'F', 'carmen.reyes@outlook.com', '9988-3333', 'Cortes', 'San Pedro Sula', 'Residencial La Tara', '2023-05-01', 'ACTIVO'),
(15, '0801-1999-13145', 'Andres', 'Gomez', '1999-03-17', 'M', 'andres.gomez@gmail.com', '9876-4444', 'Francisco Morazan', 'Tegucigalpa', 'Colonia Loarque', '2023-05-05', 'ACTIVO'),
(16, '0601-1994-14156', 'Daniela', 'Diaz', '1994-07-29', 'F', 'daniela.diaz@yahoo.com', '2666-2222', 'Copan', 'Santa Rosa de Copan', 'Barrio El Calvario', '2023-05-10', 'ACTIVO'),
(17, '0801-1983-15167', 'Ricardo', 'Pineda', '1983-11-11', 'M', 'ricardo.pineda@gmail.com', '9876-5555', 'Francisco Morazan', 'Tegucigalpa', 'Colonia El Molino', '2023-05-15', 'ACTIVO'),
(18, '0501-1997-16178', 'Vanessa', 'Aguilar', '1997-02-27', 'F', 'vanessa.aguilar@hotmail.com', '9988-6666', 'Cortes', 'San Pedro Sula', 'Residencial La Pradera', '2023-06-01', 'ACTIVO'),
(19, '1801-1989-17189', 'Oscar', 'Hernandez', '1989-09-09', 'M', 'oscar.hernandez@gmail.com', '2444-7777', 'Atlantida', 'La Ceiba', 'Barrio El Centro', '2023-06-05', 'ACTIVO'),
(20, '0801-2001-18190', 'Laura', 'Chavez', '2001-04-30', 'F', 'laura.chavez@gmail.com', '9876-8888', 'Francisco Morazan', 'Tegucigalpa', 'Colonia San Miguel', '2023-06-10', 'ACTIVO'),
(21, '0501-1986-19101', 'Hector', 'Jimenez', '1986-06-21', 'M', 'hector.jimenez@yahoo.com', '9988-0000', 'Cortes', 'San Pedro Sula', 'Colonia Satelite', '2023-06-15', 'ACTIVO'),
(22, '0801-1993-20112', 'Claudia', 'Mejia', '1993-10-13', 'F', 'claudia.mejia@gmail.com', '9876-1112', 'Francisco Morazan', 'Tegucigalpa', 'Residencial El Trapiche', '2023-07-01', 'ACTIVO'),
(23, '1201-1984-21123', 'Miguel', 'Vargas', '1984-01-07', 'M', 'miguel.vargas@outlook.com', '9666-4444', 'Comayagua', 'Comayagua', 'Barrio San Cristobal', '2023-07-05', 'ACTIVO'),
(24, '0501-1998-22134', 'Andrea', 'Molina', '1998-05-19', 'F', 'andrea.molina@gmail.com', '9988-5555', 'Cortes', 'San Pedro Sula', 'Colonia Villas del Sol', '2023-07-10', 'ACTIVO'),
(25, '0801-1978-23145', 'Julio', 'Ramos', '1978-12-24', 'M', 'julio.ramos@gmail.com', '9876-9999', 'Francisco Morazan', 'Tegucigalpa', 'Colonia La Sosa', '2023-07-15', 'ACTIVO'),
(26, '1601-1992-24156', 'Gabriela', 'Ruiz', '1992-08-14', 'F', 'gaby.ruiz@yahoo.com', '2444-8888', 'Atlantida', 'La Ceiba', 'Residencial La Bonita', '2023-08-01', 'INACTIVO'),
(27, '0801-1987-25167', 'Esteban', 'Soto', '1987-03-26', 'M', 'esteban.soto@gmail.com', '9876-3333', 'Francisco Morazan', 'Tegucigalpa', 'Colonia Las Colinas', '2023-08-05', 'ACTIVO'),
(28, '0501-1995-26178', 'Natalia', 'Cruz', '1995-11-02', 'F', 'natalia.cruz@hotmail.com', '9988-7777', 'Cortes', 'San Pedro Sula', 'Barrio Rio Blanco', '2023-08-10', 'ACTIVO'),
(29, '0801-2002-27189', 'David', 'Torres', '2002-07-16', 'M', 'david.torres@gmail.com', '9876-2222', 'Francisco Morazan', 'Tegucigalpa', 'Colonia La Reforma', '2023-08-15', 'ACTIVO'),
(30, '0301-1990-28190', 'Monica', 'Castillo', '1990-09-25', 'F', 'monica.castillo@gmail.com', '2777-6666', 'Copan', 'Santa Rosa de Copan', 'Barrio El Progreso', '2023-09-01', 'ACTIVO');
GO

-- ============================================
-- 3. PLANES (10 registros)
-- ============================================
INSERT INTO stg_planes (plan_id, tipo_servicio_id, nombre_plan, tipo_plan, categoria_precio, precio_mensual, minutos_incluidos, sms_incluidos, datos_gb, velocidad_mbps, canales_tv, incluye_llamadas_ilimitadas, incluye_redes_sociales, vigencia_dias, activo, fecha_lanzamiento) VALUES
(1, 1, 'Movil Basico', 'PREPAGO', 'BASICO', 150.00, 100, 50, 2.0, 0, 0, 0, 0, 30, 1, '2022-01-01'),
(2, 1, 'Movil Plus', 'PREPAGO', 'MEDIO', 250.00, 300, 100, 5.0, 0, 0, 0, 1, 30, 1, '2022-01-01'),
(3, 1, 'Movil Premium', 'POSTPAGO', 'PREMIUM', 450.00, 1000, 500, 15.0, 0, 0, 1, 1, 30, 1, '2022-03-01'),
(4, 2, 'Fijo Basico', 'POSTPAGO', 'BASICO', 200.00, 200, 0, 0, 0, 0, 0, 0, 30, 1, '2022-01-01'),
(5, 2, 'Fijo Ilimitado', 'POSTPAGO', 'PREMIUM', 400.00, 0, 0, 0, 0, 0, 1, 0, 30, 1, '2022-02-01'),
(6, 3, 'Internet 30 Mbps', 'POSTPAGO', 'BASICO', 500.00, 0, 0, 0, 30, 0, 0, 0, 30, 1, '2022-01-01'),
(7, 3, 'Internet 50 Mbps', 'POSTPAGO', 'MEDIO', 700.00, 0, 0, 0, 50, 0, 0, 0, 30, 1, '2022-01-01'),
(8, 3, 'Internet 100 Mbps', 'POSTPAGO', 'PREMIUM', 950.00, 0, 0, 0, 100, 0, 0, 0, 30, 1, '2022-06-01'),
(9, 4, 'TV Basico', 'POSTPAGO', 'BASICO', 300.00, 0, 0, 0, 0, 50, 0, 0, 30, 1, '2022-01-01'),
(10, 4, 'TV Premium', 'POSTPAGO', 'PREMIUM', 500.00, 0, 0, 0, 0, 150, 0, 0, 30, 1, '2022-02-01');
GO

-- ============================================
-- 4. CONTRATOS (30 registros)
-- ============================================
INSERT INTO stg_contratos (contrato_id, cliente_id, plan_id, numero_linea, fecha_inicio, fecha_fin, estado_contrato, fecha_cancelacion, motivo_cancelacion, meses_permanencia, canal_venta, sucursal_id) VALUES
-- Contratos activos
(1, 1, 3, '9876-5432', '2023-01-10', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 1),
(2, 2, 7, NULL, '2023-01-15', NULL, 'ACTIVO', NULL, NULL, NULL, 'WEB', NULL),
(3, 3, 2, '9988-7766', '2023-02-01', NULL, 'ACTIVO', NULL, NULL, NULL, 'APP', NULL),
(4, 4, 6, NULL, '2023-02-10', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 2),
(5, 5, 1, '9666-3322', '2023-02-15', NULL, 'ACTIVO', NULL, NULL, NULL, 'CALL_CENTER', NULL),
(6, 6, 8, NULL, '2023-03-01', NULL, 'ACTIVO', NULL, NULL, NULL, 'WEB', NULL),
(7, 7, 3, '9988-2222', '2023-03-05', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 2),
(8, 8, 10, NULL, '2023-03-10', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 3),
(9, 9, 6, NULL, '2023-03-15', NULL, 'ACTIVO', NULL, NULL, NULL, 'WEB', NULL),
(10, 10, 2, '9876-6666', '2023-04-01', NULL, 'ACTIVO', NULL, NULL, NULL, 'APP', NULL),
(11, 11, 5, NULL, '2023-04-05', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 2),
(12, 12, 3, '9876-7777', '2023-04-10', NULL, 'ACTIVO', NULL, NULL, NULL, 'WEB', NULL),
(13, 13, 1, '2777-1111', '2023-04-15', NULL, 'ACTIVO', NULL, NULL, NULL, 'CALL_CENTER', NULL),
(14, 14, 7, NULL, '2023-05-01', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 1),
(15, 15, 9, NULL, '2023-05-05', NULL, 'ACTIVO', NULL, NULL, NULL, 'WEB', NULL),
(16, 16, 4, '2666-2222', '2023-05-10', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 3),
(17, 17, 8, NULL, '2023-05-15', NULL, 'ACTIVO', NULL, NULL, NULL, 'APP', NULL),
(18, 18, 3, '9988-6666', '2023-06-01', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 2),
(19, 19, 6, NULL, '2023-06-05', NULL, 'ACTIVO', NULL, NULL, NULL, 'WEB', NULL),
(20, 20, 2, '9876-8888', '2023-06-10', NULL, 'ACTIVO', NULL, NULL, NULL, 'CALL_CENTER', NULL),
(21, 21, 10, NULL, '2023-06-15', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 1),
(22, 22, 1, '9876-1112', '2023-07-01', NULL, 'ACTIVO', NULL, NULL, NULL, 'APP', NULL),
(23, 23, 7, NULL, '2023-07-05', NULL, 'ACTIVO', NULL, NULL, NULL, 'WEB', NULL),
(24, 24, 3, '9988-5555', '2023-07-10', NULL, 'ACTIVO', NULL, NULL, NULL, 'SUCURSAL', 2),
(25, 25, 5, NULL, '2023-07-15', NULL, 'ACTIVO', NULL, NULL, NULL, 'CALL_CENTER', NULL),
-- Contratos cancelados
(26, 26, 1, '2444-8888', '2023-01-20', '2023-04-20', 'CANCELADO', '2023-04-20', 'PRECIO', 3, 'SUCURSAL', 4),
(27, 27, 2, '9876-3333', '2023-02-01', '2023-06-01', 'CANCELADO', '2023-06-01', 'COBERTURA', 4, 'WEB', NULL),
(28, 28, 6, NULL, '2023-02-15', '2023-07-15', 'CANCELADO', '2023-07-15', 'SERVICIO', 5, 'APP', NULL),
(29, 29, 9, NULL, '2023-03-01', '2023-06-01', 'CANCELADO', '2023-06-01', 'PORTABILIDAD', 3, 'SUCURSAL', 1),
(30, 30, 4, '2777-6666', '2023-03-15', '2023-08-15', 'CANCELADO', '2023-08-15', 'PRECIO', 5, 'WEB', NULL);
GO

-- ============================================
-- 5. PAGOS (50 registros)
-- ============================================
INSERT INTO stg_pagos (pago_id, contrato_id, cliente_id, fecha_pago, monto, metodo_pago, canal_pago, sucursal_id, referencia_pago, estado_pago) VALUES
-- Pagos contratos activos (2023)
(1, 1, 1, '2023-02-10 10:30:00', 450.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF001', 'COMPLETADO'),
(2, 2, 2, '2023-02-15 14:20:00', 700.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF002', 'COMPLETADO'),
(3, 3, 3, '2023-03-01 09:15:00', 250.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF003', 'COMPLETADO'),
(4, 4, 4, '2023-03-10 11:45:00', 500.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF004', 'COMPLETADO'),
(5, 5, 5, '2023-03-15 16:30:00', 150.00, 'PRESENCIAL', 'AGENTE_AUTORIZADO', 4, 'REF005', 'COMPLETADO'),
(6, 6, 6, '2023-04-01 08:00:00', 950.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF006', 'COMPLETADO'),
(7, 7, 7, '2023-04-05 13:20:00', 450.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF007', 'COMPLETADO'),
(8, 8, 8, '2023-04-10 10:10:00', 500.00, 'PRESENCIAL', 'SUCURSAL', 3, 'REF008', 'COMPLETADO'),
(9, 9, 9, '2023-04-15 15:45:00', 500.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF009', 'COMPLETADO'),
(10, 10, 10, '2023-05-01 12:00:00', 250.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF010', 'COMPLETADO'),
(11, 11, 11, '2023-05-05 09:30:00', 400.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF011', 'COMPLETADO'),
(12, 12, 12, '2023-05-10 14:15:00', 450.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF012', 'COMPLETADO'),
(13, 13, 13, '2023-05-15 11:20:00', 150.00, 'PRESENCIAL', 'AGENTE_AUTORIZADO', 4, 'REF013', 'COMPLETADO'),
(14, 14, 14, '2023-06-01 16:00:00', 700.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF014', 'COMPLETADO'),
(15, 15, 15, '2023-06-05 10:45:00', 300.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF015', 'COMPLETADO'),
(16, 16, 16, '2023-06-10 13:30:00', 200.00, 'PRESENCIAL', 'SUCURSAL', 3, 'REF016', 'COMPLETADO'),
(17, 17, 17, '2023-06-15 09:00:00', 950.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF017', 'COMPLETADO'),
(18, 18, 18, '2023-07-01 15:30:00', 450.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF018', 'COMPLETADO'),
(19, 19, 19, '2023-07-05 11:15:00', 500.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF019', 'COMPLETADO'),
(20, 20, 20, '2023-07-10 14:45:00', 250.00, 'PRESENCIAL', 'AGENTE_AUTORIZADO', 4, 'REF020', 'COMPLETADO'),
(21, 21, 21, '2023-07-15 10:00:00', 500.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF021', 'COMPLETADO'),
(22, 22, 22, '2023-08-01 12:30:00', 150.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF022', 'COMPLETADO'),
(23, 23, 23, '2023-08-05 09:45:00', 700.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF023', 'COMPLETADO'),
(24, 24, 24, '2023-08-10 16:15:00', 450.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF024', 'COMPLETADO'),
(25, 25, 25, '2023-08-15 11:30:00', 400.00, 'PRESENCIAL', 'AGENTE_AUTORIZADO', 4, 'REF025', 'COMPLETADO'),
-- Pagos adicionales para contratos activos (segundo pago)
(26, 1, 1, '2023-03-10 10:00:00', 450.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF026', 'COMPLETADO'),
(27, 2, 2, '2023-03-15 14:00:00', 700.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF027', 'COMPLETADO'),
(28, 3, 3, '2023-04-01 09:30:00', 250.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF028', 'COMPLETADO'),
(29, 4, 4, '2023-04-10 11:00:00', 500.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF029', 'COMPLETADO'),
(30, 5, 5, '2023-04-15 16:00:00', 150.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF030', 'COMPLETADO'),
(31, 6, 6, '2023-05-01 08:30:00', 950.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF031', 'COMPLETADO'),
(32, 7, 7, '2023-05-05 13:00:00', 450.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF032', 'COMPLETADO'),
(33, 8, 8, '2023-05-10 10:30:00', 500.00, 'PRESENCIAL', 'SUCURSAL', 3, 'REF033', 'COMPLETADO'),
(34, 9, 9, '2023-05-15 15:00:00', 500.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF034', 'COMPLETADO'),
(35, 10, 10, '2023-06-01 12:30:00', 250.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF035', 'COMPLETADO'),
-- Pagos de contratos cancelados (pagaron antes de cancelar)
(36, 26, 26, '2023-02-20 10:00:00', 150.00, 'PRESENCIAL', 'SUCURSAL', 4, 'REF036', 'COMPLETADO'),
(37, 26, 26, '2023-03-20 10:00:00', 150.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF037', 'COMPLETADO'),
(38, 27, 27, '2023-03-01 14:00:00', 250.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF038', 'COMPLETADO'),
(39, 27, 27, '2023-04-01 14:00:00', 250.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF039', 'COMPLETADO'),
(40, 28, 28, '2023-03-15 09:00:00', 500.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF040', 'COMPLETADO'),
(41, 28, 28, '2023-04-15 09:00:00', 500.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF041', 'COMPLETADO'),
(42, 29, 29, '2023-04-01 11:00:00', 300.00, 'PRESENCIAL', 'SUCURSAL', 1, 'REF042', 'COMPLETADO'),
(43, 29, 29, '2023-05-01 11:00:00', 300.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF043', 'COMPLETADO'),
(44, 30, 30, '2023-04-15 16:00:00', 200.00, 'PRESENCIAL', 'SUCURSAL', 3, 'REF044', 'COMPLETADO'),
(45, 30, 30, '2023-05-15 16:00:00', 200.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF045', 'COMPLETADO'),
-- Pagos fallidos (para ver pago_completado = 0)
(46, 11, 11, '2023-06-05 14:00:00', 400.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF046', 'FALLIDO'),
(47, 14, 14, '2023-07-01 10:00:00', 700.00, 'EN_LINEA', 'APP_MOVIL', NULL, 'REF047', 'FALLIDO'),
(48, 18, 18, '2023-08-01 09:00:00', 450.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF048', 'FALLIDO'),
(49, 22, 22, '2023-09-01 11:00:00', 150.00, 'EN_LINEA', 'PORTAL_WEB', NULL, 'REF049', 'PENDIENTE'),
(50, 24, 24, '2023-09-10 15:00:00', 450.00, 'PRESENCIAL', 'SUCURSAL', 2, 'REF050', 'PENDIENTE');
GO

-- ============================================
-- 6. CONSUMOS (40 registros)
-- ============================================
INSERT INTO stg_consumos (consumo_id, contrato_id, cliente_id, fecha_consumo, tipo_consumo, duracion_segundos, cantidad_mb, cantidad_sms, horas_tv, incluido_plan, costo_extra) VALUES
-- Consumos MOVIL (contratos 1, 3, 5, 7, 10)
(1, 1, 1, '2023-02-15', 'VOZ', 3600, 0, 0, 0, 1, 0),
(2, 1, 1, '2023-02-20', 'DATOS', 0, 2048, 0, 0, 1, 0),
(3, 1, 1, '2023-02-25', 'SMS', 0, 0, 45, 0, 1, 0),
(4, 3, 3, '2023-03-10', 'VOZ', 1800, 0, 0, 0, 1, 0),
(5, 3, 3, '2023-03-15', 'DATOS', 0, 1024, 0, 0, 1, 0),
(6, 5, 5, '2023-03-20', 'VOZ', 900, 0, 0, 0, 0, 5.00),
(7, 7, 7, '2023-04-10', 'VOZ', 4500, 0, 0, 0, 1, 0),
(8, 7, 7, '2023-04-15', 'DATOS', 0, 5120, 0, 0, 1, 0),
(9, 10, 10, '2023-05-05', 'VOZ', 1200, 0, 0, 0, 1, 0),
(10, 10, 10, '2023-05-10', 'SMS', 0, 0, 80, 0, 1, 0),
-- Consumos INTERNET (contratos 2, 4, 6, 9, 14)
(11, 2, 2, '2023-02-20', 'INTERNET_FIJO', 0, 10240, 0, 0, 1, 0),
(12, 2, 2, '2023-03-10', 'INTERNET_FIJO', 0, 20480, 0, 0, 0, 15.00),
(13, 4, 4, '2023-03-15', 'INTERNET_FIJO', 0, 5120, 0, 0, 1, 0),
(14, 6, 6, '2023-04-01', 'INTERNET_FIJO', 0, 30720, 0, 0, 1, 0),
(15, 6, 6, '2023-04-20', 'INTERNET_FIJO', 0, 15360, 0, 0, 1, 0),
(16, 9, 9, '2023-04-25', 'INTERNET_FIJO', 0, 8192, 0, 0, 1, 0),
(17, 14, 14, '2023-06-10', 'INTERNET_FIJO', 0, 10240, 0, 0, 1, 0),
(18, 14, 14, '2023-06-25', 'INTERNET_FIJO', 0, 5120, 0, 0, 1, 0),
-- Consumos TV (contratos 8, 15, 21)
(19, 8, 8, '2023-04-15', 'TV', 0, 0, 0, 45, 1, 0),
(20, 8, 8, '2023-04-30', 'TV', 0, 0, 0, 60, 1, 0),
(21, 15, 15, '2023-06-10', 'TV', 0, 0, 0, 30, 1, 0),
(22, 21, 21, '2023-07-20', 'TV', 0, 0, 0, 120, 1, 0),
-- Consumos FIJO (contratos 11, 16, 25)
(23, 11, 11, '2023-05-10', 'VOZ', 600, 0, 0, 0, 1, 0),
(24, 16, 16, '2023-05-20', 'VOZ', 1200, 0, 0, 0, 1, 0),
(25, 25, 25, '2023-07-20', 'VOZ', 900, 0, 0, 0, 1, 0),
-- Consumos adicionales varios
(26, 12, 12, '2023-05-15', 'VOZ', 3000, 0, 0, 0, 1, 0),
(27, 13, 13, '2023-05-20', 'SMS', 0, 0, 30, 0, 1, 0),
(28, 17, 17, '2023-06-15', 'INTERNET_FIJO', 0, 40960, 0, 0, 1, 0),
(29, 18, 18, '2023-07-05', 'VOZ', 2100, 0, 0, 0, 1, 0),
(30, 19, 19, '2023-07-10', 'INTERNET_FIJO', 0, 6144, 0, 0, 1, 0),
(31, 20, 20, '2023-07-15', 'VOZ', 750, 0, 0, 0, 1, 0),
(32, 22, 22, '2023-08-05', 'VOZ', 450, 0, 0, 0, 0, 2.50),
(33, 23, 23, '2023-08-10', 'INTERNET_FIJO', 0, 8192, 0, 0, 1, 0),
(34, 24, 24, '2023-08-15', 'VOZ', 3600, 0, 0, 0, 1, 0),
-- Consumos de contratos cancelados (antes de cancelar)
(35, 26, 26, '2023-02-25', 'VOZ', 600, 0, 0, 0, 1, 0),
(36, 26, 26, '2023-03-10', 'DATOS', 0, 512, 0, 0, 0, 3.00),
(37, 27, 27, '2023-03-05', 'VOZ', 1200, 0, 0, 0, 1, 0),
(38, 28, 28, '2023-03-20', 'INTERNET_FIJO', 0, 3072, 0, 0, 1, 0),
(39, 29, 29, '2023-04-10', 'TV', 0, 0, 0, 25, 1, 0),
(40, 30, 30, '2023-04-20', 'VOZ', 300, 0, 0, 0, 1, 0);
GO

-- ============================================
-- 7. RECLAMOS (15 registros)
-- ============================================
INSERT INTO stg_reclamos (reclamo_id, cliente_id, contrato_id, fecha_reclamo, tipo_reclamo, estado_reclamo) VALUES
(1, 1, 1, '2023-02-20 10:30:00', 'COBERTURA', 'RESUELTO'),
(2, 3, 3, '2023-03-15 14:00:00', 'FACTURACION', 'RESUELTO'),
(3, 7, 7, '2023-04-10 09:15:00', 'VELOCIDAD', 'EN_PROCESO'),
(4, 8, 8, '2023-04-20 11:45:00', 'ATENCION', 'RESUELTO'),
(5, 11, 11, '2023-05-15 16:30:00', 'FACTURACION', 'ABIERTO'),
(6, 14, 14, '2023-06-05 08:00:00', 'VELOCIDAD', 'RESUELTO'),
(7, 17, 17, '2023-06-20 13:20:00', 'COBERTURA', 'EN_PROCESO'),
(8, 18, 18, '2023-07-10 10:10:00', 'FACTURACION', 'RESUELTO'),
(9, 21, 21, '2023-07-25 15:45:00', 'ATENCION', 'ABIERTO'),
(10, 24, 24, '2023-08-15 12:00:00', 'VELOCIDAD', 'RESUELTO'),
-- Reclamos de contratos cancelados
(11, 26, 26, '2023-03-01 09:30:00', 'FACTURACION', 'RESUELTO'),
(12, 27, 27, '2023-03-20 14:00:00', 'COBERTURA', 'RESUELTO'),
(13, 28, 28, '2023-04-10 11:00:00', 'VELOCIDAD', 'RESUELTO'),
(14, 29, 29, '2023-04-25 16:00:00', 'ATENCION', 'RESUELTO'),
(15, 30, 30, '2023-05-10 10:00:00', 'FACTURACION', 'RESUELTO');
GO

-- ============================================
-- VERIFICACION FINAL DE STAGING
-- ============================================
PRINT '=== VERIFICACION DE TABLAS STAGING ===';
SELECT 'stg_sucursales' AS tabla, COUNT(*) AS registros FROM stg_sucursales
UNION ALL
SELECT 'stg_clientes', COUNT(*) FROM stg_clientes
UNION ALL
SELECT 'stg_tipo_servicio', COUNT(*) FROM stg_tipo_servicio
UNION ALL
SELECT 'stg_planes', COUNT(*) FROM stg_planes
UNION ALL
SELECT 'stg_contratos', COUNT(*) FROM stg_contratos
UNION ALL
SELECT 'stg_pagos', COUNT(*) FROM stg_pagos
UNION ALL
SELECT 'stg_consumos', COUNT(*) FROM stg_consumos
UNION ALL
SELECT 'stg_reclamos', COUNT(*) FROM stg_reclamos;
GO