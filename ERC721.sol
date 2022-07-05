//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC721/ERC721.sol";


contract ERC155Openzip is ERC721, Ownable {

    uint rate = 1 ether;
    uint supply = 100;
    uint minted = 0;
    
    constructor() ERC721("My NFT", "MN") {}



    function mint(string memory _tokenURI) public payable {
        require(minted +1 <= supply, "No NFT left mint");
        require(msg.value >= rate, "Not enough balance");
        _safeMint(msg.sender, minted);
        _setTokenURI(minted, _tokenURI);
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