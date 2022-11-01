require("dotenv").config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

module.exports = {
  solidity: "0.8.10", // what version of solidity
  networks: {     // what network to deploy to
    mumbai: {     // deploy to mumbai network
      url: process.env.TESTNET_RPC,   // on the testnet
      accounts: [process.env.PRIVATE_KEY]   // private key from our wallet
    },
  },
  etherscan: {
    apiKey: process.env.POLYGONSCAN_API_KEY
  }
};
