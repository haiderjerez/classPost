-- creacion DATABASE
CREATE DATABASE deluxcar;

-- conectar la base de datos 
\c deluxcar

-- cracion de tablas
CREATE TABLE Estado(
    id_estado SERIAL PRIMARY KEY,
    nombre VARCHAR(25)
);

CREATE TABLE Rol (
    id_rol SERIAL PRIMARY KEY,
    nombre VARCHAR(25)
);

CREATE TABLE Clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    documento VARCHAR(11) UNIQUE,
    telefono VARCHAR(15),
    email VARCHAR(100),
    direccion TEXT
);

CREATE TABLE Proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(100),
    telefono VARCHAR(15),
    direccion TEXT
);

CREATE TABLE Departamento(
    id_departamento SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion VARCHAR(100)
);

CREATE TABLE Vehiculos (
    id_vehiculo SERIAL PRIMARY KEY,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    year_carro INT,
    id_estados INT REFERENCES Estado(id_estado),
    precio DECIMAL(10,2)
);

CREATE TABLE Empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    documento VARCHAR(11) UNIQUE,
    id_rol INT REFERENCES Rol(id_rol),
    fecha_contratacion VARCHAR(20),
    horario VARCHAR(50),
    id_departamento INT REFERENCES Departamento(id_departamento)
);

CREATE TABLE Ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT REFERENCES Clientes(id_cliente),
    id_vehiculo INT REFERENCES Vehiculos(id_vehiculo),
    fecha_venta VARCHAR(20),
    precio_venta DECIMAL(10, 2),
    comision DECIMAL(10, 2),
    id_empleado INT REFERENCES Empleados(id_empleado)
);

CREATE TABLE Servicios (
    id_servicio SERIAL PRIMARY KEY,
    id_vehiculo INT REFERENCES Vehiculos(id_vehiculo),
    id_empleado INT REFERENCES Empleados(id_empleado),
    descripcion TEXT,
    fecha_servicio DATE,
    costo DECIMAL(10, 2)
);

CREATE TABLE Piezas (
    id_pieza SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    id_proveedor INT REFERENCES Proveedores(id_proveedor),
    precio DECIMAL(10, 2)
);

CREATE TABLE ClientesPotenciales (
    id_potencial SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(15),
    email VARCHAR(100),
    vehiculo_interes VARCHAR(100)
);

-- inserciones de las tablas 

INSERT INTO Estado(nombre)
VALUES
    ('Nuevo'),
    ('Usado');

INSERT INTO Rol(nombre)
VALUES
    ('Mecanico'),
    ('Vendedor'),
    ('Administrador'),
    ('Lavandero');

INSERT INTO Clientes(nombre, apellido, documento, telefono, email, direccion)
VALUES 
    ('haider', 'jerez', '1097783291', '3158557903', 'haiderjerez.16@gmail.com', 'casa1'),
    ('david', 'pimiento', '1715321391', '3265478914', 'david@gmail.com', 'casa1'),
    ('arley', 'mantilla', '1074516871', '3214569874', 'arley@gmail.com', 'casa1'),
    ('nicolas', 'fuentes', '1097783411', '3456789426', 'nicolascifu@gmail.com', 'casa1'),
    ('maryi', 'leal', '10912383291', '3154789642', 'maryi@gmail.com', 'casa1');

INSERT INTO Proveedores(nombre, contacto, telefono, direccion)
VALUES
    ('Mazda', 'Marcela', '365478192', 'calle mazda'),
    ('Mercedez', 'Juliana', '365478912', 'calle Mercedez'),
    ('Audi', 'pedro', '321457896', 'calle Audi'),
    ('BMW', 'Adriana', '3245617895', 'calle BMW'),
    ('Astorn Martin', 'Marcelo', '326457891', 'calle Aston Martin');

INSERT INTO Departamento(nombre, descripcion)
VALUES
    ('Servicios','encargados de servir para que la empresa funcione'),
    ('Ventas','encargados para concretar ventas'),
    ('Manteminiento','encargados para realizar los mantenimientos y arreglos de los vehiculos'),
    ('Aseo','encargados de tener la empresa aseada'),
    ('Marketing','encargados de que la enpresa llege a mas gente');

INSERT INTO Vehiculos(marca, modelo, year_carro, id_estados, precio)
VALUES 
    ('Mazda', 'Mazda2', '2022', 2, 15.000),
    ('BMW', 'M3 competition', '2024', 1, 57.000),
    ('Audi', 'R8', '2024', 1, 50.000),
    ('Astom Martin', 'MARTIN4', '2019', 2, 90.000),
    ('Mercedez', 'AMG2', '2021', 2, 20.000);

INSERT INTO Empleados(nombre, apellido, documento, id_rol, fecha_contratacion, horario, id_departamento)
VALUES 
    ('Jersson', 'Prieto', '1024578963', 1, '2022-05-15', '8AM-8PM', 1),
    ('Dylan', 'Do Santos', '1034578962', 1, '2022-05-15', '8AM-8PM', 2),
    ('Uther', 'Ragnarok', '1024576893', 3, '2023-04-24', '7AM-7PM', 1),
    ('Isabel', 'Valderrama', '1032547682', 2, '2023-10-21', '7AM-4PM', 1),
    ('Alejandra', 'Sarmiento', '1024563879', 2, '2024-11-05', '7AM-4PM', 3),
    ('Cristian', 'Barba', '1024537414', 4, '2024-12-04', '8AM-8PM', 4);


INSERT INTO Ventas(id_cliente, id_vehiculo, fecha_venta, precio_venta, comision, id_empleado)
VALUES
    (1, 2, '2025-05-13', 60000.00, 5.0, 1),
    (2, 1, '2025-01-13', 17000.00, 5.0, 2),
    (3, 3, '2025-06-13', 60000.00, 5.0, 1),
    (4, 5, '2025-04-13', 25000.00, 5.0, 2);

INSERT INTO Servicios (id_vehiculo, id_empleado, descripcion, fecha_servicio, costo) 
VALUES 
(1, 2, 'Cambio de aceite', '2023-07-10', 50.00),
(2, 2, 'Revisión general', '2023-08-05', 100.00);

INSERT INTO Piezas (nombre, id_proveedor, precio) 
VALUES 
('Filtro de aceite', 1, 10.00),
('Bujía', 2, 5.00);

INSERT INTO ClientesPotenciales (nombre, apellido, telefono, email, vehiculo_interes) 
VALUES 
('Pedro', 'Ramirez', '33334444555', 'pedro.ramirez@gmail.com', 'Toyota Corolla'),
('Lucia', 'Fernandez', '44445555666', 'lucia.fernandez@gmail.com', 'Honda Civic');

