
/*------------------------------------------ TIPOS DE DATOS ------------------------------------------
-------------- 1. TEXTO --------------
	VARCHAR(X) -> Permite caracteres de 1 a 8000
	CHAR(X) -> Permite caracteres de 1 a 8000, se usa especialmente en valores que no son cambiantes, por ejemplo campo sexo "M-F"
	TEXT -> permite caracteres hasta de 2mil millones
	NVARCHAR(X) -> es similar a "varchar", excepto que permite almacenar caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
	NCHAR(X) -> es similar a "char" excpeto que acepta caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
	NTEXT -> es similar a "text" excepto que permite almacenar caracteres Unicode, puede contener hasta 1000000000 caracteres. No admite argumento para especificar su longitud.		

-------------- 2. NUMERICOS --------------
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

-------------- 3. FECHA Y HORA --------------
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

-- TRUNCATE TABLE Vacia toda la tabla y adicional reinicia el conteo autoincrement
TRUNCATE TABLE peliculas;

-- DATE TIPO DE DATOS DATETIME
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

-- VALORES DEFAULT
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


/*------------------------------------------ FUNCIONES ------------------------------------------
Una funcion es un conjunto de sentencias que operan como una unidad logica.
Una funcion tiene un nombre, retorna un parametro de salida y opcionalmente acepta parametros de entrada. 
Las funciones de SQL Server no pueden ser modificadas, las funciones definidas por el usuario si.
SQL Server ofrece varios tipos de funciones para realizar distintas operaciones.

-------------- 1 . FUNCIONES PARA MANEJO DE CARACTERES --------------
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

-------------- 2. FUNCIONES MATEMATICAS --------------
	ABS(x): retorna el valor absoluto del argumento "x"
		ejem: select abs(-20); --> retorna 20
	CEILING(x): redondea hacia arriba el argumento "x"
		ejem: select ceiling(12.34); --> retorna 13
	FLOOR(x): redondea hacia abajo el argumento "x"
		ejem: select floor(12.34); --> retorna 12
	%: devuelve el resto de una division
		ejem: select 10%3; --> retorna 1
	POWER(x,y): retorna el valor de "x" elevado a la "y" potencia
		ejem: select power(2,3); --> retorna 8
	ROUND(numero,longitud): retorna un numero redondeado a la longitud especificada
		ejem1: select round(123.456,1); --> retorna "123.400", es decir, redondea desde el primer decimal
		ejem2: select round(123.456,2); --> retorna "123.460", es decir, redondea desde el segundo decimal
		ejem3: select round(123.456,-1); --> retorna "120.000", es decir, redondea desde el primer valor entero (hacia la izquierda)
	SIGN(x): si el argumento es un valor positivo devuelve 1;-1 si es negativo y si es 0, 0
		ejem: select sign(5); --> retorna 1, dado que el numero es positivo
	SQUARE(x): retorna el cuadrado del argumento
		ejem: select square(3); retorna 9
	SRQT(x): devuelve la raiz cuadrada del valor enviado como argumento
		ejem: select srqt(49);

-------------- 3. FUNCIONES PARA FECHAS Y HORAS --------------
	GETDATE(): retorna la fecha y hora actuales
		ejem: select getdate();
	DATEPART(partedefecha,fecha): retorna la parte especifica de una fecha, el anio, trimestre, dia, hora, etc
								  Los valores para "partedefecha" pueden ser: year (anio), quarter (cuarto), 
								  month (mes), day (dia), week (semana), hour (hora), minute (minuto), second (segundo) y millisecond (milisegundo)
		ejem1: select datepart(month,getdate()); --> retorna el numero de mes actual
		ejem2: select datepart(day,getdate()); --> retorna el dia actual
		ejem3: select datepart(hour,getdate()); --> retorna la hora actual
	DATENAME(partedefecha,fecha): retorna el nombre de una parte especifica de una fecha
		ejem1: select datename(month,getdate()); --> retorna el nombre del mes actual
		ejem2: select datename(day,getdate()); --> retorna el nombre del dia actual
	DATEADD(partedelafecha,numero,fecha): agrega un intervalo a la fecha especificada, es decir, retorna una fecha adicionando a la fecha enviada como tercer argumento
		ejem1: select dateadd(day,3,'1980/11/02'); --> retorna "1980/11/05", agrega 3 dias
		ejem2: select dateadd(month,3,'1980/11/02'); --> retorna "1981/02/02", agrega 3 meses
		ejem3: select dateadd(hour,2,'1980/11/02'); --> retorna "1980/02/02 2:00:00", agrega 2 horas
	DATEDIFF(partedelafecha,fecha1,fecha2): calcula el intervalo de tiempo (segun el primer argumento) entre las 2 fechas
		ejem1: select datediff (day,'2005/10/28','2006/10/28'); --> retorna 365 (dias)
		ejem2: select datediff(month,'2005/10/28','2006/11/29'); --> retorna 13 (meses)
		ejem3: select titulo, datediff(year,edicion,getdate()) from libros; --> Mostramos el titulo del libro y los anios que tienen de editados
		ejem4: select titulo from libros where datepart(day,edicion)=9 --> Muestre los titulos de los libros que se editaron el dia 9, de cualquier mes de cualquier anio
	DAY(fecha): retorna el dia de la fecha especificada
		ejem: select day(getdate()); 
	MONTH(fecha): retorna el mes de la fecha especificada. 
		ejem: select month(getdate());
	YEAR(fecha): retorna el anio de la fecha especificada. 
		ejem: select year(getdate());

-------------- 4. FUNCIONES DE AGRUPAMIENTO (COUNT - SUM - MIN - MAX - AVG - TOP) --------------
	El tipo de dato del campo determina las funciones que se pueden emplear con ellas
	COUNT(campo): se puede emplear con cualquier tipo de dato
	MIN(campo) - MAX(campo): con cualquier tipo de dato, retorna el valor maximo o minimo de un campo
	SUM(campo) y AVG(campo): solo en campos de tipo numerico, retorna la suma o el valor promedio de los valores que contiene el campo especificado
	
	TOP ->  Se emplea para obtener solo una cantidad limitada de registros, los primeros n registros de una consulta
		select top 3 titulo,autor from libros order by autor --> Consulta los titulos y autores de los 3 primeros libros, ordenados por autor

		Cuando se combina con "order by" es posible emplear tambien la clausula "with ties". 
		Esta clausula permite incluir en la seleccion, todos los registros que tengan el mismo valor del campo por el que se ordena en la ultima posicion
		select top 3 with ties * from libros order by autor --> Consulta los titulos y autores de los libros q cumplan con la misma condicion de ordenamiento

-------------- 5. FUNCIONES DE AGRUPAMIENTO AVANZADOS (GROUP BY/GROUP BY ALL - HAVING - WITH ROLLUP y CUBE - GROUPING) --------------
-- GROUP BY/GROUP BY ALL  -> Agrupa registros para consultas detalladas
		Note que las editoriales que no tienen libros que cumplan la condicion, no aparecen en la salida. 
		Para que aparezcan todos los valores de editorial, incluso los que devuelven cero o "null" en la columna de agregado, 
		debemos emplear la palabra clave "all" al lado de "group by"
		ejem1: select editorial, count(*) from libros where precio<30 group by editorial;
		ejem2: select editorial, count(*) from libros where precio<30 group by all editorial;
 
-- HAVING -> Permite seleccionar (o rechazar) un grupo de registros
		ejem1: select editorial, count(*) from libros group by editorial -> Cantidad de libros agrupados por editorial
		ejem2: select editorial, count(*) from libros group by editorial having count(*)>2 -> Cantidad de libros agrupados por editorial y que devuelvan un valor mayor a 2

		Ambas devuelven el mismo resultado, pero son diferentes
		La primera, selecciona todos los registros rechazando los de editorial "Planeta" y luego los agrupa para contarlos
			ejem3 where: select editorial, count(*) from libros where editorial<>'Planeta' group by editorial;
		La segunda, selecciona todos los registros, los agrupa para contarlos y finalmente rechaza fila con la cuenta correspondiente a la editorial "Planeta"
			ejem 4: select editorial, count(*) from libros group by editorial having editorial<>'Planeta';

-- MODIFICADOR DEL GROUP BY (WITH ROLLUP y CUBE)
	Podemos combinar "group by" con los operadores "rollup" y "cube"
	ROLLUP -> El operador "rollup" agrega filas extras mostrando resultados de resumen por cada grupo y subgrupo
		Entonces, "rollup" es un modificador para "group by" que agrega filas extras mostrando resultados de resumen de los subgrupos
		Si necesitamos la cantidad de visitantes por ciudad empleamos la siguiente sentencia:
			select ciudad,count(*) as cantidad from visitantes group by ciudad;
		Esta consulta muestra el total de visitantes agrupados por ciudad
		Pero si queremos ademas la cantidad total de visitantes, debemos realizar otra consulta:
			select count(*) as total from visitantes;
		Para obtener ambos resultados en una sola consulta podemos usar "with rollup" que nos devolvera ambas salidas en una sola consulta:
			select ciudad,count(*) as cantidad from visitantes group by ciudad with rollup;
		
		La clausula "group by" permite agregar el modificador "with rollup", el cual agrega registros extras al resultado de una consulta, que muestran operaciones de resumen
			select ciudad,sexo,count(*) as cantidad from visitantes group by ciudad,sexo with rollup;
		
		Es posible incluir varias funciones de agrupamiento, por ejemplo, queremos la cantidad de visitantes y la suma de sus compras agrupados por ciudad y sexo
			select ciudad,sexo, count(*) as cantidad, sum(montocompra) as total from visitantes group by ciudad,sexo with rollup;
	CUBE -> El operador "cube" genera filas de resumen de subgrupos para todas las combinaciones posibles de los valores de los campos por los que agrupamos
		Es decir, "cube" genera filas de resumen de subgrupos para todas las combinaciones posibles de los valores de los campos por los que agrupamos

		Ejem RollUp: select sexo,estadocivil,seccion, count(*) from empleados group by sexo,estadocivil,seccion with rollup;
			SQL Server genera varias filas extras con informacion de resumen para los siguientes subgrupos:
				- sexo y estadocivil (seccion seteado a "null")
				- sexo (estadocivil y seccion seteados a "null")
				- total (todos los campos seteados a "null").
		Ejem Cube: select sexo,estadocivil,seccion, count(*) from empleados group by sexo,estadocivil,seccion with cube;	
			Retorna mas filas extras ademas de las anteriores:
				- sexo y seccion (estadocivil seteado a "null")
				- estadocivil y seccion (sexo seteado a "null")
				- seccion (sexo y estadocivil seteados a "null")
				- estadocivil (sexo y seccion seteados a "null")
-- FUNCION GROUPING
	La funcion "grouping" se emplea con los operadores "rollup" y "cube" para distinguir los valores de detalle y de resumen en el resultado. 
	Es decir, permite diferenciar si los valores "null" que aparecen en el resultado son valores nulos de las tablas o si son una fila generada por 
	los operadores "rollup" o "cube"
	Con esta funcion aparece una nueva columna en la salida, una por cada "grouping"; 
	Retorna el valor 1 para indicar que la fila representa los valores de resumen de "rollup" o "cube" y el valor 0 para representar los valores de campo

		Si tenemos una tabla "visitantes" y contamos la cantidad agrupando por ciudad
			select ciudad, count(*) as cantidad from visitantes group by ciudad with rollup;
		La ultima fila es la de resumen generada por "rollup", pero no es posible distinguirla de la primera fila, en la cual "null" es un valor del campo. 
		Para diferenciarla empleamos "grouping
			select ciudad, count(*) as cantidad, grouping(ciudad) as resumen from visitantes group by ciudad with rollup
		
		La ultima fila contiene en la columna generada por "grouping" el valor 1, indicando que es la fila de resumen generada por "rollup"; 
		La primera fila, contiene en dicha columna el valor 0, que indica que el valor "null" es un valor del campo "ciudad"
*/

