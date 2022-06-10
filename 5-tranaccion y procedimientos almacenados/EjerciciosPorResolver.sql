/*

EJERCICIO: CREACION DE PROCEDIMIENTO ALMACENADO CON COMPROBACI�N DE ERRORES.

Desarrolle el SP "sp_ventas_anuales", que genera la tabla "tmp_ventas_anuales" que debe contener el total de ventas 
minoristas por art�culo.

La tabla debe tener las columnas ARTICULO, CANTIDAD, IMPORTE. Tenga en cuenta los siguientes puntos:

	- Se deben excluir ventas anuladas.
	- Se debe tomar para el c�lculo del importe CANTIDAD * PRECIO de la tabla VENDET.
	- El procedimiento debe recibir como par�metro de entrada el A�O, y generar la tabla con las ventas de ese a�o solamente.
	- Se debe evaluar la existencia de la tabla. Si no existe usar SELECT..INTO para crearla, y si existe usar TRUNCATE con
	  INSERT..SELECT para vaciarla y llenarla.
	- Realizar control de errores, mostrando el mensaje "La tabla fue generada con �xito, se insertaron [n] filas." en caso de
	  �xito, o en caso contrario mostrar "Se produjo un error durante la inserci�n. Contacte con el administrador".

TIP: para evaluar si la tabla existe o no, utilice la funci�n OBJECT_ID([nombre_objeto]), que retorna NULL si un objeto no
existe, o un n�mero entero que identifica al objeto en caso contrario. Ver el ejemplo debajo.

*/

USE Ventas2

SELECT OBJECT_ID('marcas') AS "Indentificador del objeto:" -- TABLA QUE EXISTE

SELECT OBJECT_ID('proveedores') AS "Indentificador del objeto:" -- TABLA QUE NO EXISTE