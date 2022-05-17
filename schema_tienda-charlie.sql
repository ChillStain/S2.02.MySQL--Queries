codigo

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- 1.Lista el nombre de todos los productos que hay en la tabla.
Select nombre FROM tienda.producto;

-- 2.Lista los nombres y los precios de todos los productos de la tabla producto.
Select nombre, precio From tienda.producto;

-- 3.Lista todas las columnas de la tabla.
Select * from tienda.producto,fabricante;

-- 4.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
Select nombre, precio, precio* 1.09 From tienda.producto;

-- 5.Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dolares.
Select nombre, precio As €, precio* 1.09 As $ From tienda.producto;

-- 6.Lista los nombres y los precios de todos los productos de la tabla, convirtiendo los nombres en mayúscula.
Select ucase(nombre) , precio From tienda.producto;

-- 7.Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres en minúscula.
Select lcase(nombre) , precio From tienda.producto;

-- 8.Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
Select nombre ,ucase(left(nombre,2)) From fabricante;

-- 9.Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
Select nombre, round(precio) From tienda.producto;

-- 10.Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
Select nombre, round(left(precio,3)) From tienda.producto;

-- 11.Llista el codi dels fabricants que tenen productos en la taula producto.
Select codigo from tienda.fabricante;

-- 12.Lista el código de los fabricantes que tienen productos en la tabla producto, eliminando los códigos que aparecen repetidos.
Select distinct codigo from tienda.fabricante;

-- 13.Lista los nombres de los fabricantes ordenados de manera ascendente.
SELECT nombre FROM tienda.fabricante ORDER BY nombre ASC;

-- 14.Lista los nombres de los fabricantes ordenados de manera descendente.
SELECT nombre FROM tienda.fabricante ORDER BY nombre DESC;

-- 15.Lista los nombres de los productos ordenados en primer lugar por el nombre de manera ascendente y en segundo lugar por el precio de manera descendente.
SELECT nombre FROM tienda.producto ORDER BY nombre ASC, precio DESC;

-- 16.Devuelve una lista con las 5 primeras filas de la mesa fabricante.
SELECT * FROM tienda.fabricante LIMIT 5;

-- 17.Devuelve una lista con 2 filas a partir de la cuarta fila de la mesa fabricante. La cuarta fila también debe incluirse en la respuesta.
SELECT * FROM tienda.fabricante LIMIT 3, 2;

-- 18.Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podría usar MIN(precio), necesitaría GROUP BY
SELECT nombre, precio FROM tienda.producto ORDER BY precio ASC LIMIT 1;

-- 19.Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podría usar MAX(precio), necesitaría GROUP BY.
SELECT nombre, precio FROM tienda.producto ORDER BY precio DESC LIMIT 1;

-- 20.Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT nombre FROM tienda.producto WHERE codigo_fabricante = 2;

-- 21.Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT p.nombre, p.precio, f.nombre AS nombre_fabricante FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo;

-- 22.Devuelve una lista con el código del producto, nombre del producto, código del fabricador y nombre del fabricador, de todos los productos de la base de datos.
SELECT p.nombre, p.precio, f.nombre FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante=f.codigo ORDER BY f.nombre ASC;

-- 23.Devuelve una lista con el código del producto, nombre del producto, código del fabricador y nombre del fabricador, de todos los productos de la base de datos.
SELECT p.codigo, p.nombre, f.codigo, f.nombre FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo;

-- 24.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre, min(p.precio), f.nombre FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo;

-- 25.Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre, MAX(p.precio), f.nombre FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo;

-- 26.Devuelve una lista de todos los productos del fabricador Lenovo.
SELECT * FROM tienda.producto WHERE codigo_fabricante IN (SELECT codigo FROM tienda.fabricante WHERE nombre LIKE 'Lenovo');

-- 27.Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT * FROM tienda.producto WHERE codigo_fabricante IN (SELECT codigo FROM tienda.fabricante WHERE nombre LIKE 'Crucial') AND precio > 200;

-- 28.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Sin utilizar el operador IN.
SELECT p.* FROM tienda.producto p JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE 'Asus' or f.nombre LIKE 'Hewlett-Packard' or f.nombre LIKE 'Seagate';

-- 29.Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packardy Seagate. Utilizando el operador IN.
SELECT * FROM tienda.producto WHERE codigo_fabricante IN (SELECT codigo FROM tienda.fabricante WHERE nombre LIKE 'Asus' OR nombre LIKE 'Hewlett-Packard' OR  nombre LIKE 'Seagate');

-- 30.Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e.
SELECT p.nombre, p.precio FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre LIKE '%e';

-- 31.Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre, p.precio FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante=f.codigo AND f.nombre LIKE '%w%';

-- 32.Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT p.nombre, p.precio, f.nombre FROM tienda.producto p, tienda.fabricante f WHERE p.codigo_fabricante = f.codigo AND p.precio >= 180 ORDER BY precio DESC, p.nombre ASC;

-- 33.Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT codigo, nombre FROM tienda.fabricante WHERE codigo IN (SELECT codigo_fabricante FROM tienda.producto);

-- 34.Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también a aquellos fabricantes que no tienen productos asociados.
SELECT * FROM tienda.fabricante f LEFT JOIN tienda.producto p ON f.codigo = p.codigo_fabricante;

-- 35.Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT * FROM tienda.fabricante f LEFT JOIN tienda.producto p ON f.codigo = p.codigo_fabricante WHERE p.nombre IS NULL;
 
-- 36.Devuelve todos los productos del fabricador Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM tienda.producto WHERE codigo_fabricante IN (SELECT codigo FROM tienda.fabricante WHERE nombre = 'Lenovo');

-- 37.Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricador Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM tienda.producto WHERE precio = (SELECT MAX(precio) FROM tienda.producto WHERE codigo_fabricante = (SELECT codigo FROM tienda.fabricante WHERE nombre = 'Lenovo'));

-- 38.Lista el nombre del producto más caro del fabricador Lenovo.
SELECT p.nombre FROM tienda.producto p LEFT JOIN tienda.fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = 'Lenovo' HAVING MAX(p.precio);

-- 39.Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT * FROM tienda.producto WHERE codigo_fabricante IN (SELECT codigo FROM tienda.fabricante WHERE nombre = 'Hewlett-Packard') ORDER BY precio asc LIMIT 1;

-- 40.Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricador Lenovo.
SELECT * FROM tienda.producto LEFT JOIN tienda.fabricante 
ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= (SELECT MAX(precio) FROM tienda.producto WHERE codigo_fabricante IN (SELECT codigo FROM tienda.fabricante WHERE nombre = 'Lenovo')) AND producto.codigo_fabricante NOT IN (SELECT codigo FROM tienda.fabricante WHERE nombre = 'Lenovo');

-- 41.Lista todos los productos del fabricador Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * FROM tienda.producto p LEFT JOIN tienda.fabricante f ON p.codigo_fabricante=f.codigo WHERE f.nombre LIKE 'Asus' AND p.precio > (SELECT AVG(precio) FROM tienda.producto LEFT JOIN tienda.fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Asus');