-- ORDER BY --> Podemos ordenar el resultado de un "select" para que los registros se muestren ordenados por algun campo

/*
-- ORDENADORES LOGICOS ( AND - OR - NOT)
	AND, significa "y"
		ejem: select * from libros where (autor='Borges') and (precio<=20); --> Calculamos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20
	OR, significa "y/o",
		ejem: select * from libros where autor='Borges' or editorial='Planeta'; --> Calculamos los libros cuyo autor sea "Borges" y/o cuya editorial sea "Planeta"
	NOT, significa "no", invierte el resultado
		ejem: select * from libros where not editorial='Planeta'; --> Calculamos los libros que NO cumplan la condicion, aquellos cuya editorial NO sea "Planeta"
	(), parentesis agrupa las condiciones que se quieren usar
		ejem: select * from libros where (autor='Borges') or (editorial='Paidos' and precio<20);
*/

/*
-- OPERADORES RELACIONALES (IS NULL - BETWEEN - IN)
	IS NULL --> Se emplea el operador "is null" para consultar los registros en los cuales este almacenado el valor "null"
		ejem: select * from libros where editorial is null
	BETWEEN --> Este operador se puede emplear con tipos de datos (numericos y money) y (fecha y hora)
		ejem1: select * from libros where precio between 20 and 40 --> Consultamos los libros con precio mayor o igual a 20 y menor o igual a 40
		ejem2: select *from libros where precio not between 20 and 35 --> Consultamos los libros cuyo precio NO se este entre 20 y 35, es decir, los menores a 15 y mayores a 25
	IN --> Se utiliza "in" para averiguar si el valor de un campo esta incluido en una lista de valores especificada
		ejem guia: select *from libros where autor='Borges' or autor='Paenza';
		ejem: select * from libros where autor in('Borges','Paenza')
*/

