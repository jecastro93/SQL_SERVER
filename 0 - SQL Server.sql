
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
	cantidad integer NOT NULL,
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

-- CONSULTAR DATOS
SELECT * FROM peliculas;
SELECT nombre, actor, cantidad FROM peliculas;
SELECT nombre, duracion, precios FROM peliculas;
SELECT * FROM peliculas WHERE cantidad = 2;
SELECT nombre, actor, cantidad FROM peliculas WHERE actor = 'Tom Cruise';
SELECT * FROM peliculas WHERE duracion = 118;
SELECT nombre, actor, cantidad FROM peliculas WHERE actor <> 'Tom Cruise';--> DIFERENTE <>
SELECT nombre, actor, cantidad FROM peliculas WHERE precios >=120.5;--> MAYOR O MAYOR Y IGUAL >=

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
  documento char(8),
  fechaingreso datetime
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


