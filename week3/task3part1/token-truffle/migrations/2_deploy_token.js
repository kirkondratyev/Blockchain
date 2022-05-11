'use strict';

const ExampleToken = artifacts.require('ExampleToken.sol');

module.exports = function(deployer, network) {
    deployer.deploy(ExampleToken);
};