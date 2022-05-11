pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/token/StandardToken.sol";
import "zeppelin-solidity/contracts/token/DetailedERC20.sol";

contract ExampleToken is StandardToken, DetailedERC20 {

    modifier notFrozen(address owner) {
        require(m_freeze_info[owner] <= now);
        _; // this consutruction runs the rest of the function
    }

    constructor() public
        DetailedERC20("Test token", "FTK", 18)
    {
        balances[msg.sender] = 1000 ether; // ether = 10^18 mutiple
        totalSupply = balances[msg.sender];
        // emit Transfer(address(0), msg.sender, totalSupply);
    }

    function freeze(uint thawTS) public notFrozen(msg.sender) {
        m_freeze_info[msg.sender] = thawTS;
    }

    function transferFrom(address _from, address _to, uint256 _value) public notFrozen(_from) returns (bool) {
        return super.transferFrom(_from, _to, _value);
    }

    function transfer(address _to, uint256 _value) public notFrozen(msg.sender) returns (bool) {
        return super.transfer(_to, _value);
    }

    mapping (address => uint) m_freeze_info;
}