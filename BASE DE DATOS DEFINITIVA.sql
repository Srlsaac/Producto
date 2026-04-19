
CREATE DATABASE sucursal;
USE sucursal;

CREATE TABLE empleado (
    id_empleado     INT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(255),
    nombres         VARCHAR(255),
    apellidos       VARCHAR(255),
    documento       VARCHAR(255),
    cargo           VARCHAR(255),
    departamento    VARCHAR(255),
    fecha_ingreso   VARCHAR(255),
    nivel           INT,
    usuario         VARCHAR(255),
    permisos        VARCHAR(255),
    estado          VARCHAR(255),
    id_sucursal     INT,
    id_supervisor   INT
);

CREATE TABLE sucursal (
    id_sucursal     INT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(255),
    nombre          VARCHAR(255),
    direccion       VARCHAR(255),
    latitud         INT,
    longitud        INT,
    telefono        VARCHAR(255),
    horario         VARCHAR(255),
    num_cajeros     INT,
    num_asesores    INT,
    cajas_seguridad INT,
    servicios       VARCHAR(255),
    id_gerente      INT 
);

CREATE TABLE cliente (
    id_cliente      INT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(255),
    tipo            VARCHAR(255),
    nombre          VARCHAR(255),
    documento       VARCHAR(255),
    fecha_registro  VARCHAR(255),
    nacionalidad    VARCHAR(255),
    direccion       VARCHAR(255),
    telefono        VARCHAR(255),
    correo          VARCHAR(255),
    actividad       VARCHAR(255),
    ingresos        INT,
    patrimonio      INT,
    nivel_riesgo    VARCHAR(255),
    clasificacion   VARCHAR(255),
    estado          VARCHAR(255)
);

CREATE TABLE producto (
    id_producto     INT AUTO_INCREMENT PRIMARY KEY,
    codigo          VARCHAR(255),
    nombre          VARCHAR(255),
    tipo            VARCHAR(255),
    monto_minimo    INT,
    monto_maximo    INT,
    plazo_minimo    INT,
    plazo_maximo    INT,
    tasa_interes    INT,
    comisiones      VARCHAR(255),
    requisitos      VARCHAR(255),
    garantias       VARCHAR(255),
    segmentos       VARCHAR(255)
);

CREATE TABLE garantia (
    id_garantia       INT AUTO_INCREMENT PRIMARY KEY,
    codigo            VARCHAR(255),
    tipo              VARCHAR(255),
    descripcion       VARCHAR(255),
    valor_comercial   INT,
    valor_respaldo    INT,
    fecha_inicio      VARCHAR(255),
    fecha_vencimiento VARCHAR(255),
    estado            VARCHAR(255)
);

CREATE TABLE cuenta (
    id_cuenta                INT AUTO_INCREMENT PRIMARY KEY,
    numero                   VARCHAR(255),
    tipo                     VARCHAR(255),
    moneda                   VARCHAR(255),
    fecha_apertura           VARCHAR(255),
    saldo                    INT,
    saldo_promedio           INT,
    tasa_interes             INT,
    fecha_ultima_transaccion VARCHAR(255),
    estado                   VARCHAR(255),
    id_cliente               INT,
    id_sucursal              INT
);

CREATE TABLE titular_adicional (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta  INT,
    id_cliente INT
);

CREATE TABLE tarjeta (
    id_tarjeta        INT AUTO_INCREMENT PRIMARY KEY,
    numero            VARCHAR(255),
    tipo              VARCHAR(255),
    red               VARCHAR(255),
    linea_credito     INT,
    fecha_emision     VARCHAR(255),
    fecha_vencimiento VARCHAR(255),
    limite_avances    INT,
    tasa_rotatoria    INT,
    tasa_avances      INT,
    ciclo_facturacion INT,
    estado            VARCHAR(255),
    id_cliente        INT
);

