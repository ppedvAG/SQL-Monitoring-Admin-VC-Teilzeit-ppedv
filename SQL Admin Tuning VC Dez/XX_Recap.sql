/*
RAM ..Max Setting
CPU MAXDOP

HDD
part Sicht
partitionierung
kompresssion
Datentypen 
Auslastung der Seiten

--> IO reduzieren


Kompression: 
Zeilen: gut geeigent bei char, die nicht voll gefüllt werden 
Seiten: zuerst die Zeilenkompression und dann ein Kompr. Algorithmus angewendet

--> Kompression zu erwarten: 40-60%
--kostet aber : CPU

--tabelle A hatte vorher 100MB, danach 40MB.. wieviel ist nun im RAM: 40MB

..bei einer part. tabelle lassen sich auch einz part komprimieren



*/


select * into kunden from customers

select top 3 * from kunden

begin tran
update kunden set city = 'paris' where customerid = 'ALFKI'




rollback
commit