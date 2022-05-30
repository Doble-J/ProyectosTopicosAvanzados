# ProyectosTopicosAvanzados
Proyectos de la materia de Tópicos Avanzados

**Base de Datos para un laboratorio remoto:**

![image](https://user-images.githubusercontent.com/101353842/170783311-9375c06b-2f01-4938-b406-36935ca98f01.png)


La tabla Usuarios contiene la información sobre los distintos usuarios del sistema. Esta tabla está compuesta por:

*	**id:** número que identifica cada una de las columnas de la tabla. Es la clave primaria de la tabla. Y es auto-incremental, es decir, aumenta automáticamente.
*	**num:** al ser una aplicación para los alumnos el nombre de  usuario será el NUM. El num es un número único que identifica a cada uno de los alumnos.
*	**pass:** es la contraseña de cada uno de los usuarios. No podrá contener un valor nulo.
*	**Email:** el email del usuario. Se almacena para poder realizar notificaciones.
*	**Admin:** es un enumerado (cuyos valores son Admin o Cliente). Esta  columna  indica si el usuario es un cliente o un administrador del sistema. No podrá contener un valor nulo.

La tabla Herramientas contendrá la información sobre la herramienta del Proveedor. Parte de la información deberá ser la misma que existe en la base de datos del Proveedor.

*	**id:** número que identifica cada una de las columnas de la tabla. Es la clave  primaria de la tabla. Y es auto-incremental, es decir, aumenta automáticamente.
*	**Nombre:** es el nombre que tiene la herramienta dentro de la base de datos del Proveedor. Es única dentro de nuestro sistema y no puede contener un valor nulo.
*	**idHerramienta:** es el número identificativo de cada una de las herramientas dentro del Proveedor. Es única dentro de nuestro sistema y no puede contener un valor nulo.
*	**Tipo:** enumerado (cuyos valores son Datos o Video). Esta columna nos indicará si la herramienta es de datos o de video.

La tabla Práctica  indica la información necesaria para la ejecución de la práctica. Parte de la información deberá ser la misma que existe en la  base de datos del Proveedor.

*	**id:** número que identifica cada una de las columnas de la tabla. Es la clave  primaria de la tabla. Y es auto-incremental, es decir, aumenta automáticamente.
*	**Nombre:** nombre de la práctica. Puede contener un valor nulo.
*	**idDatos**: es la clave foránea que apunta a la tabla de herramientas. La referencia a debe ser una herramienta de datos y no puede contener un  valor nulo.
*	**idVideo:** es la clave foránea que apunta a la tabla de herramientas. La referencia a debe ser una herramienta de video y no puede contener un  valor nulo.
*	**Usuario:** columna que contiene el nombre de usuario del Proveedor que  debemos utilizar para ejecutar las herramientas. No puede contener un valor nulo.
*	**Pass:** contraseña que utiliza el Proveedor para identificar a cada uno de los usuarios. No podrá contener valores nulos.
*	**Timeout:** es el tiempo máximo de ejecución en el Proveedor. No puede contener un valor nulo.
*	**Estado:** es un enumerado (cuyos valores son Libre u Ocupado) que nos indican si la herramienta está siendo usada o no. No podrá contener un valor nulo.
*	**Ip:** contiene la ip del laboratorio desde el que se conecta la herramienta. No puede contener un valor nulo.  

La tabla Reservas contiene la información sobre las reservas que realiza un usuario sobre una práctica. A continuación comentaremos las diferentes columnas:

*	**id:** número que identifica cada una de las columnas de la tabla. Es la clave primaria de la tabla. Y es auto-incremental, es decir, aumenta automáticamente.
*	**Usuario:** clave foránea que nos india el id del usuario que ha realizado la  reserva.
*	**Id(Práctica):** clave foránea que nos indica el id de la práctica con la que se realizará la práctica reservada. No podrá contener un valor nulo.
*	**Hora:** columna que nos indica la hora a la que un usuario tiene reservada la práctica. No puede contener un valor nulo.

**Codigo para la BD:**

`create table herramienta`  
`(`    
`nombre varchar(20) not null,`  
`idherramienta smallint(8) unsigned not null auto_increment,  `  
`tipo numeric not null,   `  
`id smallint(8) unsigned not null auto_increment,  `  
`iddatos smallint(8) unsigned not null auto_increment,  `  
`idvideo smallint(8) unsigned not null auto_increment,  `  
`primary key (id, iddatos, idvideo)   `  
`);   `  

`create table usuario   `  
` (  `  
` num int not null,   `  
` pass varchar(102) not null,  `  
` email varchar(30) not null unique,   `  
` admin numeric not null,   `  
` id smallint(8) unsigned not null auto_increment,   `  
` primary key (id)   `  
` );   `  

` create table reserva   `    
` (   `  
` usuario int not null unique,   `  
` practica int not null,   `  
` hora date not null,   `  
` id smallint(8) unsigned not null auto_increment,  `  
` id smallint(8) unsigned not null auto_increment,  `  
` primary key (id), `  
` foreign key (id) references usuario(id)`  
` );   `  

`create table practica   `  
` (   `  
` id smallint(8) unsigned not null auto_increment,   `  
` nombre varchar(20) not null,   `  
` iddatos smallint(8) unsigned not null auto_increment,  `  
` idvideo smallint(8) unsigned not null auto_increment,  `  
` usuario varchar(20) not null unique,   `  
` pass varchar(102) not null,   `  
` timeout int not null,   `  
` estado not null,   `  
` ip varchar not null,   `  
` id smallint(8) unsigned not null auto_increment,  `  
` iddatos smallint(8) unsigned not null auto_increment,  `  
` idvideo smallint(8) unsigned not null auto_increment,  `  
` foreign key (id) references reserva(id),   `  
` foreign key (id, iddatos, idvideo) references herramienta(id, iddatos, idvideo)  `  
 ` );  `  
 
 **Codigo para el contenedor MySQL:**
 
`version: '3.9'`  

`services:` #nombre del servivo a levantar  

` mysqlbase:`    
 `  build:` #levanta el servicio desde mysql.dockerfile asiganado el nombre mysql_c2    
  `  context:`  
   ` dockerfile: mysql.dockerfile  `    
  ` container_name: mysql_c2  `  
   `restart: always` #reinicio siempre que se detenga el servicio    
   `ports:  `  
  `  - 23306:3306` #puertos a ocupar   
   `environment:  `   
    `MYSQL_DATABASE: 'learnlabs' ` #nombre de la BD    
    `MYSQL_ROOT_PASSWORD: 'root'`  #contraseña àra el usuario  
    `MYSQL_USER: 'usuario' `  #creacion de otro usario adicional  
    `MYSQL_PASSWORD: 'usuario' `#creacion de la contraseña para "usuario"  
    `SERVICE_TAGS: testing`  #tag de busqueda  
    `SERVICE_NAME: mysql`  
   `volumes:`  
    `- ./docker/mysql/data:/var/lib/mysql:rw` #persistencia de datos en el directorio actual en esquemas    
    `- ./database/init.sql:/docker-entrypoint-initdb.d/init.sql:ro`  
   `networks:`  #levantamiento de la host con nombre "mysql_host"  
    `mysql_network:`  
    ` aliases:`  
     ` - mysql_host`    

`volumes:` #confirmacion de la persistencia de datos    
 `  schemas: {} `  
`networks:` #confirmacion de la red  
 `  mysql_network:`  
  `   name: mysql_network`  
   `  driver: bridge `    
 
-------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------  
**Evidencia de trabajos:**

**Total de retos de CTF:**

![image](https://user-images.githubusercontent.com/101353842/170783364-3d865ded-11f3-4770-8c35-eb72d0e6882b.png)

**Levantamiento del contenedor SKF Flask:**

![image](https://user-images.githubusercontent.com/101353842/170783408-9f59a6cd-c5a1-4981-882b-42c7b1043918.png)

![image](https://user-images.githubusercontent.com/101353842/170783452-d7f9893d-b4a3-4e9c-9313-c7abd2095512.png)

Entrada al navegador:

![image](https://user-images.githubusercontent.com/101353842/170783504-69fd227a-ab4b-4a0d-90f8-b57081e373d2.png)

**Certificado de freecodecamp:**

https://www.freecodecamp.org/Doble_J

![image](https://user-images.githubusercontent.com/101353842/170783543-9b68d361-472f-428e-8ea3-d9a6e2fb852e.png)





