pragma solidity >=0.4.21 <0.6.0;

interface MigrateContract { 
    function migrateData(address account, uint256 amount) external;
}


/**
 *
 * CAUTION To Demonstrate Migration ONLY.
 * Functions are open to the public and not approprite for production as-is.
 *
 */

contract ManualMigrate {

    /*----------  Types  ----------*/

    enum Stage { Active, Stopped, Migrating }

    /*----------  Globals  ----------*/

    mapping (address => uint256) public _balances;
    Stage public stage;
    MigrateContract private _newContract;

    /*----------  Modifiers  ----------*/

    modifier whenLive() {
        require(
            stage == Stage.Active,
            "Function not permitted when not Status.Active."
        );
        _;
    }


    /*----------  Owner Methods  ----------*/

    function retireContract()
        public
        whenLive
        onlyOwner
    {
        stage = Stage.Stopped;
    }

    function initMigrate(MigrateContract newContract)
        public
        onlyOwner
    {
        require(
            stage == Stage.Stopped,
            "Stage must be set to Stopped before initializing migration."
        );
        stage = Stage.Migrating;
        _newContract = newContract;
    }

    function mint(address account, uint256 value)
        public
        whenLive
    {
        _balances[account] += value;
    }

    function migrateData(address account)
        public
    {
        require(
            stage == Stage.Migrating,
            "Stage must be set to Migrating before migrating data."
        );
        uint256 amountToMove = _balances[account];
        delete _balances[account];
        _newContract.migrateData(account, amountToMove);
    }

}