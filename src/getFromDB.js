const getNextItem = (databaseClient, limit, offset) => new Promise((resolve, reject) => {
    const cmdText = `spGetItemImdbIdPaginated ${limit}, ${offset}`;

    databaseClient
        .getQueryResult(cmdText)
        .then((rows) => {
            resolve(rows);
        })
        .catch((e) => {
            reject(e);
        });
});

const getLastIndex = (databaseClient) => new Promise((resolve, reject) => {
    const cmdText = 'spCountImdbRating';

    databaseClient
        .getQueryResult(cmdText)
        .then((rows) => {
            resolve(rows[0].TotalCount);
        })
        .catch((e) => {
            reject(e);
        });
});

module.exports = {
    getNextItem,
    getLastIndex,
};
