// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ENS {
    struct User {
        string name;
        address addr;
    }

    mapping(bytes32 => User) users;
    mapping(address => string) names;
    mapping(string => address) addresses;

    function register(string memory _name) public {
        bytes32 key = keccak256(abi.encodePacked(_name));
        require(users[key].addr == address(0), "User already exists");

        User storage newUser = users[key];
        newUser.name = _name;
        newUser.addr = msg.sender;

        names[msg.sender] = _name;
        addresses[_name] = msg.sender;
    }

    function getName(address _addr) public view returns (string memory Name) {
        return names[_addr];
    }

    function getAddress(
        string memory _name
    ) public view returns (address Address) {
        return addresses[_name];
    }
}
