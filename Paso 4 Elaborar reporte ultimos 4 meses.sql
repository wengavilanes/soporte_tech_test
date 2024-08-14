
-- -- PASO 4 Elaborar un reporte con clientes que mas compraron en los ultimos 4 meses.

SELECT
    c.cli_nombre AS cliente_nombre,
    c.cli_apellido AS cliente_apellido,
    SUM(cp.cpe_total) AS total_comprado
FROM
    cpedidos cp
JOIN
    cliente c ON cp.cli_id = c.cli_id
WHERE
    cp.cpe_fecha >= CURRENT_DATE - INTERVAL '4 MONTH'
GROUP BY
    c.cli_nombre,
    c.cli_apellido
ORDER BY
    total_comprado DESC;
