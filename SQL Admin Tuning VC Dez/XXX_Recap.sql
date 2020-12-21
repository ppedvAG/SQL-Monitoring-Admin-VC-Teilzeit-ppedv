--CL IX und NON CL bei rel wenigen Ergebniszeilen.. ca 1000mal 
--CL IX = TABELLE --> Bereichsabfragen

select * from customers

insert into customers (CustomerID, CompanyName) values ('ppedv', 'AG PPEDV')
--ID (PK) = CL IX.. diese Idee ist gar nicht so optimal

-- A B C
--A
--B C A AB ABC ACB  B BA BAC BCA C CAB CBA CB CA -- 1000--> 1000 U I D
--überflüssig: BA CA CB AC AB  A B C
--Mittel um überflüssige herauszufinden: sys.dm_db_index_usage_stats . 
--TU NIE Server mal neustarten.. systemtab werden geleert

