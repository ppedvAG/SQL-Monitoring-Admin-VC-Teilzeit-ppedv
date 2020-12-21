create table t1 (id int)

--liegt per default auf Primary ...mdf
--wir können wietere Dateien anlegen.. .ndf
--per Dateigruppe

create table t2 (id int) ON HOT --= Dateigruppe

--wie kann ich eine Tabelle von einer Dgruppe auf eine andere bringen

--geht per Entwurfansicht.. aber Vorsicht.. Tabelle wird interim gelöscht

--im Prinzip kann jede Taéblle eine eig HDD haben

--es lohnt sich nicht bem Logfile.. Das Logfile wird immer nur mit eine Thread geschrieben
--macht kein Sinn mehr Logifles zu haben

alter table t2 add spx int

--wie kann man Tabellen verschieben.. auf andere Dgruppen