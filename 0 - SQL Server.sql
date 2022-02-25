
/*-------------- TIPOS DE DATOS --------------
------- 1. TEXTO -------
	VARCHAR(X) -> Permite caracteres de 1 a 8000
	CHAR(X) -> Permite caracteres de 1 a 8000, se usa especialmente en valores que no son cambiantes, por ejemplo campo sexo "M-F"
	TEXT -> permite caracteres hasta de 2mil millones
	NVARCHAR(X) -> es similar a "varchar", excepto que permite almacenar caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
	NCHAR(X) -> es similar a "char" excpeto que acepta caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
	NTEXT -> es similar a "text" excepto que permite almacenar caracteres Unicode, puede contener hasta 1000000000 caracteres. No admite argumento para especificar su longitud.		

------- 2. NUMERICOS -------
	VALORES ENTEROS
	INT / INTEGER -> su rango es de -2.000.000.000 a 2.000.000.000
	SMALLINT -> Puede contener hasta 5 digitos. Su rango va desde -32000 hasta 32000 aprox
	TINYINY -> Puede almacenar valores entre 0 y 255
	BIGINT -> su rango es de -9.000.000.000.000.000.000 hasta 9.000.000.000.000.000.000

	VALORES EXACTOS con decimales
	DECIMAL(4,2) -> Este tipo numerico redondea el valor al mas cercano, es decir, el valor "12.686", guardara "12.69" o el valor "12.682", guardara "12.67"

	VALORES APROXIMADOS con decimales
	FLOAT -> 
	REAL ->

	VALORES MONETARIOS
	MONEY -> Puede tener hasta 19 digitos y solo 4 de ellos puede ir luego del separador decimal; entre -900000000000000.5808 aprox y 900000000000000.5807
	SMALLMONEY -> Entre -200000.3648 y 200000.3647 aprox

------- 3. FECHA Y HORA -------
	DATETIME -> puede almacenar valores desde 01 de enero de 1753 hasta 31 de diciembre de 9999
	SMALLDATETIEM -> el rango va de 01 de enero de 1900 hasta 06 de junio de 2079

	SQL Server reconoce varios formatos de entrada de datos de tipo fecha. PODEMOS INGRESAR DATOS CON "/", "-", "."
	Para establecer el orden de las partes de una fecha (dia, mes y anio) empleamos "set dateformat". Estos son los formatos:

	-mdy: 4/15/96 (mes y dia con 1 o 2 digitos y anio con 2 o 4 digitos),
	-myd: 4/96/15,
	-dmy: 15/4/1996
	-dym: 15/96/4,
	-ydm: 96/15/4,
	-ydm: 1996/15/4

	set dateformat dmy
*/

-- IF OBJECT_ID -> Sirve para verificar si la tabla que vamos a crear existe o no existe
if object_id('peliculas') is not null
	drop table peliculas;

-- CREAR TABLA
create table peliculas(
  oid integer IDENTITY(1,1) PRIMARY KEY NOT NULL, -- LLAVE PRIMARIA e IDENTITY para AUTOINCREMENTAR
	nombre varchar(50) NOT NULL,
	actor varchar(50) NOT NULL,
	duracion integer NOT NULL,
	cantidad integer NULL,
	precios float NULL
);

-- Sirve para dividir el lote de sentencias
GO

-- SP_COLUMNS -> Procedimiento almacenado para ver el detalle de las tablas
exec sp_columns peliculas;

-- INSERTAR DATOS
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 128, 3, 120.50);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 2', 'Tom Cruise', 150, 2, 150);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mujer bonita', 'Julia Roberts', 118, 3, 95.50);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Elsa y Fred', 'China Zorrilla', 110, 2, 50);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 118, 3, 120.50);
INSERT INTO peliculas VALUES ('Mision Imposible 1', 'Tom Cruise', 118, 3, 2000); --DE ESTA MANERA PODEMOS INSERTAR DATOS SIN NECESIDAD DE DECLARAR LOS CAMPOS
INSERT INTO peliculas (nombre, actor, duracion) VALUES ('Mision Imposible 1', 'Tom Cruise', 2222); -- DE ESTA MANERA INSERTAMOS LOS DATOS QUE QUEREMOS

-- CONSULTAR DATOS
SELECT * FROM peliculas;
SELECT nombre, actor, cantidad FROM peliculas;
SELECT nombre, duracion, precios FROM peliculas;
SELECT * FROM peliculas WHERE cantidad = 2;
SELECT nombre, actor, cantidad FROM peliculas WHERE actor = 'Tom Cruise';
SELECT * FROM peliculas WHERE duracion = 118;
SELECT nombre, actor, cantidad FROM peliculas WHERE actor <> 'Tom Cruise';--> DIFERENTE <>
SELECT nombre, actor, cantidad FROM peliculas WHERE precios >=120.5;--> MAYOR O MAYOR Y IGUAL >=
SELECT nombre+'-'+actor FROM peliculas; --> USAMOS "+" PARA CONCATENAR DOS CAMPOS
SELECT nombre, (cantidad*precios)  FROM peliculas --> USAMOS * PARA MULTIPLICAR CANTIDAD Y PRECIO 
SELECT nombre, (cantidad*precios)  AS precio FROM peliculas --> USAMOS "AS" PARA PONER ALIAS AL RESULTADO
SELECT nombre+'-'+actor AS 'nombre total' FROM peliculas;  --> USAMOS "AS" PARA PONER ALIAS AL RESULTADO Y "'" SE USA CUANDO EL ALIAS TIENE MAS DE UNA PALABRA

