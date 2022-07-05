//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;


interface IERC20 {

    function totalSupply() external view returns(uint);

    function balanceOf(address account) external view returns(uint);

    function transfer(address receipient, uint amount) external returns(bool);

    function allowance(address owner, address apender) external view returns(uint);

    function approve(address spender, uint amount) external returns(bool);

    function transferFrom(address sender, address recipient, uint amount) external returns(bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

}

abstract contract ERC20 is IERC20 {
    uint public totalSupply;

    mapping(address => uint) balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    string public name;
    string public symbol;
    uint public decimals;

    constructor() {
        name = "My Token";
        symbol = "MT";
        decimals = 20;
    }

    function transfer(address receipient, uint amount) external returns(bool){
        balanceOf[msg.sender] -= amount;
        balanceOf[receipient] += amount;
        emit Transfer(msg.sender, receipient, amount);
        return true;
    }

    function approve(address spender, uint amount) external returns(bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external returns(bool) {
        allowance[sender][msg.sender] -= amount;
        balanceOf[sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(uint amount) public {
        balanceOf[msg.sender] += amount;
        totalSupply += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) public {
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;

        emit Transfer(msg.sender, address(0), amount);
    }


}