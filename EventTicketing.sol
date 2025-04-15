// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title EventTicketing Smart Contract
 * @author Hutson Hilburn
 * @course ISDS 4111
 * @description This smart contract allows users to buy tickets for an event,
 *              while the contract owner manages sales and can withdraw funds.
 */

contract EventTicketing {
    address public owner;
    uint public ticketPrice;
    uint public totalTickets;
    uint public ticketsSold;

    mapping(address => uint) public ticketsOwned;

    event TicketPurchased(address indexed buyer, uint quantity);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action.");
        _;
    }

    modifier ticketsAvailable(uint quantity) {
        require(ticketsSold + quantity <= totalTickets, "Not enough tickets left.");
        _;
    }

    constructor(uint _ticketPrice, uint _totalTickets) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        totalTickets = _totalTickets;
        ticketsSold = 0;
    }

    // Public function: buy tickets
    function buyTicket(uint quantity) public payable ticketsAvailable(quantity) {
        require(msg.value == ticketPrice * quantity, "Incorrect payment amount.");
        ticketsOwned[msg.sender] += quantity;
        ticketsSold += quantity;
        emit TicketPurchased(msg.sender, quantity);
    }

    // Public function: check ticket balance
    function getMyTickets() public view returns (uint) {
        return ticketsOwned[msg.sender];
    }

    // Public function: owner withdraws funds
    function withdrawFunds() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    // Public function: transfer ownership
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address.");
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
