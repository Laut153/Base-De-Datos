/*

CONSULTA 1: RECUPERACIÓN DE DATOS SIMPLE

Listar todos los artículos que cumplan con las siguientes condiciones:
- su preciomenor tenga un valor entre 5.00 y 30.00
- su código (articulo) comience con la letra K
- contanga en su nombre la palabra REMERA

Presentar las columnas ARTICULO, NOMBRE, PRECIOMENOR y ESTADO. Ordenar por la columna NOMBRE.

TABLAS: articulos (EL RESULTADO DEBE ARROJAR 31 FILAS)

*/
USE Ventas2

SELECT 
	articulo,
	nombre,
	preciomenor,
	estado
FROM
	articulos
WHERE 
	preciomenor BETWEEN 5.00 AND 30.00
	AND articulo like 'k%'
	AND nombre like '%remera%'
ORDER BY 
	nombre

/*

CONSULTA 2: RECUPERACIÓN DE DATOS CON SUBCONSULTA

Basado en la consulta anterior, presente las facturas emitidas, correspondientes a ventas MINORISTAS en donde se incluyeron
éstos artículos.

Excluir las ventas anuladas. Mostrar las columnas LETRA y FACTURA ordenando de manera ascendente. ELIMINE FILAS DUPLICADAS.

TABLAS: vendet (EL RESULTADO DEBE ARROJAR 61 FILAS)

*/
SELECT DISTINCT
	letra,
	factura
FROM 
	vendet
WHERE 
	 articulo IN ( SELECT 
							articulo
						FROM
							articulos
						WHERE 
							preciomenor BETWEEN 5.00 AND 30.00
							AND articulo like 'k%'
							AND nombre like '%remera%')
ORDER BY
	1,2


SELECT * FROM vendet
SELECT * FROM articulos
/*

CONSULTA 3: Uso de SUBCONSULTAS.

Listar los vendedores ACTIVOS que NO realizaron ventas minoristas en el periodo que va del 01/04/2006 al 30/06/2006.

Mostrar las columnas VENDEDOR (código), NOMBRE, ENCARGADO y ACTIVO. Ordenar por nombre del vendedor.

TABLAS: vencab (suconsulta), vendedores (consulta principal) (EL RESULTADO DEBE RETORNAR 68 FILAS)

*/
SELECT 
	vendedor,
	nombre,
	encargado,
	activo
FROM 
	vendedores
WHERE
	activo = 'S'
	AND vendedor NOT IN ( SELECT vendedor 
						  FROM vencab 
						  WHERE (activo = 'S')AND (fecha BETWEEN '2006/04/01' AND '2006/06/30'))

/******************************************************************************************

LAS SOLUCIONES ESTÁN EN EL ARCHIVO ZIP

LA CONTRASEÑA ES EL VALOR DE LA COLUMNA terminalposnet DE LA SUCURSAL 14 (tabla sucursales)

;-)

******************************************************************************************/
SELECT
	terminalposnet
FROM 
	sucursales
