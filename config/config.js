module.exports = {
    sqlDatabase: {
        host: process.env.ENV === 'PRODUCTION' ? process.env.DB_HOST_PROD : process.env.DB_HOST_DEV,
        database: process.env.ENV === 'PRODUCTION' ? process.env.DB_NAME_PROD : process.env.DB_NAME_DEV,
        user: process.env.ENV === 'PRODUCTION' ? process.env.DB_USER_PROD : process.env.DB_USER_DEV,
        password: process.env.ENV === 'PRODUCTION' ? process.env.DB_PASSWORD_PROD : process.env.DB_PASSWORD_DEV,
    },
};
