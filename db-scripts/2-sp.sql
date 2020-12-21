CREATE PROCEDURE dbo.spGetItemImdbIdPaginated
	@limit int,
	@offset int
AS
    DECLARE @itemTypeMovie int
    SELECT @itemTypeMovie = ItemTypeId FROM ItemType WHERE [Value]='MOVIE'
    DECLARE @itemTypeSerie int
    SELECT @itemTypeSerie = ItemTypeId FROM ItemType WHERE [Value]='SERIE'

    SELECT
	i.ItemId,
	i.TypeId,
	CASE i.TypeId
		WHEN @itemTypeMovie THEN imi.ImdbId
		WHEN @itemTypeSerie THEN isi.ImdbId
	END AS ImdbId,
	i.ItemSourceId
	FROM dbo.Item i
	LEFT JOIN dbo.ItemMovieInfo imi ON imi.ItemId=i.ItemId
	LEFT JOIN dbo.ItemSerieInfo isi ON isi.ItemId=i.ItemId
	WHERE (i.TypeId=@itemTypeMovie OR i.TypeId=@itemTypeSerie)

	ORDER BY i.ItemId
    OFFSET @offset ROWS
	FETCH NEXT @limit ROWS ONLY
GO

CREATE PROCEDURE dbo.spImdbIdSet
	@itemId bigint,
	@typeId int,
	@imdbId varchar(255)
AS
    DECLARE @itemTypeMovie int
    SELECT @itemTypeMovie = ItemTypeId FROM ItemType WHERE [Value]='MOVIE'
    DECLARE @itemTypeSerie int
    SELECT @itemTypeSerie = ItemTypeId FROM ItemType WHERE [Value]='SERIE'


	IF @typeId = @itemTypeMovie
		BEGIN
			UPDATE ItemMovieInfo
			SET ImdbId=@imdbId
			WHERE ItemId=@itemId
		END

	ELSE IF @typeId = @itemTypeSerie
		BEGIN
			UPDATE ItemSerieInfo
			SET ImdbId=@imdbId
			WHERE ItemId=@itemId
		END
GO

CREATE PROCEDURE spCountImdbRating
AS
    DECLARE @itemTypeMovie int
    SELECT @itemTypeMovie = ItemTypeId FROM ItemType WHERE [Value]='MOVIE'
    DECLARE @itemTypeSerie int
    SELECT @itemTypeSerie = ItemTypeId FROM ItemType WHERE [Value]='SERIE'

	DECLARE @imdbId int
	SELECT @imdbId = SourceId FROM [Source] WHERE [Value]='IMDB'

	DECLARE @lastRatingItemId bigint
	SELECT @lastRatingItemId = (
		SELECT TOP(1)
		iev.ItemId
		FROM ItemExternalValuation iev
		WHERE iev.Source=@imdbId
		ORDER BY iev.ItemId DESC
	)

	SELECT
	COUNT(ItemId) AS TotalCount
	FROM Item
	WHERE (TypeId = @itemTypeMovie OR TypeId = @itemTypeSerie)
	AND (ItemId < @lastRatingItemId OR ItemId = @lastRatingItemId)

GO


