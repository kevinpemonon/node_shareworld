const { Sequelize, QueryTypes } = require("sequelize");

// const mySequelize = new Sequelize("shareworld", "postgres", "pempem", {
//   host: "localhost",
//   dialect: "postgres",
// });

const mySequelize = new Sequelize(
  process.env.DB_NAME,
  process.env.DB_USERNAME,
  process.env.DB_PASSWORD,
  {
    host: process.env.DB_HOST,
    dialect: "postgres",
    protocol: "postgres",
    dialectOptions: {
      ssl: {
        require: true,
        rejectUnauthorized: false,
      },
    },
  }
);

module.exports = {
  async getOwnerAddressId(userId) {
    const result = mySequelize.query(
      "SELECT address_id FROM users WHERE id = $id",
      {
        bind: {
          id: userId,
        },
        type: QueryTypes.SELECT,
      }
    );
    return result;
  },
};