-- ELIMINAR DATOS
DELETE FROM peliculas; --> ELIMINA TODOS LOS REGISTROS
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 118, 15, 500);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 1', 'Tom Cruise', 222, 15, 650);
DELETE FROM peliculas WHERE precios >=500;
DELETE FROM peliculas WHERE duracion = 222;
DELETE FROM peliculas WHERE oid = 7;
DELETE FROM peliculas WHERE cantidad = 15; 

-- ACTUALISAR DATOS
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 4', 'Tom Cruise', 118, 15, 500);
UPDATE peliculas SET nombre='AVENGERS' WHERE nombre = 'Mision Imposible 4' AND duracion = 118;
UPDATE peliculas SET cantidad=12 WHERE nombre = 'AVENGERS';
UPDATE peliculas SET duracion=90 WHERE cantidad = 12;
UPDATE peliculas SET duracion=190, actor='JHON C' WHERE precios = 500;
UPDATE peliculas SET duracion=999, actor='JHON CASTRO' WHERE actor LIKE 'JHON%'; --> % NOS SIRVE PARA ACTUALIZAR TODOS LOS REGISTROS QUE TENGAN JHON

-- VALORES NULL
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES ('Mision Imposible 4', 'Tom Cruise', 118, 15, NULL);
INSERT INTO peliculas (nombre, actor, duracion, cantidad, precios) VALUES (' ', 'Tom Cruise', 118, 15, NULL);
SELECT * FROM peliculas WHERE precios is NULL
DELETE FROM peliculas WHERE precios is NULL

-- CLAVE/LLAVE PRIMARIA
if OBJECT_ID ('usuarios') is not null
	drop table usuarios;

create table usuarios(
	nombre varchar (20),
	clave varchar (10),
	PRIMARY KEY (nombre) -- MANERA 1 PARA ASIGNAR LLAVE PRIMARIA
);
create table usuarios(
	nombre varchar (20) PRIMARY KEY,-- MANERA 2 PARA ASIGNAR LLAVE PRIMARIA
	clave varchar (10)
);

/*
IDENTITY sirve para poner un campo INTEGER en AUTOINCREMENTAR
AL PONER (100,2) INDICAMOS EL NUMERO EN Q EMPEZARA Y EL NUMERO EN QUE CONTINUARA, INICIA EN 100 Y EL SIGUIENTE REGISTRO SERA 102
*/
create table peliculas(
  oid integer IDENTITY(1,1) PRIMARY KEY NOT NULL, -- LLAVE PRIMARIA e IDENTITY para AUTOINCREMENTAR
	nombre varchar(50) NOT NULL,
);

SELECT IDENT_SEED ('PELICULAS') --> EL COMANDO IDENT_SEED NOS INDICA EL INICIO DEL CAMPO QUE CREAMOS
SELECT IDENT_INCR ('PELICULAS') --> EL COMANDO IDENT_INCR NOS INDICA DE CUANTO ES EL INCREMENTO DEL CAMPO
SET IDENTITY_INSERT peliculas ON --> EL COMANDO IDENTITY_INSERT PERMITE INGRESAR UN VALOR EN EL CAMPO QUE TENEMOS IDENTITY
INSERT INTO peliculas (OID, nombre, actor, duracion, cantidad, precios) VALUES (12,'Mision Imposible 4', 'Tom Cruise', 118, 15, NULL);
DELETE FROM peliculas WHERE OID = 12
SET IDENTITY_INSERT peliculas OFF --> DESACTIVAMOS EL COMANDO IDENTITY_INSERT

--TRUNCATE TABLE Vacia toda la tabla y adicional reinicia el conteo autoincrement
TRUNCATE TABLE peliculas;

--DATE TIPO DE DATOS DATETIME
if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  nombre varchar(20),
  documento varchar(20) DEFAULT 'Pendiente',
  fechaingreso datetime
  cantidad integer DEFAULT 0
);
set dateformat dmy; --LE DAMOS FORMATO A LA FECHA

insert into empleados values('Ana Gomez','22222222','12-01-1980');
insert into empleados values('Bernardo Huerta','23333333','15-03-81');
insert into empleados values('Carla Juarez','24444444','20/05/1983');
insert into empleados values('Daniel Lopez','25555555','2.5.1990')

select * from empleados;
select * from empleados where fechaingreso < '01-01-1985';
update empleados set nombre='Maria Carla Juarez' where fechaingreso = '20.5.83';
delete from empleados where fechaingreso <> '20/05/1983';

