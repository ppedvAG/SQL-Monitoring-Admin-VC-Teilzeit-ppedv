--SETUP


/*

MAXDOP
bis 2016 default Einstellung: jeder Abfrage nimmt ab einem Kostenschwellwert 5 alle CPUs her
--mit 1 CPU ca 200ms mit 8 CPus 515ms

ab SQL 2016.. alle CPus max 8 CPUs... evtl sind ja weniger besser... 50% 

Kostenschwellwert auf 25

auch auf DB Ebene kann der MAXDOP definiert werden


RAM
max Datenpuffer--> GESAMTRAM - OS.. das wird nur empfohlen


HDD
trenne Daten von Logs!  pro DB

tempDB
= M¸llschlucker
eig HDDs + trenne log von Daten
mdf + ldf --> 4 kernen 4 Datendateien, allerdings max 8 
-T1117 -T1118  gleichm‰ﬂges Wachsen der DAteien.. jede Tabelle bekommt eig Block (uniform extent)


*/


/*
DBDesign

--Dateigruppen ! tabellen kˆnnen gezielt pyhsikal woanders platziert  
--Aber.. create table ..on DGRUPPE.. aber wie verschieben

--mal weg von Normalisierung--> Salamitaktik


groﬂe tabelle in kleinere splitten

Sicht, die alle tabellen mit UNION ALL als ein Ergebnis ausgibt

Check







*/


