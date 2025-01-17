-- 1. Listar Vehículos Disponibles
select vehiculos.marca ,
		vehiculos.modelo,
		vehiculos.year_carro as year,
		vehiculos.precio,
		estado.nombre as estado 
from vehiculos 
join estado on vehiculos.id_estados = estado.id_estado ;

-- 2. Clientes con Compras Recientes
select clientes.nombre, 
		clientes.apellido, 
		vehiculos.marca, 
		vehiculos.modelo, 
		ventas.fecha_venta 
from Clientes 
join Ventas on clientes.id_cliente = ventas.id_cliente
join Vehiculos on ventas.id_vehiculo = vehiculos.id_vehiculo
where ventas.fecha_venta >= CURRENT_DATE - INTERVAL '30 days';

-- 3. Historial de Servicios por Vehículo
select servicios.descripcion, 
		servicios.fecha_servicio, 
		empleados.nombre, 
		empleados.apellido 
from Servicios 
join Empleados on servicios.id_empleado = empleados.id_empleado
where servicios.id_vehiculo = 1;

-- 4. Proveedores de Piezas Utilizados
select distinct proveedores.nombre
from Piezas 
join Proveedores  on piezas.id_proveedor = proveedores.id_proveedor
join Servicios s on s.id_servicio = piezas.id_pieza;

-- 5:Rendimiento del Personal de Ventas:
select empleados.nombre, 
		empleados.apellido, 
		SUM(ventas.comision) as total_comisiones
from Empleados 
join Ventas on empleados.id_empleado = ventas.id_empleado
where empleados.id_departamento = 'Ventas'
group by empleados.id_empleado;

-- 6:Servicios Realizados por un Empleado:
select servicios.descripcion, 
		servicios.fecha_servicio, 
		vehiculos.marca, 
		vehiculos.modelo
from Servicios 
join Vehiculos on servicios.id_vehiculo = vehiculos.id_vehiculo 
where servicios.id_empleado = 1;

-- 7:Clientes Potenciales y Vehículos de Interés:
select * from clientespotenciales;

-- 8:Empleados del Departamento de Servicio:
select empleados.nombre as nombre, 
		empleados.horario as horario,
		departamento.nombre as departamento
from empleados 
join departamento on empleados.id_departamento = departamento.id_departamento 
where departamento.nombre  = 'servicios';

-- 9:Vehículos Vendidos en un Rango de Precios:
select vehiculos.marca as marca,
		vehiculos.modelo as modelo,
		vehiculos.precio as precio,
		estado.nombre as estado
from vehiculos
join estado on vehiculos.id_estados = estado.id_estado 
where vehiculos.precio between 20000 and 50000;

-- 10:Clientes con Múltiples Compras:
SELECT c.nombre, 
		c.apellido, 
		COUNT(ve.id_venta) AS compras_realizadas
FROM Clientes c
JOIN Ventas ve ON c.id_cliente = ve.id_cliente
GROUP BY c.id_cliente
HAVING COUNT(ve.id_venta) > 1;

-- Consulta: Listar todos los empleados y sus roles.
select Empleados.nombre as nombre_empleado, 
       Empleados.apellido as apellido_empleado, 
       Rol.nombre as rol 
from Empleados 
join Rol on Empleados.id_rol = Rol.id_rol;

-- Consulta: Listar los vehículos usados más caros.
select v.marca, 
       v.modelo, 
       v.year_carro as year, 
       v.precio 
from Vehiculos v
join Estado e on v.id_estados = e.id_estado
where e.nombre = 'Usado'
order by v.precio desc
limit 5;

-- Consulta: Listar las ventas realizadas por un empleado específico.
select v.id_venta, 
       c.nombre as nombre_cliente, 
       c.apellido as apellido_cliente, 
       ve.marca, 
       ve.modelo, 
       v.fecha_venta 
from Ventas v
join Clientes c on v.id_cliente = c.id_cliente
join Vehiculos ve on v.id_vehiculo = ve.id_vehiculo
where v.id_empleado = 1; 

-- Consulta: Listar piezas suministradas por un proveedor específico.
select p.nombre as nombre_pieza, 
       p.precio 
from Piezas p
join Proveedores pr on p.id_proveedor = pr.id_proveedor
where pr.nombre = 'Mazda'; 

-- Consulta: Listar ventas realizadas en un rango de fechas.
select v.id_venta, 
       c.nombre as nombre_cliente, 
       c.apellido as apellido_cliente, 
       ve.marca, 
       ve.modelo, 
       v.fecha_venta 
from Ventas v
join Clientes c on v.id_cliente = c.id_cliente
join Vehiculos ve on v.id_vehiculo = ve.id_vehiculo
where v.fecha_venta between '2023-01-01' and '2025-01-15'; 

-- Consulta: Listar todos los empleados y sus respectivos departamentos.
select e.nombre as nombre_empleado, 
       e.apellido as apellido_empleado, 
       d.nombre as departamento 
from Empleados e
join Departamento d on e.id_departamento = d.id_departamento;

-- Consulta: Listar clientes que no han realizado compras.
select c.nombre, 
       c.apellido 
from Clientes c
left join Ventas v on c.id_cliente = v.id_cliente
where v.id_venta is null;

-- Consulta: Listar el historial de compras de un cliente específico.
select ve.marca, 
       ve.modelo, 
       v.fecha_venta, 
       v.precio_venta 
from Ventas v
join Vehiculos ve on v.id_vehiculo = ve.id_vehiculo
where v.id_cliente = 1;

-- Consulta: Listar servicios realizados en un rango de fechas.
select s.descripcion, 
       s.fecha_servicio, 
       e.nombre as nombre_empleado, 
       e.apellido as apellido_empleado 
from Servicios s
join Empleados e on s.id_empleado = e.id_empleado
where s.fecha_servicio between '2023-01-01' and '2025-01-15'; 

-- Consulta: Listar vehículos disponibles en un rango de precio específico.
select v.marca, 
       v.modelo, 
       v.year_carro as year, 
       v.precio 
from Vehiculos v
join Estado e on v.id_estados = e.id_estado
where e.nombre = 'Disponible' 
  and v.precio between 5.000 and 90.000;



select * from clientes;
select * from clientespotenciales;
select * from departamento;
select * from empleados;
select * from estado;
select * from piezas;
select * from proveedores;
select * from rol;
select * from servicios;
select * from vehiculos;
select * from ventas;