CREATE TABLE solicitud (
    id_solicitud        INT AUTO_INCREMENT PRIMARY KEY,
    numero              VARCHAR(255),
    fecha               VARCHAR(255),
    monto               INT,
    plazo               INT,
    destino             VARCHAR(255),
    ingresos            INT,
    respaldos           VARCHAR(255),
    capacidad_pago      INT,
    nivel_endeudamiento INT,
    puntuacion          INT,
    recomendacion       VARCHAR(255),
    decision            VARCHAR(255),
    motivo              VARCHAR(255),
    id_cliente          INT,
    id_producto         INT
);

CREATE TABLE credito (
    id_credito          INT AUTO_INCREMENT PRIMARY KEY,
    numero              VARCHAR(255),
    fecha_desembolso    VARCHAR(255),
    monto               INT,
    plazo               INT,
    tasa_interes        INT,
    amortizacion        VARCHAR(255),
    dia_pago            INT,
    seguros             VARCHAR(255),
    saldo_actual        VARCHAR(255),
    proximo_vencimiento VARCHAR(255),
    estado              VARCHAR(255),
    id_solicitud        INT
);

CREATE TABLE credito_garantia (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_credito  INT,
    id_garantia INT
);

CREATE TABLE transaccion (
    id_transaccion    INT AUTO_INCREMENT PRIMARY KEY,
    codigo            VARCHAR(255),
    fecha_hora        VARCHAR(255),
    tipo              VARCHAR(255),
    monto             DECIMAL(14,2),
    concepto          VARCHAR(255),
    canal             VARCHAR(255),
    comprobante       VARCHAR(255),
    estado            VARCHAR(255),
    id_cuenta_origen  INT,
    id_cuenta_destino INT,
    id_empleado       INT
);

INSERT INTO empleado (codigo, nombres, apellidos, documento, cargo, departamento, fecha_ingreso, nivel, usuario, permisos, estado, id_sucursal, id_supervisor) 
VALUES
('E001', 'Carlos',    'Ramírez', '10234567', 'Gerente', 'Dirección',   '2018-03-15', 1, 'cramirez',  'admin',    'activo', 1,  1),
('E002', 'Laura',     'Gómez',   '20345678', 'Gerente', 'Dirección',   '2019-05-20', 1, 'lgomez',    'admin',    'activo', 2,  2),
('E003', 'Andrés',    'Martínez','30456789', 'Gerente', 'Dirección',   '2017-08-10', 1, 'amartinez', 'admin',    'activo', 3,  3),
('E004', 'Sofía',     'Torres',  '40567890', 'Gerente', 'Dirección',   '2020-01-12', 1, 'storres',   'admin',    'activo', 4,  4),
('E005', 'Miguel',    'López',   '50678901', 'Gerente', 'Dirección',   '2016-11-25', 1, 'mlopez',    'admin',    'activo', 5,  5),
('E006', 'Valentina', 'Castro',  '60789012', 'Asesor',  'Comercial',   '2021-03-08', 2, 'vcastro',   'ventas',   'activo', 6,  1),
('E007', 'Juan',      'Herrera', '70890123', 'Asesor',  'Comercial',   '2022-07-14', 2, 'jherrera',  'ventas',   'activo', 7,  2),
('E008', 'Camila',    'Díaz',    '80901234', 'Cajero',  'Operaciones', '2023-02-01', 3, 'cdiaz',     'caja',     'activo', 8,  3),
('E009', 'Sebastián', 'Vargas',  '90012345', 'Analista','Crédito',     '2020-09-18', 2, 'svargas',   'creditos', 'activo', 9,  4),
('E010', 'Isabella',  'Mora',    '10123456', 'Cajero',  'Operaciones', '2021-06-30', 3, 'imora',     'caja',     'activo', 10, 5);

