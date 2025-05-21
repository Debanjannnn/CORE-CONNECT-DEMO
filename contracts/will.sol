// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWill {
    address public owner; // Person who creates the will
    address public recipient; // Person who will receive the funds
    uint256 public amount; // Amount of money in the contract

    constructor() {
        owner = msg.sender; // Set the creator as owner
    }

    function deposit() public payable {
        require(msg.sender == owner, "Only owner can deposit");
        amount += msg.value; // Add deposited amount
    }

    function setRecipient(address _recipient) public {
        require(msg.sender == owner, "Only owner can set recipient");
        require(_recipient != address(0), "Invalid recipient address");
        recipient = _recipient; // Set who gets the funds
    }

    function claim() public {
        require(msg.sender == recipient, "Only recipient can claim");
        require(amount > 0, "No funds to claim");
        payable(recipient).transfer(amount); // Send funds to recipient
        amount = 0; // Reset amount
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance; // Show contract's balance
    }
}