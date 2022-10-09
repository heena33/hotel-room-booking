// SPDX-License-Identifier: MIT;

pragma solidity ^0.8.0;

contract Ownable {
    address private owner;

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner {
        require(owner == msg.sender, "Sender is not owner.");
        _;
    }
}