pragma solidity >=0.4.21 <0.6.0;


/**
 *
 * CAUTION To Demonstrate Logic ONLY.
 * Functions are open to the public and not approprite for production as-is.
 *
 */
contract Logic { 

    address _logicContract;

    uint256 a;
    uint256 b;

    event LogA(uint256 _a);

    function setA(uint256 val) public {
        a = val;
    }

    function setB(uint256 val) public {
        b = val;
    } 

    function getA() public returns(uint256) {
        emit LogA(a);
        return a;
    }

    function getB() public view returns(uint256) {
        return b;
    }
}
