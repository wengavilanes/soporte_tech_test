-- PASO 1. Actualizar totales de la cabecera de pedidos: cpe_subtotal cpe_impuesto cpe_total
UPDATE cpedidos
SET cpe_subtotal = (
    SELECT COALESCE(SUM(dp.dpe_precio * dp.dpe_cantidad), 0)
    FROM dpedidos dp
    WHERE dp.cpe_id = cpedidos.cpe_id
),
cpe_impuesto = (
    SELECT COALESCE(SUM(dp.dpe_precio * dp.dpe_cantidad), 0) * 
           (SELECT imp.imp_porcentaje::NUMERIC / 100
            FROM impuesto imp
            WHERE imp.imp_id = cpedidos.imp_id)
    FROM dpedidos dp
    WHERE dp.cpe_id = cpedidos.cpe_id
),
cpe_total = cpe_subtotal + cpe_impuesto;
