const IdentityModel = artifacts.require("IdentityModel");

module.exports = function(deployer) {
  deployer.deploy(IdentityModel);
};