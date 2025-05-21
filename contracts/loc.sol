// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyContract {
    uint public amount;

    function deposit() public payable {
        amount += msg.value;
    }

    function withdraw(address payable recipient) public {
        payable(recipient).transfer(amount);
        amount = 0;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
