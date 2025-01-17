-- Procedimiento: registrar_venta
-- Descripción: Este procedimiento registra una nueva venta en la base de datos.
-- Parámetros de entrada:
--   - p_id_cliente INT: El ID del cliente que realiza la compra.
--   - p_id_vehiculo INT: El ID del vehículo que se vende.
--   - p_fecha_venta DATE: La fecha en la que se realiza la venta.
--   - p_precio_venta DECIMAL(10, 2): El precio de venta del vehículo.
--   - p_comision DECIMAL(10, 2): La comisión del vendedor por la venta.
--   - p_id_empleado INT: El ID del empleado que realiza la venta.

create or replace procedure registrar_venta(
    p_id_cliente INT,
    p_id_vehiculo INT,
    p_fecha_venta DATE,
    p_precio_venta DECIMAL(10, 2),
    p_comision DECIMAL(10, 2),
    p_id_empleado INT
)
language plpgsql
as $$
begin
    insert into Ventas (id_cliente, id_vehiculo, fecha_venta, precio_venta, comision, id_empleado)
    values (p_id_cliente, p_id_vehiculo, p_fecha_venta, p_precio_venta, p_comision, p_id_empleado);

    update Vehiculos
    set id_estados = (select id_estado from Estado where nombre = 'Vendido')
    where id_vehiculo = p_id_vehiculo;
end;
$$;


-- Procedimiento: actualizar_cliente
-- Descripción: Este procedimiento actualiza la información de un cliente en la base de datos.
-- Parámetros de entrada:
--   - p_id_cliente INT: El ID del cliente que se desea actualizar.
--   - p_nombre VARCHAR(100): El nuevo nombre del cliente.
--   - p_apellido VARCHAR(100): El nuevo apellido del cliente.
--   - p_documento VARCHAR(11): El nuevo documento del cliente.
--   - p_telefono VARCHAR(15): El nuevo teléfono del cliente.
--   - p_email VARCHAR(100): El nuevo email del cliente.
--   - p_direccion TEXT: La nueva dirección del cliente.

create or replace procedure actualizar_cliente(
    p_id_cliente INT,
    p_nombre VARCHAR(100),
    p_apellido VARCHAR(100),
    p_documento VARCHAR(11),
    p_telefono VARCHAR(15),
    p_email VARCHAR(100),
    p_direccion TEXT
)
language plpgsql
as $$
begin
    update Clientes
    set nombre = p_nombre,
        apellido = p_apellido,
        documento = p_documento,
        telefono = p_telefono,
        email = p_email,
        direccion = p_direccion
    where id_cliente = p_id_cliente;
end;
$$;

-- procedimiento almacenado con rollback
create or replace procedure registrar_cliente_y_venta(
    p_nombre_cliente VARCHAR(100),
    p_apellido_cliente VARCHAR(100),
    p_documento_cliente VARCHAR(11),
    p_telefono_cliente VARCHAR(15),
    p_email_cliente VARCHAR(100),
    p_direccion_cliente TEXT,
    p_id_vehiculo INT,
    p_fecha_venta DATE,
    p_precio_venta DECIMAL(10, 2),
    p_comision DECIMAL(10, 2),
    p_id_empleado INT
)
language plpgsql
as $$
declare
    v_id_cliente INT;
begin
    begin
        insert into Clientes (nombre, apellido, documento, telefono, email, direccion)
        values (p_nombre_cliente, p_apellido_cliente, p_documento_cliente, p_telefono_cliente, p_email_cliente, p_direccion_cliente)
        returning id_cliente into v_id_cliente;

        insert into Ventas (id_cliente, id_vehiculo, fecha_venta, precio_venta, comision, id_empleado)
        values (v_id_cliente, p_id_vehiculo, p_fecha_venta, p_precio_venta, p_comision, p_id_empleado);

        update Vehiculos
        set id_estados = (SELECT id_estado FROM Estado WHERE nombre = 'Vendido')
        where id_vehiculo = p_id_vehiculo;

        commit;
    exception
    	when others then
            rollback;
            raise;
    end;
end;
$$;

CALL registrar_venta(
    1,                
    1,                 
    '2025-01-17',      
    22000.00,          
    500.00,            
    1                 
);

CALL actualizar_cliente(
    1,                 
    'Juan',            
    'Pérez',          
    '12345678901',     
    '123456789',       
    'juan.perez@example.com',
    'Calle Falsa 123'  
);

CALL registrar_cliente_y_venta(
    'Carlos',          
    'González',        
    '98765432101',     
    '987654321',       
    'carlos.gonzalez@example.com', 
    'Avenida Siempreviva 742', 
    2,                
    '2025-01-17',     
    20000.00,          
    400.00,           
    2                 
);