INSERT INTO sucursal (codigo, nombre, direccion, latitud, longitud, telefono, horario, num_cajeros, num_asesores, cajas_seguridad, servicios, id_gerente)
VALUES
('S001', 'Sucursal Norte',     'Av. Principal 123',      4.7110, -74.0721, '6011234567', 'Lun-Vie 8am-5pm', 4, 6, 2, 'Créditos, Ahorros, Inversiones',          1),
('S002', 'Sucursal Sur',       'Calle 80 #45-20',        4.6320, -74.0850, '6019876543', 'Lun-Sab 8am-6pm', 3, 5, 1, 'Créditos, Tarjetas',                      2),
('S003', 'Sucursal Centro',    'Carrera 7 #12-50',       4.7180, -74.0650, '6012345678', 'Lun-Vie 9am-5pm', 5, 8, 3, 'Créditos, Ahorros, Inversiones, Seguros', 3),
('S004', 'Sucursal Occidente', 'Av. 68 #23-10',          4.6890, -74.1120, '6013456789', 'Lun-Vie 8am-4pm', 2, 4, 1, 'Ahorros, Créditos',                       4),
('S005', 'Sucursal Oriente',   'Calle 63 #14-30',        4.7250, -74.0480, '6014567890', 'Lun-Sab 9am-5pm', 3, 6, 2, 'Créditos, Inversiones',                   5),
('S006', 'Sucursal Chapinero', 'Carrera 13 #56-40',      4.6450, -74.0580, '6015678901', 'Lun-Vie 8am-5pm', 4, 5, 2, 'Ahorros, Tarjetas, Seguros',              6),
('S007', 'Sucursal Usaquén',   'Calle 119 #8-20',        4.6980, -74.0320, '6016789012', 'Lun-Sab 8am-6pm', 3, 7, 3, 'Créditos, Ahorros, Inversiones',          7),
('S008', 'Sucursal Kennedy',   'Av. 1 de Mayo #45-60',   4.6270, -74.1380, '6017890123', 'Lun-Vie 9am-5pm', 2, 4, 1, 'Créditos, Ahorros',                       8),
('S009', 'Sucursal Suba',      'Carrera 91 #140-20',     4.7580, -74.0890, '6018901234', 'Lun-Sab 8am-5pm', 3, 5, 2, 'Ahorros, Tarjetas',                       9),
('S010', 'Sucursal Bosa',      'Calle 65 Sur #80-10',    4.5980, -74.1650, '6019012345', 'Lun-Vie 8am-4pm', 2, 3, 1, 'Créditos, Ahorros',                       10);

INSERT INTO cliente (codigo, tipo, nombre, documento, fecha_registro, nacionalidad, direccion, telefono, correo, actividad, ingresos, patrimonio, nivel_riesgo, clasificacion, estado) 
VALUES
('C001', 'natural',  'Laura Gómez',           '98765432',  '2020-01-15', 'Colombiana', 'Calle 45 #12-30',    '3101234567', 'lgomez@email.com',      'Ingeniera',   4500000,  25000000,  'bajo',  'A', 'activo'),
('C002', 'natural',  'Pedro Sánchez',          '87654321',  '2019-06-20', 'Colombiano', 'Carrera 15 #34-50',  '3112345678', 'psanchez@email.com',    'Médico',      8000000,  60000000,  'bajo',  'A', 'activo'),
('C003', 'juridico', 'Constructora XYZ S.A.',  '900123456', '2018-03-10', 'Colombiana', 'Av. Empresarial 90', '6013456789', 'info@xyzsa.com',        'Construcción',35000000, 200000000, 'medio', 'B', 'activo'),
('C004', 'natural',  'María Torres',           '76543210',  '2021-09-05', 'Colombiana', 'Calle 80 #20-15',    '3123456789', 'mtorres@email.com',     'Docente',     3200000,  15000000,  'bajo',  'A', 'activo'),
('C005', 'natural',  'jose Ramírez',           '65432109',  '2020-11-18', 'Colombiano', 'Carrera 30 #5-60',   '3134567890', 'jramirez@email.com',    'Comerciante', 5500000,  30000000,  'medio', 'B', 'activo'),
('C006', 'juridico', 'Inversiones ABC Ltda',   '800234567', '2017-07-22', 'Colombiana', 'Calle 93 #15-40',    '6014567890', 'contacto@abcltda.com',  'Inversiones', 50000000, 350000000, 'bajo',  'A', 'activo'),
('C007', 'natural',  'Ana Martínez',           '54321098',  '2022-02-14', 'Colombiana', 'Av. 68 #30-20',      '3145678901', 'amartinez@email.com',   'Abogada',     6000000,  40000000,  'bajo',  'A', 'activo'),
('C008', 'natural',  'Luis Herrera',           '43210987',  '2021-04-30', 'Colombiano', 'Calle 50 #10-25',    '3156789012', 'lherrera@email.com',    'Contador',    4800000,  28000000,  'medio', 'B', 'activo'),
('C009', 'juridico', 'Tecnología Sur S.A.S',   '700345678', '2019-12-01', 'Colombiana', 'Carrera 7 #45-80',   '6015678901', 'info@tecnosur.com',     'Tecnología',  25000000, 120000000, 'medio', 'B', 'activo'),
('C010', 'natural',  'Daniela Castro',         '32109876',  '2023-01-10', 'Colombiana', 'Calle 26 #60-30',    '3167890123', 'dcastro@email.com',     'Arquitecta',  5200000,  32000000,  'bajo',  'A', 'activo');

