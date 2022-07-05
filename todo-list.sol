//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TodoList {
    address public owner;

    struct Tasks {
        string todo;
        bool completed;
    }
    Tasks[] public todos;

    event TaskAdded(string task);
    event TaskCompleted(uint index);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    function addTask(string memory _todo) public onlyOwner{
        todos.push(Tasks({
            todo: _todo,
            completed: false
        }));
        emit TaskAdded(_todo);
    }

    function completeTask(uint _index) public onlyOwner {
        Tasks memory todo = todos[_index];
        todo.completed = true;

        emit TaskCompleted(_index);
    }

    function update(string memory _todo, uint _index) public {
        todos[_index].todo = _todo;
    }

    function getTodo(uint _index) public view returns (string memory, bool) {
        return (todos[_index].todo, todos[_index].completed);
    }

}