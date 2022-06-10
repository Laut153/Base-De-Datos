/*

Clase 04.05.2022

TEMAS:
- OPERADORES DE LISTA Ok
- ORDENAMIENTO Ok
- FUNCIONES DE FECHA OK
- PSEUDOCOLUMNAS Ok
- ALIAS Ok
- DISTINCT Ok
- SUBCONSULTA Ok

*/

SELECT
	'Datos artículo; ',
	marca,
	articulo,
	nombre,
	preciomenor,
	preciomenor * 0.9 AS "Precio c/10% dto"
	--preciomayor
FROM
	articulos
WHERE
	marca NOT IN ('C','D','E','F','L','M','N','P','Z')
ORDER BY
	--nombre DESC
	1,2

SELECT DISTINCT marca FROM articulos

SELECT DISTINCT letra FROM mayorcab

SELECT * FROM marcas

SELECT (1236 * 528) / 631 AS "Resultado"

SELECT 200 * 3 AS "Resultado"

SELECT 
	'Hola gente!!!' AS "Saludo llegada",
	'Chau gente!!!' AS "Saludo partida",
	(1236 * 528) / 631 AS "Resultado",
	GETDATE() AS "Fecha Hoy",
	DAY(GETDATE()) AS "Día Hoy",
	MONTH(GETDATE()) AS "Mes Hoy",
	YEAR(GETDATE()) AS "Año Hoy"


SELECT
	letra,
	factura,
	fecha,
	vendedor,
	total
FROM
	vencab
WHERE
	--fecha BETWEEN '2007-01-01' AND '2007-03-31'
	YEAR(fecha) = 2007
	AND MONTH(fecha) IN (1,2,3)


SELECT
	articulo, 
	nombre,
	preciomenor,
	preciomayor,
	preciomayor - preciomenor AS "Diferencia"
FROM
	articulos
WHERE
	preciomayor > preciomenor
	AND (preciomayor - preciomenor) > 10
ORDER BY
	nombre DESC

SELECT 
	* 
FROM 
	vencab 
WHERE
	anulada = 1 
ORDER BY
	3,
	13 DESC
	--fecha,
	--total DESC

-- SUBCONSULTA: Listar los artículos de la marca AF

SELECT * FROM marcas WHERE nombre LIKE '%AF%'

SELECT
	articulo,
	nombre,
	preciomenor,
	preciomayor,
	marca
FROM
	articulos
WHERE
	marca IN ('A','F','J','N','T')

-- usando subconsulta

SELECT
	articulo,
	nombre,
	preciomenor,
	preciomayor,
	marca
FROM
	articulos
WHERE
	marca IN (SELECT marca FROM marcas WHERE nombre LIKE '%AF%')

-- Listar los vendedores que en el año 2008 superaron la mejor venta del año anterior (2007)

SELECT
	MAX(total)
FROM
	vencab
WHERE
	YEAR(fecha) = 2007
	AND anulada = 0
--ORDER BY
--	1 DESC

SELECT DISTINCT
	vendedor
--	total
FROM
	vencab
WHERE
	YEAR(fecha) = 2008
	AND anulada = 0
	AND total > (SELECT
					MAX(total)
				FROM
					vencab
				WHERE
					YEAR(fecha) = 2007
					AND anulada = 0)

/*

EJERCICIO 1: LISTE LOS ARTICULOS DE TIPO "CINTO" DADOS DE ALTA EN EL AÑO 2006, CUYO PRECIO MAYORISTA SEA MENOR 
A SU PRECIO MINORISTA. 
ADEMÁS TENER EN CUENTA QUE LA MARCA SEA 'A','F' o 'Q', Y QUE AMBOS PRECIOS SEAN MAYORES A CERO. PRESENTE: CÓDIGO,
NOMBRE, MARCA, PRECIO X MAYOR, PRECIO X MENOR, Y DIFERENCIA ENTRE AMBOS. 
ORDENE EN FORMA DECRECIENTE POR LA DIFERENCIA DE PRECIOS.

*/

SELECT
	articulo AS "Código",
	nombre AS "Nombre",
	marca AS "Marca",
	--rubro AS "Rubro",
	preciomayor AS "Precio x Mayor",
	preciomenor AS "Precio x Menor",
	(preciomenor - preciomayor) AS "Diferencia"
FROM
	articulos
WHERE
	YEAR(creado) = 2006
	AND preciomenor > 0
	AND preciomayor > 0
	AND preciomayor < preciomenor
	AND marca IN('A','F','Q')
	AND nombre LIKE '%CINTO%' 
	--AND rubro IN (70,76)
ORDER BY
	6 DESC

/*

EJERCICIO 2: PRESENTE EL CÓDIGO, EL NOMBRE Y LA SUCURSAL DE LOS VENDEDORES QUE SEAN ENCARGADOS, QUE ESTÉN ACTIVOS
Y QUE ALGUNA VEZ RECIBIERON UNIFORME (tabla uniformes). UTILICE SUBCONSULTA.

*/

SELECT 
	vendedor,
	nombre,
	sucursal
FROM
	vendedores
WHERE
	activo = 'S'
	AND encargado = 'S'
	AND vendedor IN (SELECT DISTINCT vendedor FROM uniformes)

