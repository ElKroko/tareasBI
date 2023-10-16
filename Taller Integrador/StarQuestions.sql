SELECT 
	DimCliente.NombreCliente,
    dimcliente.idCliente,
    SUM(Tabla_Hechos.HONORARIOS) AS TotalHonorariosPorCliente
FROM Tabla_Hechos
LEFT OUTER JOIN DimCliente
ON DimCliente.idCliente = Tabla_Hechos.idCliente
GROUP BY DimCliente.NombreCliente, dimcliente.idCliente
ORDER BY TotalHonorariosPorCliente DESC;
