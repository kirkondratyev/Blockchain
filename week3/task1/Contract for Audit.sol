pragma solidity 0.4.23;

import "zeppelin-solidity/contracts/math/SafeMath.sol";

/*
TZ: contract creator becomes the first superuser. Then he adds new users and superusers. Every superuser can add new users and superusers;
If user sends ether, his balance is increased. Then he can withdraw eteher from his balance;
*/


contract VulnerableOne {
    using SafeMath for uint;

    struct UserInfo {
        uint256 created; // is this the right type of data for a time of creation?
		uint256 ether_balance;
    }

    mapping (address => UserInfo) public users_map;
	mapping (address => bool) is_super_user;
	address[] users_list;
	modifier onlySuperUser() {
        require(is_super_user[msg.sender] == true);
        _;
    }

    event UserAdded(address new_user);

    constructor() public {
		set_super_user(msg.sender);
		add_new_user(msg.sender);
	}

	function set_super_user(address _new_super_user) public { // need to use onlySuperUser modifier
		is_super_user[_new_super_user] = true;
	}

	function pay() public payable {
		require(users_map[msg.sender].created != 0);
		users_map[msg.sender].ether_balance += msg.value; // need to use safeMath here
	}

	function add_new_user(address _new_user) public onlySuperUser {
		require(users_map[_new_user].created == 0);
		users_map[_new_user] = UserInfo({ created: now, ether_balance: 0 });
		users_list.push(_new_user);
	}
	
	function remove_user(address _remove_user) public { // this was not in TZ
		require(users_map[msg.sender].created != 0);
		delete(users_map[_remove_user]);
		bool shift = false;
		for (uint i=0; i<users_list.length; i++) {
			if (users_list[i] == _remove_user) {
				shift = true;
			}
			if (shift == true) {
				users_list[i] = users_list[i+1];
			}
		}
	}

	function withdraw() public {
        msg.sender.transfer(users_map[msg.sender].ether_balance);
		users_map[msg.sender].ether_balance = 0; // this should go before prevous line to avoid re-entrancy? 
	}

	function get_user_balance(address _user) public view returns(uint256) {
		return users_map[_user].ether_balance;
	}

}