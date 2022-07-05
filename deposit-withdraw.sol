//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DeposotiWithdraw {
    address payable public owner;
    
    event Deposit(address indexed account, uint amount);
    event Withdraw(address indexed account, uint amount);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    function checkBalance() external view returns(uint256 balance) {
        return address(this).balance;
    }

    function withdraw(uint _amount) external onlyOwner() {
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    fallback() external payable {}

}