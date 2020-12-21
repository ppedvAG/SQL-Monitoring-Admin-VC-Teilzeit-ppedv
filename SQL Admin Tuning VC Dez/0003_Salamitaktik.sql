use northwind

create table u2020(id int identity, jahr int, spx int)--theo  Dgrupp 1

create table u2019(id int identity, jahr int, spx int)

create table u2018(id int identity, jahr int, spx int)


select * from umsatz --geht nicht mehr
--partitionieret Sicht

--Sicht--View 
create view Umsatz
as
select * from u2020
UNION ALL
select * from u2019
UNION ALL
select * from u2018

select * from umsatz --böd jede Tabelle muss man anschauen im Plan

select * from umsatz where jahr = 2020 -- immer noch alles

ALTER TABLE dbo.u2020 ADD CONSTRAINT
	CK_u2020 CHECK (jahr=2020)

	--für jede tabelle CHECK anlegen

	---Ergebnis.. Plan verwendet immer nur die einei (richtige) Tabelle


select * from umsatz where jahr = 2020 



--Warum ist das nicht so dolle?

--INS U DEL

--Ja  geht ,aber kein Identity mehr, PK muss angepasst werden
--plötlzich kommt das jahr 2021.. neue Tab, Sicht ändern, Check auf tabelle

insert into umsatz values(1,2020, 100)


insert into umsatz values(1,2019, 100)

--- partitionierte Sicht!--> archiv Tabellen .. nie geändert

--


--Partitionierung

------------100--------------------200---------------------------
--     1               2                          3

--bis100  bis200 bis5000  rest

--wir brauchen einen zahlenstrahl

create partition function  fZahl(int)
as
RANGE LEFT FOR VALUES(100,200)


select $partition.fzahl(117) ---> 2




create partition scheme schZahl
as
partition fzahl to (bis100,bis200,rest)
----    f()              1       2      3



create table ptab (id int identity, nummer int, spx char(4100)) ON schZahl(nummer)





declare @i as int = 1

while @i < 20000
	begin
		insert into ptab values (@i, 'XY')
		set @i+=1
	end


--nur die Dgruppe rest ist stark angewachsen

--hat sich das gelohnt?
--PLAN oder Statistiken

set statistics io, time on

select * from ptab where nummer = 117 --100 Seiten .. ca 0 10 ms

select * from ptab where id = 117 --19999 Seiten --30ms CPU und Dauer


----100-----200-----------------

select * from ptab where nummer = 2023



---Grenze 5000 rein


--Tabelle ptab, f(), schZahl

--schema, dann f()

alter partition scheme schZahl next used bis5000

select $partition.fzahl(nummer), min(nummer), max(nummer), count(nummer)
from ptab group by $partition.fzahl(nummer)

alter partition function fzahl() split range (5000)

select * from ptab where nummer = 2023


------?------200---------------------5000---------
--    1               2                       3

--Tab nie   f()!    

alter partition function fzahl() merge range(100)


--aktueller Stand

CREATE PARTITION FUNCTION [fZahl](int) AS RANGE LEFT FOR VALUES (200, 5000)
GO


CREATE PARTITION SCHEME [schZahl] AS PARTITION [fZahl] TO ([bis200], [bis5000], [rest])
GO




--bereich 3 möcht ich weg haben

select * from ptab where id = 3

---Daten wegarchivieren

--Befehl für verschieben von Daten: INS DEL

--nicht hier!! cooler


--Archivtabelle
create table archiv(id int not null, nummer int, spx char(4100)) on rest 

alter table ptab switch partition 3 to archiv 

select * from archiv

select * from ptab where id = 5423

select * from ptab where nummer = 7654


---


-- A bis M    N bs R   S bis Z
create partition function  fZahl(varchar(50)
as
RANGE LEFT FOR VALUES('N','S')


------------M]----------------------------------------------

M <  Maier

--jahresweise
create partition function  fZahl(datetime) ---ms--kein Wildcard.. kein F() 
as
RANGE LEFT FOR VALUES('','')


----------'31.12.2019 23:59:59.997'-------------------------------------------------
--[PRIMARY] geht.... und macht !!! Sinn
create partition scheme schZahl
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])

---15000 Bereiche machen...!