-- Función: obtener_nombre_completo_cliente
-- Descripción: Esta función devuelve el nombre completo de un cliente dado su id.
-- Parámetros:
--   - p_id_cliente INT: El ID del cliente.
-- Retorno:
--   - VARCHAR(200): El nombre completo del cliente (nombre y apellido concatenados).

create or replace function obtener_nombre_completo_cliente(p_id_cliente INT)
returns VARCHAR(200) as $$
declare
    v_nombre VARCHAR(100);
    v_apellido VARCHAR(100);
begin
    select nombre, apellido into v_nombre, v_apellido
    from Clientes
    where id_cliente = p_id_cliente;

    return v_nombre || ' ' || v_apellido;
end;
$$ language plpgsql;

-- Función: calcular_precio_total
-- Descripción: Esta función calcula el precio total de una venta después de aplicar un descuento.
-- Parámetros:
--   - p_precio_venta DECIMAL(10, 2): El precio de venta original.
--   - p_descuento DECIMAL(5, 2): El porcentaje de descuento a aplicar.
-- Retorno:
--   - DECIMAL(10, 2): El precio total después de aplicar el descuento.

create or replace function calcular_precio_total(p_precio_venta DECIMAL(10, 2), p_descuento DECIMAL(5, 2))
returns DECIMAL(10, 2) as $$
begin
    return p_precio_venta - (p_precio_venta * p_descuento / 100);
end;
$$ language plpgsql;