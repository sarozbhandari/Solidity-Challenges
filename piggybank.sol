//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract PiggyBank {
    address public owner;

    event Deposit(uint amount);
    event Withdraw(uint amount);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw(uint _amount) public {
        payable(msg.sender).transfer(_amount);
        emit Withdraw(_amount);
        selfdestruct(payable(owner));
    }

}