/*

EJERCICIO: CREACION DE PROCEDIMIENTO ALMACENADO CON COMPROBACIÓN DE ERRORES.

Desarrolle el SP "sp_ventas_anuales", que genera la tabla "tmp_ventas_anuales" que debe contener el total de ventas 
minoristas por artículo.

La tabla debe tener las columnas ARTICULO, CANTIDAD, IMPORTE. Tenga en cuenta los siguientes puntos:

	- Se deben excluir ventas anuladas.
	- Se debe tomar para el cálculo del importe CANTIDAD * PRECIO de la tabla VENDET.
	- El procedimiento debe recibir como parámetro de entrada el AÑO, y generar la tabla con las ventas de ese año solamente.
	- Se debe evaluar la existencia de la tabla. Si no existe usar SELECT..INTO para crearla, y si existe usar TRUNCATE con
	  INSERT..SELECT para vaciarla y llenarla.
	- Realizar control de errores, mostrando el mensaje "La tabla fue generada con éxito, se insertaron [n] filas." en caso de
	  éxito, o en caso contrario mostrar "Se produjo un error durante la inserción. Contacte con el administrador".

TIP: para evaluar si la tabla existe o no, utilice la función OBJECT_ID([nombre_objeto]), que retorna NULL si un objeto no
existe, o un número entero que identifica al objeto en caso contrario. Ver el ejemplo debajo.

*/

USE Ventas2

SELECT OBJECT_ID('marcas') AS "Indentificador del objeto:" -- TABLA QUE EXISTE

SELECT OBJECT_ID('proveedores') AS "Indentificador del objeto:" -- TABLA QUE NO EXISTE