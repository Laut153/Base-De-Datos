/*

Clase 27.04.2022

TEMAS:
- OPERADORES DE COMPARACIÓN ok
- OPERADORES DE CADENA ok
- OPERADORES DE INTERVALO ok
- OPERADORES LÓGICOS ok

*/

USE Ventas2

SELECT
	articulo,
	nombre,
	preciomenor,
	preciomayor
FROM
	articulos
WHERE
	(preciomenor >= 100 AND preciomenor <= 200)
	OR (preciomayor >= 50 AND preciomayor <= 90)

SELECT * FROM sucursales

SELECT
	sucursal,
	denominacion,
	direccion
FROM
	sucursales
WHERE
	direccion LIKE '%LOC%'

SELECT
	vendedor,
	nombre
FROM
	vendedores
WHERE
	nombre NOT LIKE '%MARIA%'

SELECT
	letra,
	factura,
	fecha,
	vendedor,
	total
FROM
	vencab
WHERE
	--fecha BETWEEN '2007-10-01' AND '2007-10-31'
	fecha BETWEEN '01/10/2007' AND '31/10/2007'
	AND total BETWEEN 100 AND 150

--	fecha >= '2007-10-01'
--	AND fecha <= '2007-10-31'

SELECT * FROM marcas WHERE nombre LIKE '%2DA%'


/*

EJERCICIO 1: LISTAR LOS CÓDIGOS DE LAS SUCURSALES EN LAS QUE SE HICIERON VENTAS MAYORES A $1000 EN EL MES DE MAYO DE 2007.
NO TENGA EN CUENTA VENTAS ANULADAS.

*/

SELECT
	DISTINCT 
	sucursal
FROM
	vencab
WHERE
	total > 1000
	AND anulada = 0
	--AND fecha BETWEEN '01/05/2007' AND '31/05/2007'
	AND YEAR(fecha) = 2007
	AND MONTH(fecha) = 5
ORDER BY
	1 DESC


