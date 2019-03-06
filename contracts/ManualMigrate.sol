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

    mapping (address => uint256) public _balances;

    enum Stage { Active, Stopped, Migrating }
    Stage public _stage;

    MigrateContract private _newContract;

    modifier whenLive() {
        require(_stage == Stage.Active, "Function not permitted when isLive is false.");
        _;
    }

    function retireContract()
        public
        whenLive
    {
        _stage = Stage.Stopped;
    }

    function initMigrate(MigrateContract newContract)
        public
    {
        require(_stage == Stage.Stopped, "Stage must be set to Stopped before initializing migration.");
        _stage = Stage.Migrating;
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
        require(_stage == Stage.Migrating, "Stage must be set to Migrating before migrating data");
        uint256 amountToMove = _balances[account];
        delete _balances[account];
        _newContract.migrateData(account, amountToMove);
    }

}