-- -- PASO 3. Elaborar un reporte de pedidos de clientes, ordenado por mes y valor de pedido de manera descendente
SELECT
    c.cli_nombre AS cliente_nombre,
    c.cli_apellido AS cliente_apellido,
    EXTRACT(MONTH FROM cp.cpe_fecha) AS mes,
    SUM(cp.cpe_total) AS valor_total
FROM
    cpedidos cp
JOIN
    cliente c ON cp.cli_id = c.cli_id
GROUP BY
    c.cli_nombre,
    c.cli_apellido,
    EXTRACT(MONTH FROM cp.cpe_fecha)
ORDER BY
    mes,
    valor_total DESC;