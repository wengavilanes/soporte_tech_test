

-- -- -- PASO 5 Actualizar la cantidad de unidades a 2 en todos los productos que correspondan a los pedidos 28,29,30, Se debe recalcular subtotal,iva y total de las cabeceras

-- Actualizar la cantidad de unidades a 2 en dpedidos para los pedidos 28, 29 y 30
UPDATE dpedidos
SET dpe_cantidad = 2
WHERE cpe_id IN (28, 29, 30);

-- Recalcular subtotal, impuesto y total para los pedidos 28, 29 y 30
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
cpe_total = cpe_subtotal + cpe_impuesto
WHERE cpe_id IN (28, 29, 30);

-- Verifica los pedidos 28, 29 y 30
SELECT * FROM cpedidos
WHERE cpe_id IN (28, 29, 30);


