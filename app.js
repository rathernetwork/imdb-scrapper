require('dotenv').config();

const config = require('./config/config');
const databaseClient = require('./lib/SQLClient')(config.sqlDatabase);

const { getLastIndex } = require('./src/getFromDB');
const { addImdbRating } = require('./src/addImdbRating');

const getDatabaseClient = () => databaseClient;

const main = async () => {
    const isFromBeginning = !!process.argv[2];
    const batchSize = 10;
    console.time('Getting last index from db');
    const offset = isFromBeginning ? 0 : await getLastIndex(getDatabaseClient());
    console.timeEnd('Getting last index from db');

    return new Promise((resolve, reject) => {
        addImdbRating(batchSize, offset, getDatabaseClient())
            .then(() => resolve())
            .catch((err) => reject(err));
    });
};

main()
    .catch((err) => { console.log(err); });
