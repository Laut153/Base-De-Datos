/*

EJERCICIO 1: PROCEDIMIENTO ALMACENADO SIMPLE

a) Crear el procedimiento almacenado "sp_cuenta_vendedores" que retorne la cantidad de filas que tiene la tabla VENDEDORES.
b) Ejecutar el procedimiento para validar resultados. Este procedimiento no lleva ningún parámetro de entrada ni de salida.

*/

use Ventas2

-- a)

CREATE OR ALTER PROCEDURE sp_cuenta_vendedores -- LA INSTRUCCION "CREATE OR ALTER" CREA EL OBJETO SI NO EXISTE, Y SI EXISTE LO MODIFICA
AS
DECLARE
	@c int -- DECLARACIÓN DE VARIABLE LOCAL
BEGIN
	SELECT 
		@c = COUNT(*) -- ASIGNA A LA VARIABLE EL RESULTADO DEL COUNT(*)
	FROM 
		vendedores
	--
	PRINT 'La tabla vendedores tiene ' + TRIM(STR(@c)) + ' filas.' -- STR() CONVIERTE A TEXTO; TRIM() QUITA LOS ESPACIOS
END

-- b)

EXEC sp_cuenta_vendedores -- EJECUCIÓN SIN PARÁMETROS


/*

EJERCICIO 2: SP CON PARÁMETROS Y CONTROL DE ERRORES

a) Construir el SP "sp_insertar_marca" que permita insertar una nueva marca en la tabla homónima. El procedimiento debe solicitar
como parámetros de entrada los valores de las tres columnas de la tabla. Deberá validarse en él la ocurrencia de errores y
presentar los mensajes "Hubo un problema! No se pudo insertar la marca." en caso de error, o "La marca [nombre] se insertó
correctamente" en caso de éxito. En caso de que la marca a insertar ya exista, mostrar el mensaje "La marca [marca] ya existe".
b) Ejecutar el procedimiento con parámetros de entrada.

*/

-- a)

CREATE OR ALTER PROCEDURE sp_insertar_marca
	@marca char(1),		-- PARÁMETRO DE ENTRADA
	@nombre char(30),	-- PARÁMETRO DE ENTRADA
	@activo char(1)		-- PARÁMETRO DE ENTRADA
AS
BEGIN

	-- VALIDA LA EXISTENCIA DE LA MARCA A INSERTAR

	IF EXISTS (SELECT * FROM marcas WHERE marca = @marca) -- "EXISTS" VALIDA LA EXISTENCIA DE FILAS EN EL RESULTADO DEL SELECT

		PRINT 'La marca ' + TRIM(@marca) + ' ya existe.'

	ELSE 
		BEGIN
			
			-- REALIZA LA INSERCIÓN EN LA TABLA

			INSERT INTO marcas
				(marca, nombre, activo)
			VALUES
				(@marca,@nombre,@activo)

			-- VALIDA LA OCURRENCIA DE ERRORES

			IF @@ERROR <> 0
				PRINT 'Hubo un problema! No se pudo insertar la marca.'
			ELSE
				PRINT 'La marca ' + TRIM(@nombre) + ' se insertó correctamente.'
		END
END

-- b)

EXEC sp_insertar_marca 'W','WRANGLER','S'

SELECT * FROM marcas -- CONSULTA DE COMPROBACIÓN

/*

EJERCICIO 3: SP CON TRY/CATCH Y USO DE TRANSACCIONES

a) Modificar el SP "sp_insertar_marca" para que utilice los bloques TRY / CATCH en el control de errores, y que además
incorpore realice el INSERT como una TRANSACCIÓN de confirmación explícita mediante COMMIT o ROLLBACK. Los mensajes que
debe retornar el procedimiento son los mismos de antes.
b) Ejecutar el procedimiento con parámetros de entrada.

*/

-- a)

CREATE OR ALTER PROCEDURE sp_insertar_marca
	@marca char(1), 
	@nombre char(30),
	@activo char(1)
AS

BEGIN TRY

	BEGIN TRANSACTION -- INICIA UNA TRANSACCIÓN DE CONFIRMACIÓN EXPLÍCITA CON "COMMIT" O "ROLLBACK"

		-- INTENTA REALIZAR LA INSERCIÓN EN LA TABLA

		INSERT INTO marcas
			(marca, nombre, activo)
		VALUES
			(@marca,@nombre,@activo)

		-- SI INSERTA SIN ERRORES, REALIZA LA CONFIRMACIÓN DE LA TRANSACCION; CASO CONTRARIO SALTA AL BLOQUE "CATCH"

		COMMIT TRANSACTION -- CONFIRMA LA INSERCIÓN

		PRINT 'La marca ' + TRIM(UPPER(@nombre)) + ' se insertó correctamente.'

END TRY

BEGIN CATCH
	
	ROLLBACK TRANSACTION -- VUELVE ATRÁS LA INSERCIÓN

	IF ERROR_NUMBER() = 2627 -- EL ERROR 2627 ES DE CLAVE DUPLICADA (YA EXISTE LA MARCA)
		PRINT 'La marca ' + TRIM(UPPER(@nombre)) + ' ya existe.'
	ELSE
		PRINT 'Hubo un problema! No se pudo insertar la marca.'
	
END CATCH

-- b)

EXEC sp_insertar_marca 'X','XTREME','S'

SELECT * FROM marcas -- CONSULTA DE COMPROBACIÓN

/*

EJERCICIO 4: ELIMINACION DE SP

Elimine los dos procedimientos creados: "sp_cuenta_vendedores" y "sp_insertar_marca".

*/

DROP PROCEDURE sp_cuenta_vendedores

DROP PROCEDURE sp_insertar_marca

DELETE marcas WHERE marca IN ('W','X') -- ELIMINA LAS FILAS INSERTADAS EN LA TABLA MARCAS


