CREATE DATABASE sakilaCampusdb;

USE sakilaCampusdb;

CREATE TABLE idioma(
    id_idioma INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE direccion(
    id_direccion INT AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(50),
    direccion2 VARCHAR(50),
    distrito VARCHAR(20),
    codigo_postal VARCHAR(10),
    telefono VARCHAR(20),
    id_ciudad INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);

CREATE TABLE pais(
    id_pais INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE ciudad(
    id_ciudad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    id_pais INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_pais) REFERENCES pais(id_pais)
);

CREATE TABLE almacen(
    id_almacen INT AUTO_INCREMENT PRIMARY KEY,
    id_direccion INT NOT NULL,
    id_empleado_jefe INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion)
);

CREATE TABLE empleado(
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    activo INT NOT NULL,
    username VARCHAR(16),
    password VARCHAR(40),
    id_direccion INT NOT NULL,
    id_almacen INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

-- Añadir la referencia circular después de crear la tabla empleado
ALTER TABLE almacen ADD FOREIGN KEY (id_empleado_jefe) REFERENCES empleado(id_empleado);

CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    email VARCHAR(50),
    activo INT,
    fecha_creacion DATETIME,
    id_direccion INT NOT NULL,
    id_almacen INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

CREATE TABLE pelicula(
    id_pelicula INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    anyo_lanzamiento YEAR,
    id_idioma INT NOT NULL,
    id_idioma_original INT NOT NULL,
    duracion_alquiler INT NOT NULL,
    rental_rate DECIMAL(4,2),
    duracion INT NOT NULL,
    replacement_cost DECIMAL(5,2),
    clasificacion VARCHAR(10),
    caracteristicas_especiales SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes'),
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma),
    FOREIGN KEY (id_idioma_original) REFERENCES idioma(id_idioma)
);

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(25),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE actor(
    id_actor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(45),
    apellidos VARCHAR(45),
    ultima_actualizacion TIMESTAMP
);

CREATE TABLE pelicula_actor (
    id_pelicula INT NOT NULL,
    id_actor INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_actor, id_pelicula),
    FOREIGN KEY (id_actor) REFERENCES actor(id_actor),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula)
);

CREATE TABLE pelicula_categoria (
    id_pelicula INT NOT NULL,
    id_categoria INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    PRIMARY KEY (id_pelicula, id_categoria),
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

CREATE TABLE inventario (
    id_inventario INT AUTO_INCREMENT PRIMARY KEY,
    id_pelicula INT NOT NULL,
    id_almacen INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_pelicula) REFERENCES pelicula(id_pelicula),
    FOREIGN KEY (id_almacen) REFERENCES almacen(id_almacen)
);

CREATE TABLE alquiler(
    id_alquiler INT AUTO_INCREMENT PRIMARY KEY,
    fecha_alquiler DATETIME,
    fecha_devolucion DATETIME,
    id_inventario INT NOT NULL,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_inventario) REFERENCES inventario(id_inventario),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE pago (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    total DECIMAL(5,2),
    fecha_pago DATETIME,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    id_alquiler INT NOT NULL,
    ultima_actualizacion TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_alquiler) REFERENCES alquiler(id_alquiler)
);

CREATE TABLE film_text (
    film_id INT PRIMARY KEY,
    title VARCHAR(255),
    descripcion TEXT
);
