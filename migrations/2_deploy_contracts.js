var RareDogePresale = artifacts.require("RareDogePresale");
// Deploy to testnet
module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(RareDogePresale, 
    "0x336a11eed698c85b9cef50c91a83764a674f20ca", 
    "0xbb4cdb9cbd36b01bd1cbaebf2de08d9173bc095c",
    "0xbcfccbde45ce874adcb698cc183debcf17952812",
    "0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d"
    );
};