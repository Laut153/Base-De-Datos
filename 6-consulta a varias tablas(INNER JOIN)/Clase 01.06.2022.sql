USE Ventas2

-- CONSULTAS A VARIAS TABLAS

-- Extraer un listado de artículos de la marca AF (cualquier tipo).

SELECT
	articulo,
	nombre,
	marca
FROM
	articulos
WHERE
	marca IN (SELECT
				marca
			FROM
				marcas
			WHERE
				nombre LIKE '%AF%')

SELECT * FROM marcas

SELECT * FROM articulos

SELECT * FROM rubros

-- CONDICIONES EQUIJUNTAS (forma antigua)

SELECT
	a.articulo AS "Código",
	a.nombre AS "Nombre Artículo",
	m.nombre AS "Marca",
	r.nombre AS "Rubro"
FROM
	articulos AS a,
	marcas AS m,
	rubros AS r
WHERE
	a.marca = m.marca
	--AND m.nombre LIKE '%AF%'
	AND a.rubro = r.rubro
	--AND a.nombre LIKE '%CAMPERA%'

-- CLAUSULA JOIN

SELECT
	a.articulo AS "Código",
	a.nombre AS "Nombre Artículo",
	m.nombre AS "Marca",
	r.nombre AS "Rubro"
FROM
	articulos AS a
	INNER JOIN marcas AS m 	ON a.marca = m.marca
	INNER JOIN rubros AS r	ON a.rubro = r.rubro
WHERE
--	a.nombre LIKE '%CAMPERA%'
	m.nombre LIKE '%AF%'

	
-- Listar los vendedores que realizaron ventas superiores a $100 en la primera quincena del mes de septiembre de 2006

SELECT
	s.denominacion,
	v.nombre,
	vc.fecha,
	vc.total
FROM
	vencab AS vc
	INNER JOIN vendedores AS v ON vc.vendedor = v.vendedor
	INNER JOIN sucursales AS s ON vc.sucursal = s.sucursal
WHERE
	vc.anulada = 0
	AND vc.fecha BETWEEN '2006-09-01' AND '2006-09-15'
	AND vc.total > 100
ORDER BY
	1, 2, 4 DESC

-- Listar las facturas en las que se vendieron REMERAS en el año 2007. Mostrar código, fecha, total de la factura,
-- y descripción del artículo.

SELECT DISTINCT
	vc.letra,
	vc.factura,
	vc.fecha,
	vc.total,
	a.articulo,
	a.nombre,
	r.nombre
FROM
	vencab AS vc
	INNER JOIN vendet AS vd ON vc.letra = vd.letra AND vc.factura = vd.factura
	INNER JOIN articulos AS a ON vd.articulo = a.articulo
	INNER JOIN rubros AS r ON a.rubro = r.rubro
WHERE
	vc.anulada = 0
	AND YEAR(vc.fecha) = 2007
	AND r.nombre LIKE '%REMERA%'


/*
EJERCICIO 1

Mostrar el nombre del vendedor y su fecha de ingreso, de todos los vendedores
que vendieron prendas de la marca 'B52' en el local de 'PATIO OLMOS' 
TABLAS: vencab, vendet, vendedores, articulos, marcas, sucursales
*/
SELECT 
	DISTINCT
	v.nombre,
	v.ingreso
FROM 
	vencab AS vc
	INNER JOIN vendet AS vd ON vc.factura = vd.factura AND vc.letra = vd.letra
	INNER JOIN vendedores AS v ON vc.vendedor = v.vendedor
	INNER JOIN sucursales AS s ON vc.sucursal = s.sucursal
	INNER JOIN articulos AS a ON vd.articulo = a.articulo
	INNER JOIN marcas AS m ON a.marca = m.marca
WHERE
	m.nombre LIKE '%B52%'
	AND s.denominacion LIKE '%PATIO OLMOS%'
	AND vc.anulada = 0
ORDER BY 
	v.nombre
/* 
EJERCICIO 2

La marca AF decidió enviar un obsequio a aquellos clientes que hicieron alguna compra mayorista de su artículos.
Identificar a esos clientes, su dirección (domicilio, localidad y cp). Excluya ventas anuladas y ordene por cliente.

TABLAS: mayorcab, mayordet, articulos, marcas, clientes

*/
SELECT DISTINCT
	c.nombre,
	--c.domicilio,
	--c.localidad,
	--c.cp
	RTRIM(c.domicilio) + ' (CP: ' + RTRIM(c.cp) + ')' AS "Dirección"
FROM
	mayorcab AS mc
	INNER JOIN	mayordet AS md
	ON mc.letra = md.letra AND mc.factura = md.factura
	INNER JOIN articulos AS a
	ON md.articulo = a.articulo
	INNER JOIN marcas AS m
	ON a.marca = m.marca	
	INNER JOIN clientes AS c
	ON mc.cliente = c.cliente
WHERE
	mc.anulada = 0
	AND m.nombre LIKE '%AF%'
ORDER BY
	1
/*
EJERCICIO 3

Buscar para el mes de Setiembre de 2005, el nombre del vendedor, el nombre de la sucursal, 
la letra y número de factura, el código del articulo y su nombre, mostrando el precio
vendido y el precio de venta, para aquellos artículos que se vendieron a un valor inferior
al 10% menos del precio estipulado para la venta.

TABLAS: vencab, vendet, vendedores, articulos, sucursales
*/
SELECT 
	v.nombre,
	s.denominacion,
	vc.letra,
	vc.factura,
	a.articulo,
	a.nombre AS 'Nombre del articulo',
	vd.precio AS 'Vendido',
	vd.precioventa

FROM 
	vencab AS vc
	INNER JOIN vendet AS vd ON vc.letra = vd.letra AND vc.factura=vd.factura
	INNER JOIN vendedores AS v ON vc.vendedor = v.vendedor
	INNER JOIN sucursales AS s ON vc.sucursal = s.sucursal
	INNER JOIN articulos AS a ON vd.articulo = a.articulo
WHERE
	YEAR(vc.fecha) = 2005
	AND MONTH(vc.fecha) = 9
	AND vc.anulada = 0
	AND vd.precio < (vd.precioventa - (vd.precioventa*10/100))