INSERT INTO producto (codigo, nombre, tipo, monto_minimo, monto_maximo, plazo_minimo, plazo_maximo, tasa_interes, comisiones, requisitos, garantias, segmentos) 
VALUES
('P001', 'Crédito Personal Express', 'personal',    1000000,    50000000,  6,  60,  14.50, 'Estudio 1%',       'Cédula, desprendibles de pago', 'Ninguna',          'natural'),
('P002', 'Crédito Hipotecario Hogar','hipotecario',  50000000,  500000000, 60, 240, 11.20, 'Estudio 1%, Avalúo','Cédula, escrituras, avalúo',    'Hipoteca inmueble','natural'),
('P003', 'Crédito Vehicular',        'vehicular',   10000000,  120000000, 12,  72,  13.80, 'Estudio 0.5%',     'Cédula, factura vehículo',      'Prenda vehículo',  'natural'),
('P004', 'Crédito Empresarial Plus', 'empresarial', 50000000, 1000000000, 12, 120, 12.50, 'Estudio 1.5%',     'RUT, estados financieros',      'Hipoteca o fiducia','juridico'),
('P005', 'Crédito Educativo',        'personal',      500000,   30000000,  6,  48,  10.50, 'Sin comisión',     'Cédula, matrícula',             'Ninguna',          'natural'),
('P006', 'Microcrédito Emprendedor', 'personal',      200000,    5000000,  3,  24,  16.20, 'Estudio 0.5%',     'Cédula, plan de negocio',       'Ninguna',          'natural'),
('P007', 'Crédito Libre Inversión',  'personal',    5000000,   80000000, 12,  84,  15.00, 'Estudio 1%',       'Cédula, desprendibles',         'Ninguna',          'natural,juridico'),
('P008', 'Leasing Habitacional',     'hipotecario', 80000000,  600000000, 60, 180, 10.80, 'Estudio 1%, Avalúo','Cédula, escrituras',            'Inmueble en leasing','natural'),
('P009', 'Crédito Agropecuario',     'empresarial',  2000000,  200000000, 12,  96,   9.50, 'Estudio 0.5%',     'Cédula, certificado predio',    'Prenda agraria',   'natural,juridico'),
('P010', 'Crédito Constructor',      'empresarial',100000000, 2000000000, 12,  60,  13.20, 'Estudio 2%',       'RUT, licencia construcción',    'Hipoteca lote',    'juridico');

