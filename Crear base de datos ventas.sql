-- DDL Data Definition Language
CREATE DATABASE ventas;

USE ventas;

CREATE TABLE cabecera_factura (
numero VARCHAR(20) PRIMARY KEY,
fecha DATETIME NOT NULL,
codigo_cliente INT NOT NULL
);
CREATE TABLE detalle_factura(
numero_factura VARCHAR(20) NOT NULL,
codigo INT NOT NULL, 
codigo_producto INT NOT NULL,
cantidad DECIMAL (10,12) NOT NULL,
precio DECIMAL (10,2) NOT NULL,
total DECIMAL (10,2) NOT NULL
);

CREATE TABLE producto(
codigo INT NOT NULL PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio_actual DECIMAL(10,2) NOT NULL
);

CREATE TABLE cliente(
codigo INT NOT NULL PRIMARY KEY,
primer_nombre VARCHAR(100) NOT NULL,
primer_apellido VARCHAR(100) NOT NULL,
direccion VARCHAR(100) NULL,
nit VARCHAR(20) NOT NULL
);

ALTER TABLE cabecera_factura ADD CONSTRAINT fK_FACTURA_CLIENTE FOREIGN KEY(codigo_cliente) REFERENCES cliente(codigo);

ALTER TABLE detalle_factura ADD CONSTRAINT FK_DETALLE_FACTURA_PRODUCTO FOREIGN KEY(codigo_producto) REFERENCES producto(codigo);

ALTER TABLE detalle_factura ADD CONSTRAINT FK_DETALLE_ENCABEZADO_FACTURA FOREIGN KEY(numero_factura) REFERENCES cabecera_factura(numero);

ALTER TABLE detalle_factura ADD CONSTRAINT PK_DETALLE_FACTURA PRIMARY KEY(numero_factura, linea);

INSERT INTO cliente(codigo, primer_nombre, primer,apellido, direccion,)
VALUES (1, 'Juan', 'Perez', 'Jalapa', '305070-1'),
(2, 'Dany', 'Ignacio', 'Jalapa', '315070-1'),
(3, 'Diego', 'Catalan', 'Jalapa', '205070-1');

INSERT INTO producto (codigo, nombre, precio_actual)
VALUES (1, 'Xiaomi Redmi 13', 4000),
(2, 'Iphone 15', 12000),
(3, 'Alcatel', 1000);

INSERT INTO cabecera_factura (numero, fecha, codigo_cliente)
VALUES ('305070-1', NOW(), 1),
('315070-1', NOW(), 2),
('205070-1', NOW(), 3);

INSERT INTO detalle_factura (numero_factura, linea, codigo_producto, cantidad)
VALUES ('305070-1', 1, 2, 1, 12000, 12000),
('315070-1');

-- JOINS
-- SELECT usando JOINS para identificar que productos
-- se vendieron X factura
SELECT detalle_factura.numero_factura, producto.nombre
FROM detalle_factura
JOIN producto ON detalle_factura.codigo_producto = producto.codigo
WHERE detalle_factura.numero_factura = '305070-1'; 

SELECT cabecera_factura.numero, cliente.primer_nombre, cliente.primer_apellido
FROM cabecera_factura
JOIN clente ON cabecera_factura.codigo_cliente = cliente.codigo
WHERE cabecera_factura.numero = '305070-1'
