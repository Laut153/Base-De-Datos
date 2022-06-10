-- INSTRUCCIÓN SELECT

/*

COMENTARIO
EN
BLOQUE

*/

SELECT	-- Columnas
FROM	-- Tablas
WHERE	-- Condiciones

USE Ventas2

SELECT
	articulo,
	nombre,
	preciomenor
FROM
	articulos
WHERE
	preciomenor > 1000

SELECT * FROM clientes