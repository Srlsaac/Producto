# BankSys - Funciones MySQL

## Descripción General

Este módulo contiene las funciones del sistema BankSys. Las funciones reciben parámetros, realizan cálculos o consultas y devuelven un valor que puede ser usado dentro de un SELECT.

---

## Estructura del Repositorio

```
repositorio
   sucursal.sql          -- Base de datos principal
   funciones.sql         -- Funciones implementadas
   README.md             -- Documentación
```

---

## Módulos Implementados

### Funciones

| Función | Descripción | Retorna |
|---------|-------------|---------|
| `FN_CalcularCapacidadEndeudamiento` | Calcula el 30% de los ingresos como capacidad de endeudamiento | INT |
| `disponibilidad_fondos` | Verifica si una cuenta tiene fondos suficientes para una operación | VARCHAR |
| `FN_ObtenerHistorialCrediticio` | Recupera el total de créditos de un cliente | VARCHAR |
| `FN_CalcularCuotasPrestamo` | Calcula la cuota mensual de un préstamo según monto, tasa y plazo | INT |
| `lvl_riesgo` | Determina el nivel de riesgo de un cliente según sus ingresos | VARCHAR |

---

## Instrucciones de Uso

### Requisitos
- MySQL o MariaDB
- HeidiSQL u otro cliente SQL
- Base de datos `sucursal` creada previamente

### Pasos para ejecutar

1. Abrir HeidiSQL y conectarse al servidor
2. Asegurarse de tener la base de datos `sucursal` creada ejecutando `sucursal.sql`
3. Cargar y ejecutar el archivo `funciones.sql`
4. Verificar las funciones con `SHOW FUNCTION STATUS WHERE Db = 'sucursal';`

---

## Detalle de cada Función

### 1. FN_CalcularCapacidadEndeudamiento
Calcula la capacidad de endeudamiento de un cliente basándose en el 30% de sus ingresos.
```sql
-- Para un valor especifico
SELECT FN_CalcularCapacidadEndeudamiento(4500000);

-- Para todos los clientes
SELECT nombre, ingresos, FN_CalcularCapacidadEndeudamiento(ingresos) AS capacidad_endeudamiento
FROM cliente;
```

### 2. disponibilidad_fondos
Verifica si una cuenta tiene fondos suficientes para realizar una operación. Devuelve SI o NO.
```sql
-- Verificar si la cuenta 1 tiene fondos para 500000
SELECT disponibilidad_fondos(1, 500000);
```

### 3. FN_ObtenerHistorialCrediticio
Devuelve el total de créditos que tiene un cliente.
```sql
-- Historial del cliente con id 4
SELECT FN_ObtenerHistorialCrediticio(4);

-- Para todos los clientes
SELECT nombre, FN_ObtenerHistorialCrediticio(id_cliente) AS historial
FROM cliente;
```

### 4. FN_CalcularCuotasPrestamo
Calcula la cuota mensual de un préstamo usando la fórmula financiera estándar. Recibe el monto, la tasa de interés y el plazo en meses.
```sql
-- Calcular cuota para un prestamo de 1.000.000 a tasa 11 en 24 meses
SELECT FN_CalcularCuotasPrestamo(1000000, 11, 24);

-- Para todos los creditos
SELECT numero, monto, tasa_interes, plazo,
FN_CalcularCuotasPrestamo(monto, tasa_interes, plazo) AS cuota_mensual
FROM credito;
```

### 5. lvl_riesgo
Determina el nivel de riesgo de un cliente según sus ingresos:
- Ingresos mayor o igual a 5.000.000 = bajo
- Ingresos mayor o igual a 3.000.000 = medio
- Ingresos menor a 3.000.000 = alto
```sql
-- Nivel de riesgo del cliente 3
SELECT lvl_riesgo(3);

-- Para todos los clientes
SELECT nombre, ingresos, lvl_riesgo(id_cliente) AS nivel_riesgo
FROM cliente;
```

---

## Autor

Estudiante: Isaac  
Curso: Base de Datos Avanzado  
Fecha: 2026
