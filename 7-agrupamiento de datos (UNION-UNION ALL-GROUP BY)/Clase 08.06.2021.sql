USE Ventas2

/*

AGRUPAMIENTO DE DATOS

UNION / UNION ALL

*/

-- DETERMINAR PARA CADA AÑO EL MAYOR IMPORTE DE UNA FACTURA

SELECT
	YEAR(fecha) AS "Año", -- Criterio de agrupamiento
	MONTH(fecha) AS "Mes", -- Criterio de agrupamiento
	--SUM(total) AS "Importe", -- Función de agrupamiento
	MAX(total) AS "Mayor Importe" -- Función de agrupamiento
	--total
FROM
	vencab
WHERE
	anulada = 0
GROUP BY -- Establece los criterios de agrupamiento
	YEAR(fecha),
	MONTH(fecha)
ORDER BY
	1, 2


-- DETERMINAR EL IMPORTE COMPRADO POR CADA CLIENTE EN CADA AÑO DE FORMA MAYORISTA

SELECT
	c.nombre AS "Cliente",
	YEAR(mc.fecha) AS "Año",
	--mc.total AS "Total Comprado"
	--YEAR(mc.fecha) AS "Año",
	SUM(mc.total) AS "Total Comprado"
	--COUNT(mc.factura) AS "Cantidad de Facturas",
	--AVG(mc.total) AS "Venta Promedio"
FROM
	mayorcab AS mc
	INNER JOIN clientes AS c
	ON mc.cliente = c.cliente
WHERE
	mc.anulada = 0
GROUP BY
	c.nombre,
	YEAR(mc.fecha)
ORDER BY
	1,2 


-- DETERMINAR EL TOTAL VENDIDO (MINORISTA) POR AÑO Y POR MES (EXCLUIR VENTAS ANULADAS)

SELECT
	YEAR(fecha) AS "Año", -- Criterio de agrupamiento
	MONTH(fecha) AS "Mes", -- Criterio de agrupamiento
	SUM(total) AS "Importe" -- Función de agrupamiento
FROM
	vencab
WHERE
	anulada = 0
GROUP BY -- Establece los criterios de agrupamiento
	YEAR(fecha),
	MONTH(fecha)
--HAVING
--	SUM(total) < 500000


-- DETERMINAR EL TOTAL VENDIDO (MAYORISTA) POR AÑO Y POR MES (EXCLUIR VENTAS ANULADAS)

SELECT
	YEAR(fecha) AS "Año", -- Criterio de agrupamiento
	MONTH(fecha) AS "Mes", -- Criterio de agrupamiento
	SUM(total) AS "Importe" -- Función de agrupamiento
FROM
	mayorcab
WHERE
	anulada = 0
GROUP BY -- Establece los criterios de agrupamiento
	YEAR(fecha),
	MONTH(fecha)
--HAVING
	--SUM(total) < 500000

-- UNION / UNION ALL

SELECT
	'Minorista' AS "Tipo Venta",
	YEAR(fecha) AS "Año", -- Criterio de agrupamiento
	MONTH(fecha) AS "Mes", -- Criterio de agrupamiento
	SUM(total) AS "Importe" -- Función de agrupamiento
FROM
	vencab
WHERE
	anulada = 0
GROUP BY -- Establece los criterios de agrupamiento
	YEAR(fecha),
	MONTH(fecha)
HAVING
	SUM(total) < 1000000
--
UNION ALL
--
SELECT
	'Mayorista' AS "Tipo Venta",
	YEAR(fecha) AS "Año", -- Criterio de agrupamiento
	MONTH(fecha) AS "Mes", -- Criterio de agrupamiento
	SUM(total) AS "Importe" -- Función de agrupamiento
FROM
	mayorcab
WHERE
	anulada = 0
GROUP BY -- Establece los criterios de agrupamiento
	YEAR(fecha),
	MONTH(fecha)
HAVING
	SUM(total) < 1000000
--
ORDER BY
	2,3,1


SELECT 1,'Hola'
UNION
SELECT 2,'****************'
UNION ALL
SELECT 3,'Chau'

/*

DETERMINAR LAS SUCURSALES QUE EN EL AÑO 2006 SUPERARON LAS 500 VENTAS MENSUALES. DETALLAR EL MES
Y LA CANTIDAD DE VENTAS (COUNT)

*/

SELECT
	s.denominacion AS "Sucursal",
	MONTH(vc.fecha) AS "Mes",
	--vc.letra,
	COUNT(vc.factura) AS "Cantidad de ventas"
FROM
	vencab AS vc
	INNER JOIN sucursales AS s
	ON vc.sucursal = s.sucursal
WHERE
	vc.anulada = 0
	AND YEAR(vc.fecha) = 2006
GROUP BY
	s.denominacion,
	MONTH(vc.fecha)
HAVING
	COUNT(vc.factura) > 500
ORDER BY
	1,2
	
/*

EJERCICIO 1:

Determinar la comision por ventas para cada local, mostrando nombre de local, mes, importe total de ventas, comision.
Calcular para el año 2006. Para aplicar al comision se utilizará un porcentaje de 1.7 % sobre el total de la venta.

TABLAS: SUCURSALES (sucursal) VENCAB (sucursal)

*/
SELECT 
	s.denominacion,
	MONTH(vc.fecha) AS 'Mes',
	SUM(vc.total) AS 'Importe total',
	(1.7*SUM(vc.total))/100 AS 'Comision'
FROM 
	sucursales AS s
	INNER JOIN vencab AS vc ON s.sucursal=vc.sucursal
WHERE 
	YEAR(vc.fecha) = 2006
GROUP BY
	s.denominacion,
	MONTH(vc.fecha)
ORDER BY 
	1,2
/*

EJERCICIO 2

Determinar los 50 mejores clientes mayoristas. Hacer el ranking de compra mostrando aquellos que compraron mas 
de 1000 prendas y gastaron mas de 50000 pesos en el primer semestre de 2006. Excluir ventas anuladas.

TABLAS: CLIENTES (cliente), MAYORCAB (cliente) (letra y factura), MAYORDET (letra y factura)

*/
SELECT * FROM mayordet

SELECT TOP 50 --FUNCIONARIA COMO UN .HEAD()
	c.nombre AS 'Cliente',
	SUM(md.cantidad) AS 'Cantidad de prendas',
	SUM(md.precioventa * md.cantidad) AS 'Total'
FROM 
	clientes AS c
	INNER JOIN mayorcab AS mc ON c.cliente = mc.cliente
	INNER JOIN mayordet AS md ON mc.letra = md.letra AND mc.factura = md.factura
WHERE
	mc.anulada = 0
	AND mc.fecha BETWEEN '2006-01-01' AND '2006-06-30'
GROUP BY 
	c.nombre
HAVING 
	SUM(md.cantidad) > 1000
	AND SUM(md.precioventa * md.cantidad) > 50000
ORDER BY 
	3