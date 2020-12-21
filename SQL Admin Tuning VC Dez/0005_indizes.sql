/*


Indizes haben so gut wie berall ihre finger  drin

--Sperren..Performance Beschleunigung oder auch Bremse
--Arbeitsspeicherauslastung, Datenträgerzugriffe


im Prinzip gibt es zwei Indizes
Nicht grupp. IX  --NON CLUSTERD zusätzliche Menge best Spalten in sortierter Form
--> telefonbuch 


Grupp. IX          CLUSTERED  = Tabelle in sortierter Form



und Columnstore Indizes;-)

eindeutigen IX.. jeder Wert in den IX Schlüsselspalten darf nur einmal vorkommen

zusammengesetzt alle Sp des IX sind im komplette Baum verteten

IX mit eingeschl.. die zusätzlich Spalten sind nur in der unteresten Ebene des Baumes

gefilterter IX ..nicht mehr alle Daten


part. Index vermutich erst ab VLDB verdm großen DBs.. mit zig Millionen
ähnelt dem gefilterten Index


N GR IX kopiert Daten aus den Datenseiten in eine sortierte Form
und baut einen sog B Baum auf.. 
die Suche beginnt beim Wurzelknoten




--Ziel des Admin.. das gesamte muss optimiert werden.. --> IX Strategie
überflüssige Indizes fehlende Indizes müssene gefunden werden--> Scripte und Tools


*/
use northwind
GO

select * into ku2 from ku

alter table ku2 add id int identity

--ein HEAP
set statistics io, time on

select id from ku2 where id = 100--Scan 56000.. 250ms CPU

--NIX_ID: 0ms 3 Seiten... IX Seek .. perfekt



select id, freight from ku2 where id = 100 --IX SEEK  3 + Lookup +1... 0ms

select id, freight from ku2 where id < 100 --IX mit Lookup +99
		---..ab ca 12000 wird bereits ein SCAN gemacht wg Lookup

--Idee Infos ins telBuch
--NIX_ID_FR.. zusammengesetzt eindeutiger IX.. 3 Seiten statt 102..!



--EIN PAAR WORTE ZU CL INDEX
--Achtung: PK ist immer per default ein CL IX...
--CL IX ist besonders für Bereichsabfragen geeignet
--der NCL dagegen für rel gerinege Ergebnismenge

--beim Anlegen CL gleich festlegen
--bei best. tabellen evtl CL IX des PK in einen NCL umwandeln


select id, freight from ku2 where id < 100

--SL kann IX vorhschlagen, ausser das Statetment ist zu komplex
--zB ab OR ist der SQL draussen
select country, city, sum(unitprice*quantity) from ku2	
	where productid in(1,3,5) AND UnitsInStock < 10
	group by country, city

--> 2 Indizes



CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [dbo].[ku2] ([ProductID],[UnitsInStock])
INCLUDE ([City],[Country],[UnitPrice],[Quantity])


--Wie finde ich heraus, ob Indizes gut verwendet wurnde


select * from sys.dm_db_index_usage_stats

--index_id : 0 = HEAP   1=CL IX  > 1= NCL IX

--> Im projekt: Überflüssige und Fehlende Indizes
--0005_Überflüssige Indizes
--0005_Fehlende Indizes