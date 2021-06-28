require('dotenv').config();

module.exports = {
    // username: process.env.DB_USERNAME,
    // password: process.env.DB_PASSWORD,
    // database: process.env.DB_NAME,
    // host: process.env.DB_HOST,
    // dialect: process.env.DB_DIALECT || 'postgres',
    // define: {
    //     timestamps: true,
    //     underscored: true,
    //     underscoredAll: true,
    // }
    username: 'ezsmotomzrgqnw',
    password: '46c1b6ef0569d4c107c4831a2004379416537b5148be5cb48c97feb6790bc21a',
    database: 'd8m8rdeggo2ubm',
    host: 'ec2-79-125-30-28.eu-west-1.compute.amazonaws.com',
    dialect: process.env.DB_DIALECT || 'postgres',
    define: {
        timestamps: true,
        underscored: true,
        underscoredAll: true,
    }
};