INSERT INTO garantia (codigo, tipo, descripcion, valor_comercial, valor_respaldo, fecha_inicio, fecha_vencimiento, estado) 
VALUES
('G001', 'hipotecaria', 'Apartamento en Chapinero',          250000000, 200000000, '2022-01-10', '2032-01-10', 'vigente'),
('G002', 'prendaria',   'Vehículo Toyota Hilux 2021',         85000000,  68000000, '2021-06-15', NULL,         'vigente'),
('G003', 'fiduciaria',  'Fideicomiso sobre local comercial',  180000000, 150000000, '2020-03-20', '2030-03-20', 'vigente'),
('G004', 'personal',    'Codeudor con ingresos verificados',   40000000,  32000000, '2023-02-01', '2028-02-01', 'vigente'),
('G005', 'hipotecaria', 'Casa en Usaquén',                    320000000, 260000000, '2019-09-10', '2034-09-10', 'vigente'),
('G006', 'prendaria',   'Maquinaria industrial',               95000000,  76000000, '2022-07-25', '2027-07-25', 'vigente'),
('G007', 'fiduciaria',  'Fideicomiso sobre bodega',            210000000, 170000000, '2021-11-30', '2031-11-30', 'vigente'),
('G008', 'personal',    'Codeudor empleado público',            30000000,  24000000, '2023-05-14', '2026-05-14', 'vigente'),
('G009', 'hipotecaria', 'Lote en zona industrial',             150000000, 120000000, '2020-08-18', '2030-08-18', 'vigente'),
('G010', 'prendaria',   'Vehículo Mazda CX5 2022',              90000000,  72000000, '2022-12-01', '2028-12-01', 'vigente');

INSERT INTO cuenta (numero, tipo, moneda, fecha_apertura, saldo, saldo_promedio, tasa_interes, fecha_ultima_transaccion, estado, id_cliente, id_sucursal) 
VALUES
('001-123456-1',  'ahorros',   'COP', '2020-01-15',  8500000,  7200000, 3.50, '2026-03-20', 'activa', 1,  1),
('001-123456-2',  'corriente', 'COP', '2019-06-20', 15000000, 12000000, 0.00, '2026-03-19', 'activa', 2,  2),
('001-123456-3',  'ahorros',   'USD', '2018-03-10',  5000000,  4500000, 2.80, '2026-03-18', 'activa', 3,  3),
('001-123456-4',  'invercion', 'COP', '2021-09-05',  3200000,  2800000, 0.00, '2026-03-17', 'activa', 4,  4),
('001-123456-5',  'ahorros',   'COP', '2020-11-18',  9800000,  8500000, 3.50, '2026-03-16', 'activa', 5,  5),
('001-123456-6',  'corriente', 'USD', '2017-07-22', 25000000, 22000000, 0.00, '2026-03-15', 'activa', 6,  6),
('001-123456-7',  'ahorros',   'COP', '2022-02-14',  4100000,  3800000, 3.50, '2026-03-14', 'activa', 7,  7),
('001-123456-8',  'corriente', 'COP', '2021-04-30',  6700000,  6000000, 0.00, '2026-03-13', 'activa', 8,  8),
('001-123456-9',  'invercion', 'COP', '2019-12-01', 12000000, 10500000, 3.50, '2026-03-12', 'activa', 9,  9),
('001-123456-10', 'ahorros',   'COP', '2023-01-10',  2800000,  2500000, 3.50, '2026-03-11', 'activa', 10, 10);


INSERT INTO titular_adicional (id_cuenta, id_cliente) 
VALUES
(1,  2),
(2,  3),
(3,  4),
(4,  5),
(5,  6),
(6,  7),
(7,  8),
(8,  9),
(9,  10),
(10, 1);

