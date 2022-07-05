//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Whitelist {
    uint public maxWhitelist;
    uint public currentWhitelist;
    mapping(address => bool) whiteListed;

    constructor(uint _maxWhitelist) {
        maxWhitelist = _maxWhitelist;
    }

    function getWhitelisted(address account) public {
        require(whiteListed[account] == false, "Already whitelisted");
        require(currentWhitelist <= maxWhitelist, "Seat not available");
        currentWhitelist++;
        whiteListed[account] = true;
    }

    function checkWhitelisted(address addr) public view returns(bool){
        if(whiteListed[addr] == true) {
            return true;
        }else {
            return false;
        }
    }

}