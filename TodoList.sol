pragma solidity ^0.5.0;

contract TodoList{
    uint public taskCount = 0;
    
    struct Task{
        uint id;
        string content;
        bool completed;
    }
    
    // here uint is the datatype of key, and Task is the datatype of value
    mapping(uint => Task) public tasks;
    
    constructor() public{
        createTask("Task has assigned.");
    }
    
    function createTask(string memory _content) public{
        taskCount ++;
        
        //we need assign the value of struct by using first bracket
        tasks[taskCount] = Task(taskCount,_content,false);
    }
}