INSERT INTO tarjeta (id_tarjeta, numero, tipo, red, linea_credito, fecha_emision, fecha_vencimiento, limite_avances, tasa_rotatoria, tasa_avances, ciclo_facturacion, estado, id_cliente) 
VALUES
(1,  '4321-****-****-0001', 'clasica',  'visa',       5000000, '2023-01-15', '2026-01-15', 1500000, 24.50, 31.00, 15, 'activa', 1),
(2,  '4321-****-****-0002', 'gold',     'mastercard', 10000000, '2022-06-20', '2025-06-20', 3000000, 22.50, 29.00, 20, 'activa', 2),
(3,  '4321-****-****-0003', 'platinum', 'visa',       20000000, '2021-03-10', '2024-03-10', 6000000, 20.00, 27.00, 25, 'activa', 3),
(4,  '4321-****-****-0004', 'clasica',  'visa',        4000000, '2023-09-05', '2026-09-05', 1200000, 24.50, 31.00, 10, 'activa', 4),
(5,  '4321-****-****-0005', 'gold',     'mastercard',  8000000, '2022-11-18', '2025-11-18', 2400000, 22.50, 29.00, 15, 'activa', 5),
(6,  '4321-****-****-0006', 'platinum', 'visa',       25000000, '2020-07-22', '2023-07-22', 7500000, 20.00, 27.00, 20, 'activa', 6),
(7,  '4321-****-****-0007', 'clasica',  'mastercard',  3000000, '2023-02-14', '2026-02-14',  900000, 24.50, 31.00,  5, 'activa', 7),
(8,  '4321-****-****-0008', 'gold',     'visa',       12000000, '2022-04-30', '2025-04-30', 3600000, 22.50, 29.00, 10, 'activa', 8),
(9,  '4321-****-****-0009', 'platinum', 'mastercard', 18000000, '2021-12-01', '2024-12-01', 5400000, 20.00, 27.00, 25, 'activa', 9),
(10, '4321-****-****-0010', 'clasica',  'visa',        6000000, '2023-01-10', '2026-01-10', 1800000, 24.50, 31.00, 15, 'activa', 10);


INSERT INTO solicitud (id_solicitud, numero, fecha, monto, plazo, destino, ingresos, respaldos, capacidad_pago, nivel_endeudamiento, puntuacion, recomendacion, decision, motivo, id_cliente, id_producto) 
VALUES
(1,  'SOL-2026-001', '2026-01-05',  15000000,  24, 'Remodelación vivienda',  4500000, 'Desprendibles 3 meses',       1800000, 32.00, 780, 'Buen historial crediticio',         'aprobado', 'Cumple todos los requisitos', 1,  1),
(2,  'SOL-2026-002', '2026-01-10',  80000000, 120, 'Compra vivienda',         8000000, 'Escrituras, desprendibles',   3200000, 28.00, 820, 'Cliente con patrimonio sólido',     'aprobado', 'Cumple perfil hipotecario',   2,  2),
(3,  'SOL-2026-003', '2026-01-15',  45000000,  48, 'Compra vehículo empresa', 35000000,'Estados financieros',        14000000, 25.00, 850, 'Empresa con buena liquidez',        'aprobado', 'Cumple perfil empresarial',   3,  3),
(4,  'SOL-2026-004', '2026-01-20',  10000000,  36, 'Gastos educación',        3200000, 'Matrícula, desprendibles',    1280000, 35.00, 710, 'Ingresos estables',                 'aprobado', 'Cumple perfil educativo',     4,  5),
(5,  'SOL-2026-005', '2026-01-25',  25000000,  60, 'Capital de trabajo',      5500000, 'Desprendibles, extractos',    2200000, 30.00, 760, 'Comerciante con trayectoria',       'aprobado', 'Cumple requisitos',           5,  7),
(6,  'SOL-2026-006', '2026-02-01', 200000000,  84, 'Expansión oficinas',     50000000, 'Estados financieros, RUT',   20000000, 22.00, 890, 'Empresa sólida con garantías',      'aprobado', 'Cumple perfil empresarial',   6,  4),
(7,  'SOL-2026-007', '2026-02-05',  18000000,  48, 'Libre inversión',         6000000, 'Desprendibles 3 meses',       2400000, 29.00, 790, 'Buen perfil crediticio',            'aprobado', 'Cumple todos los requisitos', 7,  7),
(8,  'SOL-2026-008', '2026-02-10',   3000000,  18, 'Microemprendimiento',     4800000, 'Plan de negocio, cédula',     1920000, 20.00, 730, 'Emprendedor con potencial',         'aprobado', 'Cumple perfil microcrédito',  8,  6),
(9,  'SOL-2026-009', '2026-02-15',  90000000,  96, 'Compra maquinaria',      25000000, 'Estados financieros, RUT',   10000000, 26.00, 840, 'Empresa tecnológica en crecimiento','aprobado', 'Cumple perfil agropecuario',  9,  9),
(10, 'SOL-2026-010', '2026-02-20',  20000000,  36, 'Remodelación consultorio', 5200000,'Desprendibles, matrícula',    2080000, 27.00, 800, 'Profesional independiente',         'aprobado', 'Cumple todos los requisitos', 10, 1);

