pragma solidity >=0.4.21 <0.6.0;


/**
 *
 * CAUTION To Demonstrate Migration ONLY.
 * Functions are open to the public and not approprite for production as-is.
 *
 */
contract MigrateTarget { 

    mapping (address => uint256) public balances;
    address public _oldContract;

    constructor (address oldContract) public {
        _oldContract = oldContract;
    }

    function migrateData(address account, uint256 amount) external {
        require(msg.sender == _oldContract, "Data migration must originate from _oldContract");
        balances[account] += amount;
    }
}
