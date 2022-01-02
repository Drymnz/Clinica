#crear la tabla de base de datos
CREATE DATABASE laboratorio_clinico;

#crear diferentes usuarios con diferentes permisos
#CREATE USER 'secretaria'@'localhost' IDENTIFIED BY 'k#D7uc1PyK';
#GRANT SELECT, INSERT, UPDATE ON laboratorio_clinico.* TO 'secretaria'@'localhost';
#CREATE USER 'laboratorista'@'localhost' IDENTIFIED BY '#HSoGnrosR';
#GRANT SELECT, INSERT, UPDATE ON laboratorio_clinico.* TO 'laboratorista'@'localhost';
#CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'fqF@6tHoXW';
#GRANT ALL PRIVILEGES ON laboratorio_clinico.detalle_orden TO 'secretaria'@'localhost';

FLUSH PRIVILEGES;

USE laboratorio_clinico;

CREATE TABLE laboratorio(
	no_laboratorio INT NOT NULL AUTO_INCREMENT,
    telefono VARCHAR(12) NOT NULL,
    nit_empresa VARCHAR(12) NOT NULL,
    fax VARCHAR(12) NOT NULL,
    direccion VARCHAR(40) NOT NULL,
    CONSTRAINT PK_LABORATORIO PRIMARY KEY(no_laboratorio)
);

CREATE TABLE cliente(
	dpi BIGINT NOT NULL,
    nit VARCHAR(10),
    nombre_cliente VARCHAR(40),
    edad INT(3) NOT NULL,
    sexo CHAR(1) NOT NULL,
    direccion VARCHAR(40),
    telefono VARCHAR(12),
    fecha_nacimiento DATE,
    CONSTRAINT PK_CLIENTE PRIMARY KEY(dpi)
);

CREATE TABLE medico(
	codigo_referido INT AUTO_INCREMENT,
    nombre_medico VARCHAR(40) NOT NULL,
    direccion VARCHAR(40),
    numero_cuenta VARCHAR(20) NOT NULL,
    telefono VARCHAR(12),
    CONSTRAINT PK_MEDICO PRIMARY KEY(codigo_referido)
);

CREATE TABLE empleado(
	no_empleado INT AUTO_INCREMENT,
    dpi BIGINT UNIQUE,
    laboratorio INT NOT NULL,
    nombre VARCHAR(40),
    contraseña VARCHAR(40),
    rango INT(2),
    no_cuenta VARCHAR(30),
    telefono VARCHAR(12),
    CONSTRAINT PK_EMPLEADO PRIMARY KEY(no_empleado),
    FOREIGN KEY(laboratorio) REFERENCES laboratorio(no_laboratorio)
);

CREATE TABLE registro(
	orden INT NOT NULL AUTO_INCREMENT,
    medico_ref INT NULL,
	secretaria INT NOT NULL,
    cliente BIGINT NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_egreso DATE NOT NULL,
    estado INT NOT NULL,
    CONSTRAINT PK_REGISTRO PRIMARY KEY(orden),
    FOREIGN KEY(cliente) REFERENCES cliente(dpi),
    FOREIGN KEY(medico_ref) REFERENCES medico(codigo_referido),
    FOREIGN KEY(secretaria) REFERENCES empleado(no_empleado)
);

CREATE TABLE laboratorista(
	colegiado SMALLINT NOT NULL,
    codigo_empleado INT NOT NULL,
    CONSTRAINT PK_LABORATORISTA PRIMARY KEY(colegiado),
    FOREIGN KEY(codigo_empleado) REFERENCES empleado(no_empleado)
);

CREATE TABLE tipo_examen(
	nombre VARCHAR(20) NOT NULL,
    laboratorista SMALLINT NOT NULL,
    CONSTRAINT PK_TIPO_EXAMEN PRIMARY KEY(nombre),
    FOREIGN KEY(laboratorista) REFERENCES laboratorista(colegiado)
);

CREATE TABLE detalle_examen(
	nombre_examen VARCHAR(30) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    precio DOUBLE NOT NULL,
    unidad VARCHAR(20),
    rango_superior VARCHAR(25),
    rango_inferior VARCHAR(25),
    CONSTRAINT PK_DETALLE_EXAMEN PRIMARY KEY(nombre_examen),
    FOREIGN KEY(tipo) REFERENCES tipo_examen(nombre)
);

CREATE TABLE detalle_orden(
	no_orden INT NOT NULL,
    examen VARCHAR (30) NOT NULL,
	resultado VARCHAR(30) NOT NULL,
    significativo VARCHAR(30) NOT NULL,
    comentario VARCHAR(30) NOT NULL,
    FOREIGN KEY(no_orden) REFERENCES registro(orden),
    FOREIGN KEY(examen) REFERENCES detalle_examen(nombre_examen)
);