const sql = require('mssql');

let config = null;

function getConfig() {
    return config;
}

function setConfig(newConfig) {
    let sqlPassword;

    if (typeof (newConfig.password) !== 'undefined') {
        sqlPassword = newConfig.password;
    } else if (typeof (process.env.SQL_PASSWORD) !== 'undefined') {
        sqlPassword = process.env.SQL_PASSWORD;
    } else {
        throw new Error("Couldnt't set SQL password");
    }

    config = {
        server: newConfig.host,
        database: newConfig.database,
        user: newConfig.user,
        password: sqlPassword,
        connectionTimeout: 300000,
        requestTimeout: 300000,
        pool: {
            max: 150,
            min: 0,
            idleTimeoutMillis: 30000,
        },
        options: {
            encrypt: true,
            enableArithAbort: true,
        },
    };
}

function getConnection() {
    return new Promise((resolve, reject) => {
        const pool = new sql.ConnectionPool(getConfig());

        pool.connect()
            .then((cn) => {
                resolve(cn);
            })
            .catch((e) => {
                reject(e);
            });
    });
}

function runQuery(cn, cmdText) {
    return new Promise((resolve, reject) => {
        cn.request().query(cmdText)
            .then((rows) => {
                resolve(rows.recordset);
            })
            .catch((e) => {
                reject(e);
            });
    });
}

function execute(cn, cmdText) {
    return new Promise((resolve, reject) => {
        cn.request().query(cmdText)
            .then((rows) => {
                resolve(rows.recordset);
            })
            .catch((e) => {
                reject(e);
            });
    });
}

function getQueryResult(cmdText) {
    return new Promise((resolve, reject) => {
        getConnection().then((cn) => {
            runQuery(cn, cmdText)
                .then((rows) => {
                    cn.close();
                    resolve(rows);
                })
                .catch((e) => {
                    cn.close();
                    reject(e);
                });
        })
            .catch((e) => {
                reject(e);
            });
    });
}

function runCommand(cmdText) {
    return new Promise((resolve, reject) => {
        getConnection()
            .then((cn) => {
                execute(cn, cmdText)
                    .then((rows) => {
                        cn.close();
                        resolve(rows);
                    })
                    .catch((e) => {
                        cn.close();
                        reject(e);
                    });
            })
            .catch((e) => {
                reject(e);
            });
    });
}

module.exports = (databaseConfig) => {
    setConfig(databaseConfig);

    return {
        getConnection,
        getQueryResult,
        runQuery,
        execute,
        runCommand,
    };
};
