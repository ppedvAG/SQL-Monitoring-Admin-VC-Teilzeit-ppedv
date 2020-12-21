select * into tab1 from ptab


set statistics io , time on
select * from tab1

---Seite:

dbcc showcontig('tab1')

--- Gescannte Seiten.............................: 5000
--- Mittlere Seitendichte (voll).....................: 50.84%

--Ziel: IO senken--> Datentyoen anpassen

--varchar statt char --Anwendung  hat was dagegen
--date statt datetime
--Spalten raus in andere Tabellen rein

--Komprimieren
--- Gescannte Seiten.............................: 7
--- Mittlere Seitendichte (voll).....................: 98.21%

/*
Seitenkompression..zuerst zeilenkompresssion + Packalgorythmus
Zeilenkompression .. > gut bei char felder .. Leerräume werden entfernt


--es werden immer die Seiten 1:1 in RAM gelsen 

--vorher 5000 Seiten ... danach 7 Seiten ..auch 7 Seiten  RAM
--bezahlt wird mit CPU .. wird idR steigen

--im Prinzip wird selten die Abfrage auf komp tabellen schneller
--der Profit liegt darin, dass wir mehr RAM gewinnen für andere Daten  (Tabellen)

--normalerweise wird die KOmpression ca 40 bis 60% erreichen

select * from ptab where nummer = 3100


--Kompression lässt sich mit Partition kombinieren.. 
--evtl kann man sich die Archivierung der Partition sparen...

--nur Tabellen sind komprimierbar, nicht Datenbanken---> sonst unkalkulierbar hohe CPU Last



