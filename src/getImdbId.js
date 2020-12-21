const request = require('request-promise-native');
const appConstants = require('../core/appConstants');

const storeImdbId = ({ itemId, itemType, imdbId }, databaseClient) => new Promise((resolve, reject) => {
    const cmdText = `spImdbIdSet ${itemId}, ${itemType}, '${imdbId}'`;

    console.log(cmdText);
    databaseClient
        .getQueryResult(cmdText)
        .then((rows) => {
            resolve(rows);
        })
        .catch((e) => {
            reject(e);
        });
});

const getImdbId = ({ itemId, itemType, tmdbId }, databaseClient) => new Promise((resolve, reject) => {
    const urlSerie = `https://api.themoviedb.org/3/tv/${tmdbId}/external_ids?api_key=${process.env.TMDB_API_KEY}&language=en-US`;
    const urlMovie = `https://api.themoviedb.org/3/movie/${tmdbId}/external_ids?api_key=${process.env.TMDB_API_KEY}&language=en-US`;
    const url = itemType === appConstants.ITEM_TYPE_MOVIE ? urlMovie : urlSerie;

    let imdbId;
    request(url, { json: true })
        .then((r) => {
            imdbId = r && r.imdb_id;
            storeImdbId({ itemId, itemType, imdbId }, databaseClient)
                .catch((e) => { console.log(e); });
            resolve(imdbId);
        })
        .catch((err) => { reject(err); });
});

module.exports = {
    getImdbId,
};
