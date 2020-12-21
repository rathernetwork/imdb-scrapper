const cheerio = require('cheerio');

const appConstants = require('../core/appConstants');

const storeIMDBRating = ({
    itemId, itemType, voteAverage, voteCount,
}, databaseClient) => new Promise((resolve, reject) => {
    const source = 'IMDB';
    let cmdText = itemType === appConstants.ITEM_TYPE_MOVIE ? 'spSetMovieExternalValuation' : 'spSetSerieExternalValuation';
    cmdText += ` ${itemId}, '${source}', ${voteAverage}, ${voteCount}`;

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

const getIMDBRating = (html, { itemId, itemType }, databaseClient) => new Promise((resolve, reject) => {
    const $ = cheerio.load(html);

    const voteAverage = $('span[itemprop=ratingValue]').text();
    const voteCount = Number($('span[itemprop=ratingCount]').text().split(',').join(''));

    if (!voteAverage || !voteCount) {
        return resolve();
    }

    try {
        storeIMDBRating({
            itemId, itemType, voteAverage, voteCount,
        }, databaseClient)
            .then(() => resolve());
    } catch (error) {
        reject(error);
    }
});

module.exports = {
    getIMDBRating,
};
