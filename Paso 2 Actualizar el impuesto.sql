-- --PASO 2 Actualizar el impuesto a 15% de los pedidos del mes Julio y agosto, Se debe recalcular subtotal,iva y total de las cabeceras

UPDATE cpedidos
SET imp_id = (
    SELECT imp_id
    FROM impuesto
    WHERE imp_nombre = '15% VENTAS'
)
WHERE EXTRACT(MONTH FROM cpe_fecha) IN (7, 8); -- Julio y Agosto

-- -- Recalcula los totales para los pedidos de julio y agosto
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
 WHERE EXTRACT(MONTH FROM cpe_fecha) IN (7, 8); -- Julio y Agosto

-- Verifica los pedidos actualizados en julio y agosto
 SELECT cpe_id, cpe_fecha, cpe_subtotal, cpe_impuesto, cpe_total
 FROM cpedidos
 WHERE EXTRACT(MONTH FROM cpe_fecha) IN (7, 8);