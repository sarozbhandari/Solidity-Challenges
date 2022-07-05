// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Ownerable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not owner");
        _;
    }

    function checkOwner() public view returns(bool) {
        if(msg.sender == owner) {
            return true;
        }else {
            return false;
        }

    }

    function changeOwner(address _owner) public onlyOwner{
        owner = _owner;
    }
}