/*
-- BUSQUEDA LIKE Y NOT LIKE
	Se usa para realizar comparaciones exclusivamente de cadenas y utiliza varios comodines
		% --> El simbolo "%" (porcentaje) reemplaza cualquier cantidad de caracteres
			ejem1: select * from libros where autor like "%Borges%" --> Consulta todos los libros que contengan en autor el apellido BORGES
			ejem2: select * from libros where titulo like 'M%' --> Consulta todos los libros que comiencen con "M"
			ejem3: select titulo,precio from libros where precio like '1_.%' --> Consulta los libros cuyo precio se encuentre entre 10.00 y 19.99
		_ --> el guion bajo "_" reemplaza un caracters
			ejem: select * from libros where autor like '%Carrol_' --> Consulta los libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt"
		[] --> reemplaza cualquier caracter contenido en el conjunto especificado dentro de los corchetes
			ejem1: select titulo,editorial from libros where editorial like '[P-S]%' --> Consulta los libros cuya editorial comienza con las letras entre la "P" y la "S"
			ejem2: select titulo,editorial from libros where editoriallike '[a-cf-i]%'--> Consulta cadenas que comiencen con a,b,c,f,g,h o i;
			ejem3: select titulo,editorial from libros where editoriallike '[-acfi]%'--> Consulta cadenas que comiencen con -,a,c,f o i;
			ejem4: select titulo,editorial from libros where editoriallike 'A[_]9%'--> Consulta cadenas que comiencen con 'A_9';
			ejem5: select titulo,editorial from libros where editoriallike 'A[nm]%'--> Consulta cadenas que comiencen con 'An' o 'Am'
		[^] --> reemplaza cualquier caracter NO presente en el conjunto especificado dentro de los corchetes
			select titulo,autor,editorial from libros where editorial like '[^PN]%' --> Consulta los libros cuya editorial NO comienza con las letras "P" ni "N"
*/

