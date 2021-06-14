var DogeBooster = artifacts.require("DogeBooster");
var RareDogeCoin = artifacts.require("RareDogeCoin");
// Deploy to testnet
module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(DogeBooster, "Doge Booster", "DB").then(function() {
    return deployer.deploy(RareDogeCoin, 
      "0x1978b5B5D7A050c778390e1dDe24C50f59457147",
      "0x363c80732BA7f1797b23CfB34BaD80cD77b94701",
      "0xd07768A98344bd6545a275d9DbE70De6A605EC4c",
      DogeBooster.address
      );
  })
};