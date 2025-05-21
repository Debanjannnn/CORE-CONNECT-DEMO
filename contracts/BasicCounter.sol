// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicCounter {
    // Variable to store the count
    uint256 public count;

    // Function to add a number
    function add(uint256 _number) public {
        count = count + _number;
    }

    // Function to subtract a number
    function subtract(uint256 _number) public {
        count = count - _number;
    }

    // Function to get current count
    function getCount() public view returns (uint256) {
        return count;
    }
} 