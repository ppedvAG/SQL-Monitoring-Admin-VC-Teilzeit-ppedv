--Wir brauchen eine Sammlung aller Abfragen!!
--> Profiler 

--Wir brauchen ein Tool um die gesammelten Abfragen zu analysieren?
--> Datenbankoptimierungsratgeber


--IX müssen auch gewartet werden.. wir brauchen ein Tool
--> Wartungsplan

--Statistiken müssen korrek sein.. sprich aktuell
--Stat werden ab 20% Änderung + 500  + Abfrage erst aktualisiert!
--->Problem: Stimmt die Stat nicht, dann wird evtl ein Plan generiert der falsch ist:
	-->		Seek statt Sca und Scan statt Seek

--Wartungsplan..ab SQL 2016 ok.. vor SQL 2016 nein
	--Tipp:Ola Hallengren

select * into ku3 from ku2

select * from ku3 where id = 117 -- 1

select * from ku3 where city = 'Berlin' --6144--ca 5900

/*
Wartung von Indizes

unter 10$ nichts

ab 10% Reorg

ab 30 Rebuild


--Wartung der Indizes (vor allem Rebuild) ist sehr ressourcenintensiv)
--am besten täglich

*/





