// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Ownable {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

}

contract SecretVault {
    string secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function getSecretOld() public view returns (string memory) {
        return secret;
    }
}

contract NewContract is Ownable { // Inheritence
    address secretVault;

    constructor(string memory _secret) {
        SecretVault _secretVault = new SecretVault(_secret); // Creating new contract inside contract
        secretVault = address(_secretVault);
    }

    function getSecret() public view onlyOwner returns (string memory) {
        return SecretVault(secretVault).getSecretOld();
    }
       
}