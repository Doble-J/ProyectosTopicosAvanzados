drop database if exists learnlabs;
create database if not exists learnlabs; 

use learnlabs; 
set FOREIGN_KEY_CHECKS=0;

create table usuario 
(
id smallint(8) unsigned not null auto_increment,
username varchar(50) not null unique,
fullname varchar(50) not null,
pass char(102) not null,
university varchar(50) not null,
bachelordegree varchar(30) not null,
schoolgrade int unsigned not null,
email varchar(30) not null unique,
datebirth date not null, 
administrador enum ('admin', 'cliente') not null,  
primary key (id) 
); 

create table herramienta 
(
nombre varchar(20) not null, 
idherramienta smallint(8) unsigned not null,
tipo enum ('Datos', 'Video') not null, 
id smallint(8) unsigned not null auto_increment,
iddatos smallint(8) unsigned not null,
idvideo smallint(8) unsigned not null,
primary key (id, iddatos, idvideo) 
); 

create table reserva 
( 
usuario int not null unique, 
practica int not null, 
hora date not null, 
id_reserva smallint(8) unsigned not null auto_increment,
id smallint(8) unsigned not null,
primary key (id_reserva), 
foreign key (id) references usuario(id) 
); 

create table practica 
( 
id_practica smallint(8) unsigned not null auto_increment, 
nombre varchar(20) not null,
usuario varchar(20) not null unique, 
pass varchar(102) not null, 
timeout int (150) not null, 
estado enum ('libre','ocupado') not null, 
ip int (30) not null, 
id_reserva smallint(8) unsigned not null,
id smallint (8) unsigned not null,
iddatos smallint(8) unsigned not null,
idvideo smallint(8) unsigned not null,
primary key (id_practica),
foreign key (id_reserva) references reserva(id_reserva), 
foreign key (id, iddatos, idvideo) references herramienta(id, iddatos, idvideo)
 );
 

