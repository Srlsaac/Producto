-- Funciones:
-- 1. FN_CalcularCapacidadEndeudamiento: Calcula la capacidad de endeudamiento de un cliente.

DELIMITER //                         
CREATE FUNCTION FN_CalcularCapacidadEndeudamiento(
    p_ingresos INT                   
)
RETURNS INT                         
DETERMINISTIC                       

BEGIN                                         
    DECLARE v_capacidad INT;                  
    SET v_capacidad = p_ingresos * 30 / 100;   
    RETURN v_capacidad;                       
END //                                         
DELIMITER ;                                    

SELECT nombre, ingresos, FN_CalcularCapacidadEndeudamiento(ingresos) AS capacidad_endeudamiento
FROM cliente;

-- 2. FN_VerificarDisponibilidadFondos: Verifica la disponibilidad de fondos para una operación.

DELIMITER //                          
CREATE FUNCTION disponibilidad_fondos(
	p_id_cuenta INT,                 
    p_monto INT                      		 
)
RETURNS VARCHAR(10) 

BEGIN
    DECLARE v_saldo INT;                        
    SELECT saldo INTO v_saldo                   
    FROM cuenta                                
    WHERE id_cuenta = p_id_cuenta;  
	 
	 IF v_saldo >= p_monto THEN                  
        RETURN 'SI';                            
    ELSE                                        
        RETURN 'NO';                           
    END IF;
END //                                          
DELIMITER ;     

SELECT disponibilidad_fondos(6, 90000000);  

-- 3. FN_ObtenerHistorialCrediticio: Recupera el historial crediticio completo de un cliente.

DELIMITER //                                    
CREATE FUNCTION FN_ObtenerHistorialCrediticio(
    p_id_cliente INT                            
)
RETURNS VARCHAR(500)                            
DETERMINISTIC                                   

BEGIN
    DECLARE v_total_creditos INT;               

    SELECT COUNT(*) INTO v_total_creditos      
    FROM credito cr
    INNER JOIN solicitud s ON s.id_solicitud = cr.id_solicitud
    WHERE s.id_cliente = p_id_cliente;          

    RETURN CONCAT('Total creditos: ', v_total_creditos);  -- devuelve el resultado como texto
END //
DELIMITER ;

SELECT FN_ObtenerHistorialCrediticio(4);

-- 4. FN_CalcularCuotasPrestamo: Calcula las cuotas de un préstamo según monto, tasa y plazo.

DROP FUNCTION cuotas

DELIMITER //
CREATE FUNCTION FN_CalcularCuotasPrestamo(
	c_monto INT,
	c_tasa INT, 
	c_plazo INT 
	 )
RETURNS INT                          
DETERMINISTIC

BEGIN
	DECLARE v_cuota INT;
	SET v_cuota = c_monto * (c_tasa / 100) / (1 - POW(1 + c_tasa / 100, -c_plazo));
	RETURN v_cuota;	
END //
DELIMITER ;

SELECT FN_CalcularCuotasPrestamo (1000000,113,244)



-- 5. FN_DeterminarNivelRiesgoCliente: Determina el nivel de riesgo de un cliente según variables.

DELIMITER //
CREATE FUNCTION lvl_riesgo(
	lvl_id_cliente INT 
	 )
	
	RETURNS  VARCHAR(10)                       
	DETERMINISTIC
	BEGIN 
		DECLARE riesgo INT;
		SELECT ingresos INTO riesgo
		FROM cliente
		WHERE id_cliente=	lvl_id_cliente;
		
IF riesgo >= 5000000 THEN                  
    RETURN 'bajo';   
ELSEIF riesgo >= 3000000 THEN   
    RETURN 'medio'; 
ELSE 
    RETURN 'alto';                           
END IF;
END //  
DELIMITER ;	
	
	SELECT lvl_riesgo (3)
		
		
		
		