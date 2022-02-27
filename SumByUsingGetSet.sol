pragma solidity ^0.4.24;

contract totalSalary{
    
    //uint is an unsigned integer of 256 bits
    uint TotalSalary;
    
    //At first the constructor is being called with the creation of contract
    constructor() public{
        TotalSalary = 50000;
    }
    function get() public view returns(uint){
        return TotalSalary;
    }
    
    function set(uint bonous,uint salary) public {
        TotalSalary = bonous + salary;
    }
}