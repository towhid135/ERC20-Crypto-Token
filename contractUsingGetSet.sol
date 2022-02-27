// Solidity program to  
// demonstrate how to 
// write a smart contract  

//the version greater that 0.4.24 we are going to use
pragma solidity ^0.4.24;
    
// Defining a contract 
contract Test
{ 
    string value;
    constructor() public{
        value = "my value1";
    }
    function get() public view returns(string) {
        return value;
    }
    function set(string _value) public {
        value = _value;
    }
    
}