-- COUNT/COUNT_BIG -> La funcion "count()" cuenta la cantidad de registros de una tabla, incluyendo los que tienen valor nulo
-- DISTINCT -> Se especifica que los registros con ciertos datos duplicados sean obviadas en el resultado

/*
-- CLAVE/LLAVE PRIMARIA COMPUESTA
	Las claves primarias pueden ser simples, formadas por un solo campo o compuestas, mas de un campo
	Existe un estacionamiento que almacena cada dia los datos de los vehiculos que ingresan en la tabla llamada "vehiculos"*/
		create table vehiculos(
			patente char(6) not null,
			tipo char(1),--'a'=auto, 'm'=moto
			horallegada datetime,
			horasalida datetime,
			primary key(patente,horallegada)
		);
		insert into vehiculos values('AIC124','a','8:05','12:30');
		insert into vehiculos values('CAA258','a','8:05',null);
		insert into vehiculos values('DSE367','m','8:30','18:00');
		insert into vehiculos values('FGT458','a','9:00',null);
		insert into vehiculos values('AIC124','a','16:00',null);
		insert into vehiculos values('LOI587','m','18:05','19:55');

/*	
	Necesitamos definir una clave primaria para una tabla con los datos descriptos arriba. 
	No podemos usar solamente la patente porque un mismo auto puede ingresar mas de una vez en el dia a la playa
	Tampoco podemos usar la hora de entrada porque varios autos pueden ingresar a una misma hora.
	
	Definimos una clave compuesta cuando ningun campo por si solo cumple con la condicion para ser clave
	En este ejemplo, un auto puede ingresar varias veces en un dia a la playa, pero siempre sera a distinta hora
	Usamos 2 campos como clave, la patente junto con la hora de llegada, asi identificamos univocamente cada registro
*/

