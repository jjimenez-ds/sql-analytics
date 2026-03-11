-- Ejercicio 1: Crear una vista que muestre el Titulo, Tipo, Precio y Fecha de actualización
-- de la tabla Titles
USE pubs
GO

IF EXISTS 
(
  SELECT name
  FROM sys.views
  WHERE name='titles_view'
)
DROP VIEW titles_view
GO

CREATE VIEW titles_view
AS
SELECT title, type, price, pubdate
FROM titles
GO

SELECT * FROM titles_view

-- Ejercicio 2: Crear una vista que muestre el Titulo, Tipo, Precio y Fecha de actualización
-- de la tabla Titles -- [RENOMBRAR & FORMATO PERU FECHA_ACTUALIZACION]
IF EXISTS 
(
  SELECT name
  FROM sys.views
  WHERE name='titles_view'
)
DROP VIEW titles_view
GO

CREATE VIEW titles_view
(
  T�tulo, Tipo, Precio, [Fecha de actualizaci�n]
)
AS
SELECT title, type, price, CONVERT(CHAR(10),pubdate,103) as pubdate
FROM titles
GO

SELECT * FROM titles_view

-- NOTA: Al crear Vistas, el ORDER BY no funciona
-- TRUCO: Colocar SELECT TOP 99.999999 PERCENT

-- Ejercicio 3: Crear una vista que muestre la categor�a y el promedio de precios
-- de la tabla Titles
USE pubs
GO

IF EXISTS
(
SELECT name 
FROM sys.views
WHERE name='categories'
)
DROP VIEW categories
GO

CREATE VIEW categories (category, average_price)
AS
SELECT type, AVG(price)
FROM titles
GROUP BY type
GO

SELECT * FROM categories

-- Ejercicio 4: Crear una vista que muestre un reporte del producto m�s vendido
-- por cada categor�a
USE Northwind
GO

IF EXISTS
(
SELECT name 
FROM sys.views
WHERE name='v_VentasCategoriaProducto'
)
DROP VIEW v_VentasCategoriaProducto
GO

CREATE VIEW v_VentasCategoriaProducto
AS
SELECT C.CategoryName,P.ProductName,
SUM(OD.quantity* OD.unitPrice*(1-OD.Discount)) AS Monto
FROM Categories AS C
INNER JOIN Products AS P ON C.CategoryID=P.CategoryID
INNER JOIN [Order Details] AS OD ON P.ProductID=OD.ProductID
GROUP BY C.CategoryNAme,P.ProductName
GO

SELECT * FROM v_VentasCategoriaProducto

-- Ejercicio 5: Crear una vista que muestre un reporte del producto m�s vendido
-- por cada categor�a


