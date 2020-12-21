CREATE TABLE [dbo].[Source]
(
	[SourceId] [int] IDENTITY(0,1) NOT NULL,
	[Value] [varchar](255) NOT NULL,
 CONSTRAINT [PKSource_SourceId] PRIMARY KEY CLUSTERED
(
	[SourceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[ItemType]
(
	[ItemTypeId] [int] IDENTITY(0,1) NOT NULL,
	[Value] [varchar](255) NOT NULL,
 CONSTRAINT [PKItemType_ItemTypeId] PRIMARY KEY CLUSTERED
(
	[ItemTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Language]
(
	[LanguageId] [int] IDENTITY(0,1) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PKLanguage_LanguageId] PRIMARY KEY CLUSTERED
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE TABLE [dbo].[Item]
(
	[ItemId] [bigint] IDENTITY(0,1) NOT NULL,
	[TypeId] [int] foreign key references ItemType(ItemTypeId) NOT NULL,
	[SourceId] [int] foreign key references Source(SourceId) NOT NULL,
	[ItemSourceId] [bigint] NOT NULL,
	[BelongsToItemId] [bigint] foreign key references Item(ItemId) default null
 CONSTRAINT [PKItem_ItemId] PRIMARY KEY CLUSTERED
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[ItemMovieInfo]
(
	[ItemId] [bigint] foreign key references Item(ItemId) NOT NULL,
	[ReleaseDate] datetime default null,
    [Revenue] bigint default null,
    [Budget] bigint default null,
    [Homepage] varchar(255) default null,
    [OriginalLanguage] varchar(5),
    [OriginalTitle] nvarchar(255) default null,
    [Runtime] int default null,
	[IsAdult] bit not null,
	[ImdbId] varchar(255)
 CONSTRAINT [PKItemMovieInfo_ItemId] PRIMARY KEY CLUSTERED
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- CREATE TABLE [dbo].[ItemSerieInfo]
-- (
-- 	[ItemId] [bigint] foreign key references Item(ItemId) NOT NULL,
-- 	[FirstAirDate] datetime default null,
-- 	[LastAirDate] datetime default null,
-- 	[NumberOfEpisodes] int default null,
-- 	[NumberOfSeasons] int default null,
--     -- [Revenue] bigint default null,
--     -- [Budget] bigint default null,
--     [Homepage] varchar(255) default null,
--     [OriginalLanguage] varchar(5),
--     [OriginalTitle] nvarchar(255) default null,
--     [EpisodeRuntime] int default null,
-- 	-- [IsAdult] bit not null,
-- 	-- [ImdbId] varchar(255)
--  CONSTRAINT [PKItemSerieInfo_ItemId] PRIMARY KEY CLUSTERED
-- (
-- 	[ItemId] ASC
-- )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
-- ) ON [PRIMARY]
-- GO

CREATE TABLE [dbo].[ItemExternalValuation]
(
	[ItemExternalValuationId] [bigint] IDENTITY(0,1) NOT NULL,
	[ItemId] [bigint] foreign key references Item(ItemId) NOT NULL,
	[Source] [int] foreign key references Source(SourceId) NOT NULL,
	[VoteAverage] decimal(4,2) default NULL,
	[VoteCount] int NOT NULL,
	[UpdatedAt] datetime not null,
 CONSTRAINT [PKItemExternalValuation_ItemExternalValuationId] PRIMARY KEY CLUSTERED
(
	[ItemExternalValuationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
