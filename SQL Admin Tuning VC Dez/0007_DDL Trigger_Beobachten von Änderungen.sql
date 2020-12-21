create table loggs (id int identity, shithappens xml, Datum datetime)

create trigger trgGuether on database for ddl_database_level_events
as
insert into loggs values (eventdata(), getdate())


USE [Northwind]

GO

CREATE NONCLUSTERED INDEX [NonClusteredIndex-20201218-171031] ON [dbo].[archiv]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)

GO


select * from loggs