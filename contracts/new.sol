// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract NewContract {
    string secret;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner.");
        _;
    }

    constructor(string memory _secret) {
        secret = _secret;
        owner = msg.sender;
    }

    function getSecret() public view onlyOwner returns (string memory) {
        return secret;
    }
}