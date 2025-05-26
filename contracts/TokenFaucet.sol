// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC20 {
    function transfer(address to, uint256 amount) external returns (bool);
}

contract TokenFaucet {
    IERC20 public token;
    uint256 public dripAmount;
    uint256 public cooldown = 1 days;

    mapping(address => uint256) public lastDrip;

    constructor(address _token, uint256 _dripAmount) {
        token = IERC20(_token);
        dripAmount = _dripAmount;
    }

    function requestTokens() external {
        require(block.timestamp - lastDrip[msg.sender] >= cooldown, "Wait before next drip");
        lastDrip[msg.sender] = block.timestamp;
        token.transfer(msg.sender, dripAmount);
    }
}
