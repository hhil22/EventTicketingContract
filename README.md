# EventTicketingContract
Solidity smart contract for event ticketing system.
# EventTicketing Smart Contract

This smart contract is written in Solidity for a simple event ticketing system.

## Author
- Hutson Hilburn  
- ISDS 4111

## Description
- Users can purchase tickets by sending the correct amount of Ether
- The contract tracks tickets sold and ownership
- Only the owner can withdraw collected funds or transfer ownership

## Features
- Contract Owner
- State variables: ticket price, total tickets, tickets sold
- Constructor initializes price and supply
- 3+ public functions: buy, check balance, withdraw, transfer ownership
- Modifiers: onlyOwner, ticketsAvailable
- Events: TicketPurchased, OwnershipTransferred

## License
