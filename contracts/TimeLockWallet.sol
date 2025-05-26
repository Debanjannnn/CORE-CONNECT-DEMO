// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimeLockWallet {
    struct Deposit {
        uint256 amount;
        uint256 unlockTime;
    }

    mapping(address => Deposit) public deposits;

    function deposit(uint256 _lockTimeInSeconds) external payable {
        require(msg.value > 0, "Send some ETH");
        deposits[msg.sender] = Deposit({
            amount: msg.value,
            unlockTime: block.timestamp + _lockTimeInSeconds
        });
    }

    function withdraw() external {
        Deposit memory userDeposit = deposits[msg.sender];
        require(block.timestamp >= userDeposit.unlockTime, "Locked");
        require(userDeposit.amount > 0, "Nothing to withdraw");

        deposits[msg.sender].amount = 0;
        payable(msg.sender).transfer(userDeposit.amount);
    }

    function getTimeLeft() external view returns (uint256) {
        if (block.timestamp >= deposits[msg.sender].unlockTime) {
            return 0;
        }
        return deposits[msg.sender].unlockTime - block.timestamp;
    }
}
