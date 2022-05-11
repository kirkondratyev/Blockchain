'use strict';

import expectThrow from './helpers/expectThrow';

const ExampleToken = artifacts.require('ExampleToken.sol');

contract('ExampleToken', function(accounts) {
    
    it('test construction', async function() {
        const token = await ExampleToken.new(); 
    });

    it('test freeze', async function() {
        const token = await ExampleToken.new({from:accounts[0]});
        await token.freeze(2000000000,{from:accounts[0]});
        await expectThrow(token.transfer(accounts[1],1000,{from:accounts[0]}));
    });
});