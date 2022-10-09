// SPDX-License-Identifier: MIT;

pragma solidity ^0.8.0;

import "./Ownable.sol";
import "./PriceFeed.sol";

contract Hotel is Ownable, PriceFeed {
    enum Status {vaccant, occupied}

    Status status = Status.vaccant;

    address private owner;

    constructor() {
        owner = payable(msg.sender);
    }

    uint256 ethInUsd = 100;

    struct bookingDetails {
        address guest;
        Status room;
        bool breakfast;
    }

    bookingDetails[] public details;

    function booking() public payable onlyOwner {
        require(status == Status.vaccant, "Room is already occupied");
        require(getConversionRate(msg.value) >= ethInUsd, "Amount should be more than $100");

        if (getConversionRate(msg.value) == ethInUsd) {
            status = Status.occupied;
            details.push(bookingDetails(msg.sender, status, false));
        } else {
            status = Status.occupied;
            details.push(bookingDetails(msg.sender, status, true));
        }
        
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
        // {bool successfull; } = owner.call{value: address(this).balance}("");
    }

}