/*------------------------------------------ INTEGRIDAD DE LOS DATOS ------------------------------------------
	Recuerde que cuando agregamos una restriccion a una tabla que contiene informacion
	SQL Server controla los datos existentes para confirmar que cumplen la condicion de la restriccion
	Si no los cumple, la restriccion no se aplica y aparece un mensaje de error.

---------------------------- 1. RESTRICCIONES (CONSTRAINTS) --------------
	Las restricciones (constraints) son un metodo para mantener la integridad de los datos, asegurando que los valores ingresados sean validos 
	y que las relaciones entre las tablas se mantenga. Se establecen a los campos y las tablas
	Pueden definirse al crear la tabla ("create table") o agregarse a una tabla existente (empleando "alter table") y se pueden aplicar a un campo o a varios
	El procedimiento almacenado del sistema "sp_helpconstraint" junto al nombre de la tabla, nos muestra informacion acerca de las restricciones de dicha tabla
	Hay varios tipos de restricciones:

-------------- 1.2. RESTRICCION CAMPO (DEFAULT) --------------
	La restriccion "default" especifica un valor por defecto para un campo cuando no se inserta explicitamente en un comando "insert"
	Anteriormente, para establecer un valor por defecto para un campo empleabamos la clausula "default" al crear la tabla:
		ejem: create table libros(...autor varchar(30) default 'Desconocido', ...);
		Dicha restriccion, a la cual no le dabamos un nombre, recibia un nombre dado por SQL Server que consiste "DF" (por default), 
		seguido del nombre de la tabla, el nombre del campo y letras y numeros aleatorios
		Podemos agregar una restriccion "default" a una tabla existente con la sintaxis basica siguiente:
			sintaxis: alter table NOMBRETABLA add constraint NOMBRECONSTRAINT default VALORPORDEFECTO for CAMPO;
			Cuando demos el nombre a las restricciones "default" formato similar al que le da SQL Server: "DF_NOMBRETABLA_NOMBRECAMPO"
		
		La restriccion "default" acepta valores tomados de funciones del sistema, por ejemplo:
		Podemos establecer que el valor por defecto de un campo de tipo datetime sea "getdate()".

		Podemos ver informacion referente a las restriciones de una tabla con el procedimiento almacenado "sp_helpcontraint":
			exec sp_helpconstraint libros;
			Aparecen varias columnas con la siguiente informacion:
				- constraint_type: el tipo de restriccion y sobre que campo esta establecida (DEFAULT on column autor)
				- constraint_name: el nombre de la restriccion (DF_libros_autor)
				- delete_action y update_action: no tienen valores para este tipo de restriccion
				- status_enabled y status_for_replication: no tienen valores para este tipo de restriccion
				- constraint_keys: el valor por defecto (Desconocido)

-------------- 1.3. RESTRICCION CAMPO (CHECK) --------------
	La restriccion "check" especifica los valores que acepta un campo, evitando que se ingresen valores inapropiados
	La sintaxis basica es la siguiente:
		sintaxis: alter table NOMBRETABLA add constraint NOMBRECONSTRAINT check CONDICION

		Trabajamos con la tabla "libros" de una libreria que tiene los siguientes campos: codigo, titulo, autor, editorial, preciomin, preciomay
		Los campos de los precios (minorista y mayorista) se definen de tipo decimal(5,2), es decir, aceptan valores entre -999.99 y 999.99. 
		Podemos controlar que no se ingresen valores negativos para dichos campos agregando una restriccion "check"
			ejem: alter table libros add constraint CK_libros_precio_positivo check (preciomin>=0 and preciomay>=0)

		La condicion puede hacer referencia a otros campos de la misma tabla. 
		Por ejemplo, podemos controlar que el precio mayorista no sea mayor al precio minorista
			ejem: alter table libros add constraint CK_libros_preciominmay check (preciomay<=preciomin)
		
		Las condiciones para restricciones "check" tambien pueden pueden incluir un patron o una lista de valores. 
		Por ejemplo establecer que cierto campo conste de 4 caracteres, 2 letras y 2 digitos
			ejem: alter table libros add constraint CK_libros_nombre check (CAMPO like '[A-Z][A-Z][0-9][0-9]');

		O establecer que cierto campo asuma solo los valores que se listan
			ejem: alter table libros add constraint CK_libros_dias check (CAMPO in ('lunes','miercoles','viernes'));

-------------- 1.4. DESAHBILITAR RESTRICCION CAMPO (WITH CHECK - NO CHECK) --------------
	La restriccion "check" a una tabla para que SQL Server acepte los valores ya almacenados que infringen la restriccion. 
	Para ello debemos incluir la opcion "with nocheck" en la instruccion "alter table"
		ejem: alter table libros with nocheck add constraint CK_libros_precio check (precio>=0);
	
		La restriccion no se aplica en los datos existentes, pero si intentamos ingresar un nuevo valor que no cumpla la restriccion, SQL Server no lo permite

	Para evitar la comprobacion de datos existentes al crear la restriccion, la sintaxis basica es la siguiente
		sintaxis: alter table TABLA with nocheck add constraint NOMBRERESTRICCION check (CONDICION);

	Tambien podemos deshabilitar las restricciones para agregar o actualizar datos sin comprobarla:
		ejem: alter table libros nocheck constraint CK_libros_precio;

	Para habilitar una restriccion deshabilitada se ejecuta la misma instruccion pero con la clausula "check" o "check all":
		ejem: alter table libros check constraint CK_libros_precio;

	Si se emplea "check constraint all" no se coloca nombre de restricciones, habilita todas las restricciones que tiene la tabla nombrada

	Para saber si una restriccion esta habilitada o no, podemos ejecutar el procedimiento almacenado "sp_helpconstraint" y fijarnos lo que informa la columna "status_enabled".

-------------- 1.5. RESTRICCION TABLA(PRIMARY KEY) --------------
	Hemos visto las restricciones que se aplican a los campos, "default" y "check".
	Ahora veremos las restricciones que se aplican a las tablas, que aseguran valores unicos para cada registro.
	-- PRIMARY KEY
		Para establecer una clave primaria para una tabla empleabamos la siguiente sintaxis al crear la tabla, por ejemplo:
			ejem: create table libros(codigo int not null, titulo varchar(30),primary key(codigo));
		
		Podemos agregar una restriccion "primary key" a una tabla existente con la sintaxis basica siguiente:
			ejem: alter table NOMBRETABLA add constraint NOMBRECONSTRAINT primary key (CAMPO);

			En el siguiente ejemplo definimos una restriccion "primary key" para nuestra tabla "libros"
				ejem: alter table libros add constraint PK_libros_codigo primary key(codigo);
		
		Por convencion, cuando demos el nombre a las restricciones "primary key" seguiremos el formato 
			sintaxis: PK_NOMBRETABLA_NOMBRECAMPO
		
-------------- 1.6. RESTRICCION TABLA(UNIQUE) --------------
	La restriccion "unique" impide la duplicacion de claves alternas (no primarias), es decir, especifica que dos registros no puedan tener el mismo valor en un campo. 
	Se permiten valores nulos. Se pueden aplicar varias restricciones de este tipo a una misma tabla, y pueden aplicarse a uno o varios campos que no sean clave primaria.

	Se emplea cuando ya se establecio una clave primaria (como un numero de legajo) pero se necesita asegurar que otros datos 
	tambien sean unicos y no se repitan (como numero de documento).

		sintaxis: alter table NOMBRETABLA add constraint NOMBRERESTRICCION unique (CAMPO);
		ejem: alter table alumnos add constraint UQ_alumnos_documento unique (documento);
		
		En el ejemplo anterior se agrega una restriccion "unique" sobre el campo "documento" de la tabla "alumnos"
		Esto asegura que no se pueda ingresar un documento si ya existe. Esta restriccion permite valores nulos

		Por convencion, cuando demos el nombre a las restricciones "unique" seguiremos la misma estructura
			sintaxis: UQ_NOMBRETABLA_NOMBRECAMPO

-------------- 1.7. INFORMACION DE RESTRICCIONES TABLA(sp_helpconstraint) --------------
	El procedimiento almacenado "sp_helpconstraint" seguido del nombre de una tabla muestra la informacion referente a todas las restricciones establecidas en dicha tabla, 
	devuelve las siguientes columnas:
		- constraint_type: tipo de restriccion. Si es una restriccion de campo (default o check) indica sobre que campo fue establecida. 
			Si es de tabla (primary key o unique) indica el tipo de indice creado.
		- constraint_name: nombre de la restriccion.
		- delete_action: solamente es aplicable para restricciones de tipo "foreign key".
		- update_action: solo es aplicable para restricciones de tipo "foreign key".
		- status_enabled: solamente es aplicable para restricciones de tipo "check" y "foreign key". 
			Indica si esta habilitada (Enabled) o no (Disabled). Indica "n/a" en cualquier restriccion para la que no se aplique.
		- status_for_replication: solamente es aplicable para restricciones de tipo "check" y "foreign key". Indica "n/a" en cualquier restriccion para la que no se aplique.
		- constraint_keys: Si es una restriccion "check" muestra la condicion de chequeo; si es una restriccion "default", el valor por defecto
			Si es una "primary key" o "unique" muestra el/ los campos a los que se aplicaron la restriccion.

-------------- 1.8. ELIMINAR RESTRICCIONES TABLA(sp_helpconstraint) --------------
	Para eliminar una restriccion, la sintaxis basica es la siguiente:
		sintaxis: alter table NOMBRETABLA drop NOMBRERESTRICCION;
	
	Para eliminar la restriccion "DF_libros_autor" de la tabla libros tipeamos:
		ejem: alter table libros drop DF_libros_autor;
	
	Pueden eliminarse varias restricciones con una sola instruccion separandolas por comas.
	Cuando eliminamos una tabla, todas las restricciones que fueron establecidas en ella, se eliminan tambien

---------------------------- 2. REGLAS (RULES) --------------
	Las reglas especifican los valores que se pueden ingresar en un campo, asegurando que los datos se encuentren en un intervalo de valores especifico
	coincidan con una lista de valores o sigan un patron, Una regla se asocia a un campo de una tabla, un campo puede tener solamente UNA regla asociado a el
		SQL Server NO controla los datos existentes para confirmar que cumplen con la regla como lo hace al aplicar restricciones
		Si no los cumple, la regla se asocia igualmente; pero al ejecutar una instruccion "insert" o "update" muestra un mensaje de error
		Actua en inserciones y actualizaciones.

	Sintaxis basica es la siguiente:
		sintaxis: create rule NOMBREREGLA as @VARIABLE CONDICION
	Por convencion, nombraremos las reglas comenzando con "RG"

	Creamos una regla para restringir los valores que se pueden ingresar en un campo "sueldo" de una tabla llamada "empleados", estableciendo un intervalo de valores:
		ejem: create rule RG_sueldo_intervalo as @sueldo between 100 and 1000
	
	Luego de crear la regla, debemos asociarla a un campo ejecutando un procedimiento almacenado del sistema empleando la siguiente sintaxis basica:
		exec sp_bindrule NOMBREREGLA, 'TABLA.CAMPO';

		Asociamos la regla creada anteriormente al campo "sueldo" de la tabla "empleados":
		ejem: exec sp_bindrule RG_sueldo_intervalo, 'empleados.sueldo'
	
	La funcion que cumple una regla es basicamente la misma que una restriccion "check", las siguientes caracteristicas explican algunas diferencias entre ellas:
		- Podemos definir varias restricciones "check" sobre un campo, un campo solamente puede tener una regla asociada a el
		- Una restriccion "check" se almacena con la tabla, cuando esta se elimina, las restricciones tambien se borran. 
			Las reglas son objetos diferentes e independientes de las tablas, si eliminamos una tabla, las reglas siguen existiendo en la base de datos
		- Una restriccion "check" puede incluir varios campos; una regla puede asociarse a distintos campos
		- Una restriccion "check" puede hacer referencia a otros campos de la misma tabla, una regla no

	Recuerde que las reglas son objetos independientes de las tablas (no se eliminan al borrar la tabla), asi que debemos eliminarlas con las siguientes intrucciones
		if object_id ('RG_documento_patron') is not null drop rule RG_documento_patron

	EJEMPLOS:
		create table empleados (
			documento varchar(8) not null,
			nombre varchar(30),
			seccion varchar(20),
			fechaingreso datetime,
			fechanacimiento datetime,
			hijos tinyint,
			sueldo decimal(6,2)
		);
			VARCHAR - Creamos una regla que establezca un patron para el documento:
				create rule RG_documento_patron as @documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';
					exec sp_bindrule RG_documento_patron, 'empleados.documento';
			VARCHAR - Creamos una regla para restringir los valores que se pueden ingresar en un campo "seccion":
				create rule RG_empleados_seccion as @seccion in ('Secretaria','Contaduria','Sistemas','Gerencia');
					exec sp_bindrule RG_empleados_seccion, 'empleados.seccion';
			DATETIME - Creamos una regla para restringir los valores que se pueden ingresar en el campo "fechaingreso", para que no sea posterior a la fecha actual:
				create rule RG_empleados_fechaingreso as @fecha <= getdate();
					exec sp_bindrule RG_empleados_fechaingreso, 'empleados.fechaingreso';
					exec sp_bindrule RG_empleados_fechaingreso, 'empleados.fechanacimiento';
			INT - Creamos una regla para restringir los valores que se pueden ingresar en el campo "hijos":
				create rule RG_hijos as @hijos between 0 and 20;
					exec sp_bindrule RG_hijos, 'empleados.hijos';
			DECIMAL - Creamos una regla para restringir los valores que se pueden ingresar en un campo "sueldo":
				create rule RG_empleados_sueldo as @sueldo>0 and @sueldo<= 5000;
					exec sp_bindrule RG_empleados_sueldo, 'empleados.sueldo';
*/







































/*------------------------------------------ PROCEDIMIENTOS ALMACENADOS ------------------------------------------
	exec sp_helpconstraint tabla -> Junto al nombre de la tabla, nos muestra informacion acerca de las restricciones de dicha tabla
	exec sp_columns tabla -> Nos muestra el detalle de la estructura de la tabla
	exec sp_tables BD -> 
	exec sp_helpconstraint tabla -> Para saber si una restriccion esta habilitada o no
	exec sp_bindrule NOMBREREGLA, 'TABLA.CAMPO' - > Luego de crear la regla, debemos asociarla a un campo ejecutando un procedimiento almacenado del sistema empleando
		exec sp_bindrule RG_sueldo_intervalo, 'empleados.sueldo'
	exec sp_help tabla -> Podemos ver todos los objetos de la base de datos activa, incluyendo las reglas
	


*/