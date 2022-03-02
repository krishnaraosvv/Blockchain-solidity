// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract VendingMachine{
    address public owner;
    mapping(address => uint) public candyBalances;

    constructor() {
        owner = msg.sender;
        candyBalances[address(this)] = 100;
    }

    function getVendingMachineBalance() public view returns(uint)  {
        return candyBalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock this vending machine.");
        candyBalances[address(this)] += amount;        
    }

    function purchase(uint amount) public payable{
        require(msg.value >= amount * 0.01 ether, "You must pay atleast 0.01 ether per candy");
        require(candyBalances[address(this)] >= amount, "Sorry!, Candies are Out of Stock...");
        candyBalances[address(this)] -= amount;    
        candyBalances[msg.sender] += amount;    
    }
}