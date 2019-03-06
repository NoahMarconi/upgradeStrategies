pragma solidity >=0.4.21 <0.6.0;

/**
 *
 * CAUTION To Demonstrate Proxy ONLY.
 * Functions are open to the public and not approprite for production as-is.
 *
 */

// Test examples: 
// Setters
// 0xee919d500000000000000000000000000000000000000000000000000000000000000016
// 0x09cdcf9b0000000000000000000000000000000000000000000000000000000000000064
// Getters
// 0xd46300fd
// 0xa1c51915
// 
contract Proxy { 

    address _logicContract;

    function implementation() private view returns(address){
        return _logicContract;
    }    

    function setLogicContract(address logicContract) public {
        _logicContract = logicContract; 
    }

    // source: https://github.com/zeppelinos/labs/blob/master/upgradeability_using_eternal_storage/contracts/Proxy.sol
    function () external payable {
        address _impl = implementation();
        require(_impl != address(0), "Logic contract cannot be address(0)");

        assembly {
        let ptr := mload(0x40)
        calldatacopy(ptr, 0, calldatasize)
        let result := delegatecall(gas, _impl, ptr, calldatasize, 0, 0)
        let size := returndatasize
        returndatacopy(ptr, 0, size)

        switch result
        case 0 { revert(ptr, size) }
        default { return(ptr, size) }
        }
    }


}