INSERT INTO credito (id_credito, numero, fecha_desembolso, monto, plazo, tasa_interes, amortizacion, dia_pago, seguros, saldo_actual, proximo_vencimiento, estado, id_solicitud) 
VALUES
(1,  'OP-2026-001', '2026-01-10',  15000000,  24, 14.50, 'frances',   5,  'Seguro de vida',          14750000,  '2026-04-05', 'vigente', 1),
(2,  'OP-2026-002', '2026-01-15',  80000000, 120, 11.20, 'frances',   10, 'Seguro de vida, incendio', 79500000,  '2026-04-10', 'vigente', 2),
(3,  'OP-2026-003', '2026-01-20',  45000000,  48, 13.80, 'aleman',    15, 'Seguro todo riesgo',       44800000,  '2026-04-15', 'vigente', 3),
(4,  'OP-2026-004', '2026-01-25',  10000000,  36, 10.50, 'frances',   20, 'Seguro de vida',            9900000,  '2026-04-20', 'vigente', 4),
(5,  'OP-2026-005', '2026-01-30',  25000000,  60, 15.00, 'frances',   25, 'Seguro de vida',           24800000,  '2026-04-25', 'vigente', 5),
(6,  'OP-2026-006', '2026-02-05', 200000000,  84, 12.50, 'aleman',    5,  'Seguro empresarial',      199500000,  '2026-05-05', 'vigente', 6),
(7,  'OP-2026-007', '2026-02-10',  18000000,  48, 15.00, 'frances',   10, 'Seguro de vida',           17900000,  '2026-05-10', 'vigente', 7),
(8,  'OP-2026-008', '2026-02-15',   3000000,  18, 16.20, 'americano', 15, 'Seguro de vida',            2980000,  '2026-05-15', 'vigente', 8),
(9,  'OP-2026-009', '2026-02-20',  90000000,  96,  9.50, 'aleman',    20, 'Seguro empresarial',       89800000,  '2026-05-20', 'vigente', 9),
(10, 'OP-2026-010', '2026-02-25',  20000000,  36, 14.50, 'frances',   25, 'Seguro de vida',           19900000,  '2026-05-25', 'vigente', 10);

INSERT INTO credito_garantia (id, id_credito, id_garantia)
VALUES
(1,  1,  1),
(2,  2,  2),
(3,  3,  3),
(4,  4,  4),
(5,  5,  5),
(6,  6,  6),
(7,  7,  7),
(8,  8,  8),
(9,  9,  9),
(10, 10, 10);

