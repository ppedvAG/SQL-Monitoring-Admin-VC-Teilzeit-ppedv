--Datenträgervolumewartungstask.. vergrößern wird nicht oer OS ausgenullt, sondern SQL macht dsa selber..

--Volumenwartungstask
--spielt eine Rolle bei Vergrößerungen von Datendateien
--Datei wird normalerweise vorher vom System "ausgenullt"--ergo doppelte Menge wid geschrieben

--Volumenwartungstask: SQL Dienstkonto bekommt Recht, die Datei selbständig zu vergrößern
--und es wird nicht mehr ausgenullt.--> Lokale Sicherheitsrichtlinie

--Pfade für DB Dateien: Idee 
-- Trenne Daten von Log pro DB

create database testdb

--besonders auf tempdb achten

/*
Verwendung für:

#t .. temp tabellen

Zeilenversionierung

IX Wartung with sort in tempdb
200MB tabelle 1 GRIX + 2 NGR  360MB --> 860 bis 1100 MB

Auslagerungsvorgänge


ab 2016 default: pro kern = Datendateien max 8
	Tracefalg 1117 und 1118 (gleichm Wachstum der Datendateien + uniform Extents)



ab 2019: ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = on;
Zugriff auf metadaten der temp tabellen schneller


*/

select * into #t from sysmessages

--MAXDOP
--regelt die Anzhal der CPUs pro Abfrage
--Abfragen können ab einem gewissen Kostenschwellwert einen oder mehrere CPUS verwenden

--bis SQL 2016 wurde folgendes eingestellt: Kostenwert 5    MAXDOP = 0  (alle CPUs)


use northwind


SELECT        Customers.CustomerID, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Customers.CompanyName, Orders.EmployeeID, Orders.OrderDate, Orders.Freight, Orders.ShipCity, 
                         Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Employees.LastName, Employees.FirstName, Employees.BirthDate, Products.ProductName, 
                         Products.UnitsInStock
INTO KU
FROM            Customers INNER JOIN
                         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                         Products ON [Order Details].ProductID = Products.ProductID




insert into ku
select * from ku
--aufhören bei 551000--> 1,1 mIo DS

set statistics io, time on

select country, city, sum(unitprice*quantity) from ku  where orderid < 10290 group by country, city
option  (maxdop 6)


--CPU Zeit in ms und ges. Dauer in ms.. Anzahl der Seiten

--, CPU-Zeit = 422 ms, verstrichene Zeit = 70 ms. ..hat sich wohl gelohnt

--mit 4 CPUs statt 8. mit weniger CPU zeit , sondern auch gleich schnell .. und 4 CPUs tun nix

--mit 1 CPU statt 8: merh als 50% CPU zeit weniger 

--Faustregel: Max 8 Kerne, evtl mit 50% testen, Kostenschwellwert: 25 SQL Dollar
--
EXEC sys.sp_configure N'cost threshold for parallelism', N'25' --bei OLTP 25, bei Datawarehouse 50
GO
EXEC sys.sp_configure N'max degree of parallelism', N'2' --max 8 , sonst anzahl der kerne
GO
RECONFIGURE WITH OVERRIDE
GO
--das der DB zählt vorrrangig
USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 8;
GO

--Entwickler können das pro Abfrage nochal anpassen:
--select * from orders option  (maxdop 2)

--Wurde die CPU Zeit reudziert und kein User klagt, dann liegst du richtig ;-)


--Arbeitsspeicher:
---per default ird das OS abgezogen

EXEC sys.sp_configure N'max server memory (MB)', N'8600'
GO
RECONFIGURE WITH OVERRIDE
GO
