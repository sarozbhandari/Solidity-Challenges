//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/access/Ownable.sol";


contract ERC155Openzip is ERC1155, Ownable {
    bool public paused;
    string baseURI;
    uint rate = 1 ether;
    uint supply = 100;
    uint minted = 0;
    
    constructor(string _baseURI) {
        baseURI = _baseURI;
    }

    modifier whenNotPaused() {
        require(paused == false, "Contract is paused");
        _;
    }
   

    function ChangedPaused(bool _paused) public {
        paused = _paused;
    }

    function mint() public payable {
        require(minted +1 <= supply, "No NFT left mint");
        require(msg.value >= rate, "Not enough balance");
        _mint(msg.sender, minted, rate, "");
        minted += 1;
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint amount = address(this).balance;
        payable(msg.sender).transfer(amount);
    }

    receive() external payable {}

    fallback() external  payable {}

}