INSERT INTO transaccion (id_transaccion, codigo, fecha_hora, tipo, monto, concepto, canal, comprobante, estado, id_cuenta_origen, id_cuenta_destino, id_empleado) 
VALUES
(1,  'TRX-2026-001', '2026-03-01 08:30:00', 'deposito',      500000, 'Depósito en ventanilla',    'ventanilla', 'COMP-001', 'completada', 1,  2,  1),
(2,  'TRX-2026-002', '2026-03-05 09:15:00', 'transferencia', 1500000, 'Pago arriendo',             'app',        'COMP-002', 'completada', 2,  3,  2),
(3,  'TRX-2026-003', '2026-03-08 10:00:00', 'retiro',         800000, 'Retiro cajero automático',  'cajero',     'COMP-003', 'completada', 3,  4,  3),
(4,  'TRX-2026-004', '2026-03-10 11:30:00', 'deposito',      2000000, 'Depósito nómina',           'banca web',  'COMP-004', 'completada', 4,  5,  4),
(5,  'TRX-2026-005', '2026-03-12 12:45:00', 'transferencia', 3500000, 'Pago proveedor',            'app',        'COMP-005', 'completada', 5,  6,  5),
(6,  'TRX-2026-006', '2026-03-14 14:00:00', 'retiro',        1200000, 'Retiro ventanilla',         'ventanilla', 'COMP-006', 'completada', 6,  7,  6),
(7,  'TRX-2026-007', '2026-03-16 15:20:00', 'deposito',      4500000, 'Depósito cheque',           'ventanilla', 'COMP-007', 'completada', 7,  8,  7),
(8,  'TRX-2026-008', '2026-03-18 16:10:00', 'transferencia',  900000, 'Pago servicios',            'banca web',  'COMP-008', 'completada', 8,  9,  8),
(9,  'TRX-2026-009', '2026-03-19 17:00:00', 'retiro',         600000, 'Retiro cajero automático',  'cajero',     'COMP-009', 'completada', 9,  10, 9),
(10, 'TRX-2026-010', '2026-03-20 10:30:00', 'deposito',       750000, 'Depósito en ventanilla',    'ventanilla', 'COMP-010', 'completada', 10, 1,  10);

ALTER TABLE sucursal
ADD FOREIGN KEY (id_gerente) 
REFERENCES empleado(id_empleado);

ALTER TABLE empleado
ADD FOREIGN KEY (id_sucursal)
REFERENCES sucursal(id_sucursal);

ALTER TABLE empleado
ADD FOREIGN KEY (id_supervisor)
REFERENCES empleado(id_empleado);

ALTER TABLE cuenta
ADD FOREIGN KEY (id_cliente) 
REFERENCES cliente(id_cliente);

ALTER TABLE cuenta
ADD FOREIGN KEY (id_sucursal) 
REFERENCES sucursal(id_sucursal);

ALTER TABLE titular_adicional
ADD FOREIGN KEY (id_cuenta) 
REFERENCES cuenta(id_cuenta);

ALTER TABLE titular_adicional
ADD FOREIGN KEY (id_cliente) 
REFERENCES cliente(id_cliente);

ALTER TABLE tarjeta
ADD FOREIGN KEY (id_cliente) 
REFERENCES cliente(id_cliente);

ALTER TABLE solicitud
ADD FOREIGN KEY (id_cliente) 
REFERENCES cliente(id_cliente);

ALTER TABLE solicitud
ADD FOREIGN KEY (id_producto) 
REFERENCES producto(id_producto);

ALTER TABLE credito
ADD FOREIGN KEY (id_solicitud) 
REFERENCES solicitud(id_solicitud);

ALTER TABLE credito_garantia
ADD FOREIGN KEY (id_credito) 
REFERENCES credito(id_credito);

ALTER TABLE credito_garantia
ADD FOREIGN KEY (id_garantia) 
REFERENCES garantia(id_garantia);

ALTER TABLE transaccion
ADD FOREIGN KEY (id_cuenta_origen) 
REFERENCES cuenta(id_cuenta);

ALTER TABLE transaccion
ADD FOREIGN KEY (id_cuenta_destino) 
REFERENCES cuenta(id_cuenta);

ALTER TABLE transaccion
ADD FOREIGN KEY (id_empleado) 
REFERENCES empleado(id_empleado);
