-- 1. TR_ActualizarSaldoCuenta: Actualiza el saldo de una cuenta tras una transacción.


CREATE TABLE historial_saldo (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta       INT,                -- cuenta afectada
    saldo_anterior  INT,                -- saldo antes del cambio
    saldo_nuevo     INT,                -- saldo despues del cambio
    monto           DECIMAL(14,2),      -- monto de la transaccion
    tipo            VARCHAR(255),       -- tipo de transaccion
    fecha           VARCHAR(255)        -- fecha del cambio
);

DELIMITER //
CREATE TRIGGER TR_ActualizarSaldoCuenta
AFTER INSERT
ON transaccion
FOR EACH ROW
BEGIN
    -- Actualiza el saldo segun el tipo de transaccion
    IF NEW.tipo = 'deposito' THEN
        UPDATE cuenta
        SET saldo = saldo + NEW.monto
        WHERE id_cuenta = NEW.id_cuenta_origen;

    ELSEIF NEW.tipo = 'retiro' THEN
        UPDATE cuenta
        SET saldo = saldo - NEW.monto
        WHERE id_cuenta = NEW.id_cuenta_origen;
    END IF;

    -- Guarda el registro del cambio en la tabla historial
    INSERT INTO historial_saldo (id_cuenta, saldo_anterior, saldo_nuevo, monto, tipo, fecha)
    VALUES (
        NEW.id_cuenta_origen,                           -- cuenta afectada
        (SELECT saldo FROM cuenta WHERE id_cuenta = NEW.id_cuenta_origen), -- saldo actual
        (SELECT saldo FROM cuenta WHERE id_cuenta = NEW.id_cuenta_origen) + NEW.monto, -- saldo nuevo
        NEW.monto,                                      -- monto de la transaccion
        NEW.tipo,                                       -- tipo de transaccion
        NEW.fecha_hora                                  -- fecha de la transaccion
    );
END //
DELIMITER ;

INSERT INTO transaccion (codigo, fecha_hora, tipo, monto, concepto, canal, comprobante, estado, id_cuenta_origen, id_cuenta_destino, id_empleado)
VALUES ('TRX-2026-011', '2026-04-25 10:00:00', 'deposito', 200000, 'Prueba trigger', 'ventanilla', 'COMP-011', 'completada', 1, 2, 1);

SELECT * FROM historial_saldo;


-- 2. TR_VerificarLimitesOperacion: Verifica los límites permitidos para una operación.


CREATE TABLE historial_operaciones_rechazadas (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta   INT,
    monto       DECIMAL(14,2),
    saldo       INT,
    motivo      VARCHAR(255),
    fecha       VARCHAR(255)
);

DELIMITER //
CREATE TRIGGER TR_VerificarLimitesOperacion
BEFORE INSERT ON transaccion
FOR EACH ROW
BEGIN

	IF NEW.tipo = 'retiro' THEN
	IF (SELECT saldo FROM cuenta WHERE id_cuenta = NEW.id_cuenta_origen) < NEW.monto THEN
	
INSERT INTO historial_operaciones_rechazadas (id_cuenta, monto, saldo, motivo, fecha)
VALUES (
    NEW.id_cuenta_origen,
    NEW.monto,
    (SELECT saldo FROM cuenta WHERE id_cuenta = NEW.id_cuenta_origen),
    'Saldo insuficiente',
    NEW.fecha_hora
);

SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Saldo insuficiente para realizar el retiro';
END IF;
    END IF;
END //
DELIMITER ;

INSERT INTO transaccion (codigo, fecha_hora, tipo, monto, concepto, canal, comprobante, estado, id_cuenta_origen, id_cuenta_destino, id_empleado)
VALUES ('TRX-2026-012', '2026-04-25 11:00:00', 'retiro', 99000000, 'Prueba limite', 'cajero', 'COMP-012', 'completada', 1, 2, 1);


-- 3. TR_RegistrarHistorialCredito: Actualiza el historial crediticio de un cliente.


CREATE TABLE historial_credito (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente  INT,
    id_credito  INT,
    monto       INT,
    estado      VARCHAR(255),
    fecha       VARCHAR(255)
);

DELIMITER //
CREATE TRIGGER TR_RegistrarHistorialCredito
AFTER INSERT ON credito
FOR EACH ROW
BEGIN

INSERT INTO historial_credito( id_cliente,id_credito,monto,estado,fecha)
VALUES (
(SELECT id_cliente FROM solicitud WHERE id_solicitud = NEW.id_solicitud),
NEW.id_credito,NEW.monto,NEW.estado,NOW() );

END //
DELIMITER ;

INSERT INTO credito (numero, fecha_desembolso, monto, plazo, tasa_interes, amortizacion, dia_pago, seguros, saldo_actual, proximo_vencimiento, estado, id_solicitud)
VALUES ('OP-2026-011', '2026-04-25', 5000000, 24, 14, 'frances', 5, 'Seguro de vida', 5000000, '2026-05-25', 'vigente', 1);

SELECT * FROM historial_credito;


-- 4. TR_GenerarAlertaOperacionSospechosa: Genera alertas para operaciones sospechosas.


CREATE TABLE alerta_operacion (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta   INT,
    monto       DECIMAL(14,2),
    tipo        VARCHAR(255),
    motivo      VARCHAR(255),
    fecha       VARCHAR(255)
);

DELIMITER //
CREATE TRIGGER TR_GenerarAlertaOperacionSospechosa
AFTER INSERT ON transaccion
FOR EACH ROW
BEGIN
	
	if NEW.monto> 500000 then 
	
	INSERT INTO alerta_operacion (id_cuenta, monto, tipo, motivo, fecha)
VALUES (
    NEW.id_cuenta_origen,
    NEW.monto,
    NEW.tipo,
    'Operacion sospechosa por monto alto',
    NOW()
);
	
	END IF;
END //
DELIMITER ;

INSERT INTO transaccion (codigo, fecha_hora, tipo, monto, concepto, canal, comprobante, estado, id_cuenta_origen, id_cuenta_destino, id_empleado)
VALUES ('TRX-2026-014', '2026-04-25 12:00:00', 'deposito', 9000000, 'Prueba alerta', 'ventanilla', 'COMP-014', 'completada', 1, 2, 1);

SELECT * FROM alerta_operacion;


	
-- 5. TR_ActualizarEstadoPrestamo: Actualiza el estado de un préstamo tras pagos o vencimientos.

CREATE TABLE pago (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    id_credito  INT,
    monto       DECIMAL(14,2),
    fecha       VARCHAR(255)
);

DELIMITER //
CREATE TRIGGER TR_ActualizarEstadoPrestamo
AFTER INSERT ON pago
FOR EACH ROW
BEGIN
    UPDATE credito
    SET saldo_actual = saldo_actual - NEW.monto
    WHERE id_credito = NEW.id_credito;
    
    IF (SELECT saldo_actual FROM credito WHERE id_credito = NEW.id_credito) <= 0 THEN
        UPDATE credito 
		  SET estado = 'pagado'
        WHERE id_credito = NEW.id_credito;
        
	ELSEIF (SELECT proximo_vencimiento FROM credito WHERE id_credito = NEW.id_credito) < NOW() THEN
        UPDATE credito 
		  SET estado = 'vencido'
        WHERE id_credito = NEW.id_credito;
        
END IF;
END //
DELIMITER ;

INSERT INTO pago (id_credito, monto, fecha)
VALUES (1, 14750000, '2026-04-25');

SELECT id_credito, saldo_actual, estado FROM credito WHERE id_credito = 1;