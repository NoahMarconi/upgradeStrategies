pragma solidity >=0.4.21 <0.6.0;


contract Callee { 

    mapping (bytes32 => bytes) public _bytesStore;

    address public _caller;

    function setCaller(address caller) public {
        _caller = caller;
    }

    modifier onlyCaller() {
        require(msg.sender == _caller, "Only _caller can access this method");
        _;
    }

    function storeBytes(bytes32 key, bytes calldata value)
        external
        onlyCaller
    {
        _bytesStore[key] = value;
    }
    
    function getBytes(bytes32 key)
        external
        view
        onlyCaller
        returns(bytes memory)
    {
        return _bytesStore[key];
    }
}