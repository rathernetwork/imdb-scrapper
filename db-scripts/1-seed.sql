SET IDENTITY_INSERT [dbo].[Source] ON
insert into [dbo].[Source] (SourceId, Value) values (0, 'IMDB')
insert into [dbo].[Source] (SourceId, Value) values (1, 'TMDB')
insert into [dbo].[Source] (SourceId, Value) values (2, 'ROTTEN_TOMATOES')
insert into [dbo].[Source] (SourceId, Value) values (3, 'NETFLIX')
insert into [dbo].[Source] (SourceId, Value) values (4, 'DISNEY_PLUS')
insert into [dbo].[Source] (SourceId, Value) values (5, 'ITUNES')
insert into [dbo].[Source] (SourceId, Value) values (6, 'GOOGLE')
insert into [dbo].[Source] (SourceId, Value) values (7, 'FANDANGO')
insert into [dbo].[Source] (SourceId, Value) values (8, 'AMAZON')
insert into [dbo].[Source] (SourceId, Value) values (9, 'HULU')
insert into [dbo].[Source] (SourceId, Value) values (10, 'VUDU')
SET IDENTITY_INSERT [dbo].[Source] OFF
go

SET IDENTITY_INSERT [dbo].[ItemType] ON
insert into [dbo].[ItemType] (ItemTypeId, Value) values (0, 'MOVIE')
insert into [dbo].[ItemType] (ItemTypeId, Value) values (1, 'SERIE')
insert into [dbo].[ItemType] (ItemTypeId, Value) values (2, 'CELEBRITY')
SET IDENTITY_INSERT [dbo].[ItemType] OFF
go