--VALORES DEFAULT
if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  nombre varchar(20),
  documento varchar(20) DEFAULT 'Pendiente', --AL NO INGRESAR VALORES LOS DEFAULT VAN A TENER UN VALOR POR DEFECTO
  fechaingreso datetime,
  cantidad integer NULL DEFAULT 0 --AL NO INGRESAR VALORES LOS DEFAULT VAN A TENER UN VALOR POR DEFECTO
);
set dateformat dmy;

insert into empleados values('Ana Gomez','22222222','12-01-1980',2);
insert into empleados values('Bernardo Huerta','23333333','15-03-81',3);
insert into empleados (nombre, fechaingreso) values('Carla Juarez','20/05/1983');
insert into empleados (nombre, documento, fechaingreso)values('Daniel Lopez','25555555','2.5.1990');

select * from empleados;


/*-------------- FUNCIONES --------------
Una funcion es un conjunto de sentencias que operan como una unidad logica.
Una funcion tiene un nombre, retorna un parametro de salida y opcionalmente acepta parametros de entrada. 
Las funciones de SQL Server no pueden ser modificadas, las funciones definidas por el usuario si.
SQL Server ofrece varios tipos de funciones para realizar distintas operaciones.

------- 1 . FUNCIONES PARA MANEJO DE CARACTERES -------
	SUBSTRING(cadena,inicio,longitud) --> Devuelve una parte de la cadena especificada, empezando desde el inicio y termina con la longitud estipulada
		ejem: select substring('Buenas tardes',8,6); --> retorna "tardes" --> Dado que empieza en la posicion 8 que es "T" y termina con la longitud que son 6.
	STR(numero,longitud,cantidaddecimales) --> Convierte un numero a caracteres
		ejem: select str(123.456,7,2); --> retorna '123.46' --> Dado que el numero a convertir solo permite 2 decimales y su longitud es de 7.
	STUFF(cadena1,inicio,cantidad,cadena2) --> inserta la cadena enviada como cuarto argumento, en la posicion indicada en el segundo argumento, reemplazando la cantidad de caracteres indicada por el tercer argumento
		ejem: select stuff('abcde',3,2,'opqrs'); --> retorna "abopqrse". Es decir, coloca en la posicion 3 la cadena "opqrs" y reemplaza 2 caracteres de la primer cadena
	LEN(cadena) --> retorna la longitud de la cadena, cantidad de caracteres
		ejem: select len('Hola'); --> retorna 4
	CHAR(x) --> retorna un caracter en codigo ASCII del entero enviado
		ejem: select char(65); --> retorna A
	LEFT(cadena,longitud): retorna la cantidad de caracteres de la cadena comenzando desde la izquierda
		ejem: select left('buenos dias',8); --> retorna "buenos d"
	RIGHT(cadena,longitud): retorna la cantidad de caracteres de la cadena comenzando desde la derecha
		ejem: select right('buenos dias',8); --> retorna "nos dias
	LOWER(cadena): retornan la cadena con todos los caracteres en minusculas
		ejem: select lower('HOLA ESTUDIAnte'); --> retorna "hola estudiante"
	UPPER(cadena): retornan la cadena con todos los caracteres en mayusculas
		ejem: select upper('HOLA ESTUDIAnte'); --> retorna "HOLA ESTUDIANTE"
	LTRIM(cadena): retorna la cadena con los espacios de la izquierda eliminados
		ejem: select ltrim('     Hola     '); --> retorna "Hola     "
	RTRIM(cadena): retorna la cadena con los espacios de la derecha eliminados
		ejem: select rtrim('     Hola     '); --> retorna "     Hola"
	REPLACE(cadena,cadenareemplazo,cadenareemplazar) --> reemplaza todas las cadenas definidas en el 3 parametro por la del 2 parametro
		ejem: select replace('xxx.sqlserverya.com','x','w'); --> retorna "www.sqlserverya.com'
	REVERSE(cadena)--> devuelve la cadena invirtiendo el order de los caracteres
		ejem: select reverse('Hola'); --> retorna "aloH"
	PATINDEX(patron,cadena) --> devuelve la posicion de comienzo del patron especificado.
		ejem: select patindex('%Luis%', 'Jorge Luis Borges'); --> retorna 7
	CHARINDEX(subcadena,cadena,inicio) --> devuelve la posicion donde comienza la subcadena en la cadena, comenzando la busqueda desde la posicion indicada por "inicio"
		ejem: select charindex('or','Jorge Luis Borges',5); --> retorna 13
	REPLICATE(cadena,cantidad) --> repite una cadena la cantidad de veces especificada
		ejem: select replicate ('Hola ',3); --> retorna "HolaHolaHola"
	SPACE(cantidad) --> retorna una cadena de espacios de longitud indicada por cantidad
		ejem: select 'Hola'+space(1)+'que tal'; --> retorna "Hola que tal"

------- 2. FUNCIONES MATEMATICAS -------
	ABS(x): retorna el valor absoluto del argumento "x"
		ejem: select abs(-20); --> retorna 20
	

*/