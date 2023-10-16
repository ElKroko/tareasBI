SELECT * FROM tallerdb;

DROP TABLE IF EXISTS DimAduana;
CREATE TABLE DimAduana (
	idAduana INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Region VARCHAR(45)
    );
    
INSERT INTO DimAduana(Region)
SELECT DISTINCT ADUANA FROM tallerdb;

DROP TABLE IF EXISTS DimEjecutivo;
CREATE TABLE DimEjecutivo (
	idEjecutivo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	NombreEjecutivo VARCHAR(45)
    );
    
INSERT INTO DimEjecutivo(NombreEjecutivo)
SELECT DISTINCT EJECUTIVO FROM tallerdb;

DROP TABLE IF EXISTS DimTiempo;
CREATE TABLE DimTiempo (
	idTiempo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Mes VARCHAR(45),
    Fecha DATE
    );
    
INSERT INTO DimTiempo(Mes, Fecha)
SELECT DISTINCT MES, `FECHA VENTA` FROM tallerdb;

DROP TABLE IF EXISTS DimDespacho;
CREATE TABLE DimDespacho (
	idDespacho INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Despacho INT
    );
    
INSERT INTO DimDespacho(Despacho)
SELECT DISTINCT DESPACHO FROM tallerdb;

DROP TABLE IF EXISTS DimDeclaracion;
CREATE TABLE DimDeclaracion (
	idDeclaracion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	TipoDeclaracion VARCHAR(45)
    );
    
INSERT INTO DimDeclaracion(TipoDeclaracion)
SELECT DISTINCT DECLARACION FROM tallerdb;

DROP TABLE IF EXISTS DimCliente;
CREATE TABLE DimCliente (
	idCliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	NombreCliente VARCHAR(90),
    RUT VARCHAR(45)
    );

INSERT INTO DimCliente(NombreCliente,RUT)
SELECT DISTINCT NOMBRE, `RUT CLIENTE` FROM tallerdb;

DROP TABLE IF EXISTS Tabla_Hechos;
CREATE TABLE Tabla_Hechos (
	idAduana INT,
    idEjecutivo INT,
    idTiempo INT,
    idDespacho INT,
    idDeclaracion INT, 
    idCliente INT,
    `GASTO POR VENTA` INT,
    HONORARIOS INT, 
    `NUMERO FACTURA` INT
);

INSERT INTO Tabla_Hechos (idAduana,idEjecutivo, idTiempo, idDespacho, idDeclaracion, idCliente, `GASTO POR VENTA`, HONORARIOS, `NUMERO FACTURA`)
SELECT idAduana,idEjecutivo, idTiempo, idDespacho, idDeclaracion, idCliente , `GASTO POR VENTA`, HONORARIOS, `NUMERO FACTURA` FROM tallerdb
LEFT OUTER JOIN DimAduana
	ON DimAduana.Region = tallerdb.ADUANA
LEFT OUTER JOIN DimEjecutivo
	ON DimEjecutivo.NombreEjecutivo = tallerdb.EJECUTIVO
LEFT OUTER JOIN DimTiempo
	ON DimTiempo.Mes = tallerdb.MES
    AND DimTiempo.Fecha = tallerdb.`FECHA VENTA`
LEFT OUTER JOIN DimDespacho
	ON DimDespacho.Despacho = tallerdb.DESPACHO
LEFT OUTER JOIN DimDeclaracion
	ON DimDeclaracion.TipoDeclaracion = tallerdb.DECLARACION
LEFT OUTER JOIN DimCliente
	ON DimCliente.NombreCliente = tallerdb.NOMBRE
    AND DimCliente.RUT = tallerdb.`RUT CLIENTE`;

SELECT * FROM Tabla_Hechos;
    
