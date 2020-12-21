const request = require('request-promise-native');

const { getIMDBRating } = require('./imdbRating');
const { getNextItem } = require('./getFromDB');
const { getImdbId } = require('./getImdbId');
const appConstants = require('../core/appConstants');

const addImdbRating = async (limit, offset, databaseClient) => {
    // First gets a batch of items from the db
    let batchOfItems = [];
    try {
        batchOfItems = await getNextItem(databaseClient, limit, offset);
    } catch (error) {
        console.log(error);
        addImdbRating(limit, offset, databaseClient);
        return;
    }

    if (batchOfItems.length === 0) {
        console.log('No items left');
        return;
    }

    const itemsPromises = [];
    batchOfItems.forEach(async (item) => {
        const data = {
            itemId: item.ItemId,
            imdbId: item.ImdbId,
            itemType: item.TypeId,
            tmdbId: item.ItemSourceId,
        };

        if (!data.imdbId) {
            if (data.TypeId === appConstants.ITEM_TYPE_SERIE) {
                console.log(`Fetching imdb id for itemId ${data.itemId}`);
                data.imdbId = await getImdbId(data, databaseClient);
            } else {
                console.log('Movie IMDB does not exist');
            }
        }
        if (data.imdbId) {
            itemsPromises.push(
                request(`https://www.imdb.com/title/${data.imdbId}/`)
                    .then((r) => {
                        getIMDBRating(r, data, databaseClient);
                    })
                    .catch((err) => { console.log(err); }),
            );
        }
    });

    await Promise.allSettled(itemsPromises);

    addImdbRating(limit, offset + limit, databaseClient);
};

module.exports = {
    addImdbRating,
};
