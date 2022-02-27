pragma solidity >=0.4.22 <0.6.0;

contract LearnDataType{
    // this value will be accessable by all, and it will create a get field
    uint public val=5;
    int public val2 = -5;
    // this constant value is not update able
    string public constant name = "towhid";
    bool public mybool = true;
    
    //there are several types of uint data type
    uint8 public my8bitValue;
    uint256 public my256bitvalue;
}