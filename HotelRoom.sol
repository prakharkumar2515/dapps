// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract HotelRoom {

    enum Statuses { Vacant, Occupied }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint _value);

    address payable  public owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
        // check status
        require(currentStatus == Statuses.Vacant, "Hotel is booked");
        _;
    }

    modifier costCheck (uint _amount) {
        // check price
        require(msg.value >= _amount, "Not enough ether provided.");
        _;
    }

    function bookRoom() external payable onlyWhileVacant costCheck(1 wei) {
        // // check price
        // require(msg.value >= 2 ether, "Not enough ether provided.");

        // // check status
        // require(currentStatus == Statuses.Vacant, "Hotel is booked");

        currentStatus = Statuses.Occupied;
        // owner.transfer(msg.value);

        (bool sent, ) = payable (msg.sender).call{value: 1 wei}("");
        require(sent, "Transaction failed.");

        emit Occupy(msg.sender, msg.value);
    }
    // Ether payments
    // Modifiers
    // Visibility
    // Events
    // Enums
    
}