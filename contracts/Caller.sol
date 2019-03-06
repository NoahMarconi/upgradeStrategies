pragma solidity >=0.4.21 <0.6.0;

interface Callee { 
    function storeBytes(bytes32 key, bytes calldata value) external;
    function getBytes(bytes32 key) external returns(bytes memory);
}
// examples to test out 
// ethers.utils.id("some id")
// ethers.utils.hexlify(ethers.utils.toUtf8Bytes("a string to store"))
contract Caller {

    Callee public _callee;

    constructor(Callee callee) public {
        _callee = callee;
    }

    function storeBytes(bytes32 key, bytes memory value) public {
        _callee.storeBytes(key, value);
    }
    
    function getBytes(bytes32 key) external returns(bytes memory) {
        return _callee.getBytes(key);
    }
}