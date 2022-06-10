USE Ventas2

/*

EJERCICIO 1: INSERCIÓN SIMPLE

Insertar en la tabla MARCAS una marca nueva cuyo código es 'V', su nombre es 'VANS' y se encuentra inactiva (ACTIVO = 'N')

*/

INSERT INTO marcas 
	(marca, nombre, activo) 
VALUES 
	('V','NUEVA MARCA','N')

/*

EJERCICIO 2: INSERCIÓN SIMPLE

Insertar en la tabla MARCAS una marca nueva cuyo código es 'W', su nombre es 'WRANGLER', sin especificar si está o no
activa, ya que la columna ACTIVO puede admitir valores nulos.

*/

INSERT INTO marcas
	(marca, nombre)
VALUES
	('W','WRANGLER')


/*

EJERCICIO 3: INSERTAR FILAS DE FORMA MASIVA

Cree la tabla ENCARGADOS que tenga las columnas DNI, NOMBRE, INGRESO y ACTIVO tomando los datos de la tabla
VENDEDORES, y filtrando solamente aquellos que cumplen la condición ENCARGADO = 'S' (48 filas en total)

*/

-- SELECT INTO (Inserta y crea una tabla nueva a partir de un select)

SELECT
	dni,
	nombre,
	ingreso,
	activo
INTO -- La cláusula INTO se ubica siempre a continuación de las columnas del SELECT y antes del FROM
	encargados
FROM
	vendedores 
WHERE 
	encargado = 'S'

/*

EJERCICIO 4: INSERTAR FILAS DE FORMA MASIVA

a) Elimine el contenido de la tabla ENCARGADOS (SIN BORRAR LA TABLA) utilizando la instrucción TRUNCATE
b) Inserte nuevamente los 48 vendedores encargados utilizando INSERT SELECT
c) Elimine la tabla ENCARGADOS

*/

-- a) TRUNCATE TABLE (elimina las filas pero no la estructura, es decir "vacía" la tabla)

TRUNCATE TABLE encargados

-- b) INSERT SELECT (Inserta en una tabla existente a partir de un select)

INSERT INTO encargados
SELECT 
	dni,
	nombre,
	ingreso,
	activo 
FROM 
	vendedores 
WHERE
	encargado = 'S'

-- c) DROP TABLE (elimina el objeto tabla especificado completo, es decir filas y estructura)

DROP TABLE encargados

/*

EJERCICIO 5: MODIFICACIÓN DE DATOS

a) Cambie el nombre de la marca 'V' a 'VANS', y su estado ACTIVO a 'S'
b) Modifique el estado de la marca 'W' a 'S'

*/

--a)

UPDATE 
	marcas
SET 
	nombre = 'VANS',
	activo = 'S' 
WHERE
	marca = 'V'

--b)

UPDATE 
	marcas
SET 
	activo = 'S' 
WHERE
	marca = 'W'


/*

EJERCICIO 6: ELIMINACIÓN DE FILAS

Elimine de la tabla MARCAS las nuevas filas insertadas, correspondientes a las marcas con códigos 'V' y 'W'.

*/

DELETE 
	marcas
WHERE
	marca IN('W','V')
