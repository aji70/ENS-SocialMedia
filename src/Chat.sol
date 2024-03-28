// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

interface IENS {
    struct User {
        string name;
        address addr;
    }

    function register(string memory _name) external;

    function getName(address _addr) external view returns (string memory Name);

    function getAddress(
        string memory _name
    ) external view returns (address Address);
}

contract Chat {
    address ENS;
    uint userIds;

    struct User {
        string name;
        address addr;
        string handle;
        uint id;
        uint256 msgIds;
        string displayPic;
    }

    struct Conversation {
        uint conversationId;
        Message[] text;
        bool convoStarted;
        string name;
    }

    struct Message {
        string name;
        string data;
    }

    mapping(string => User) userProfile;

    mapping(address => bool) registered;
    mapping(address => User) userAddrProfile;
    mapping(uint => User) userProfileByID;

    mapping(address => Message) messageFrom;

    mapping(uint => Conversation) conversationss;
    mapping(address => mapping(address => Conversation)) conVersations;

    constructor(address _ens) {
        ENS = _ens;
    }

    function register(
        string memory _name,
        string memory handle,
        string memory IPfS
    ) public {
        require(
            IENS(ENS).getAddress(_name) == msg.sender,
            "Could Not correctly verify Address"
        );
        require(!registered[msg.sender], "Already Registered");
        userIds += 1;
        uint id = userIds;
        User storage newUser = userProfile[_name];
        newUser.id = id;
        newUser.name = _name;
        newUser.addr = msg.sender;
        newUser.handle = handle;
        newUser.displayPic = IPfS;

        userProfileByID[id] = newUser;
        userAddrProfile[msg.sender] = newUser;
    }

    function getUserById(uint id) public view returns (User memory Name) {
        return userProfileByID[id];
    }

    function sendMessage(address _to, string memory _message) public {
        require(!registered[msg.sender], "Register to send message");
        require(
            !registered[_to],
            "Can not send message to unregistered accounts"
        );
        Conversation storage newConvo = conVersations[msg.sender][_to];
        Conversation storage newConvo1 = conVersations[_to][msg.sender];

        newConvo.name = IENS(ENS).getName(msg.sender);
        Message storage newMessage = messageFrom[msg.sender];

        newMessage.data = _message;
        newMessage.name = newConvo.name;

        newConvo.text.push(newMessage);
        newConvo1.text.push(newMessage);
    }

    function GetConvo(address _address) public view returns (Message[] memory) {
        require(!registered[_address], "Account does not exist");
        Conversation storage newConvo = conVersations[msg.sender][_address];

        return newConvo.text;
    }

    function GetConvoByName(
        string memory _name
    ) public view returns (Message[] memory) {
        address _address;
        _address = IENS(ENS).getAddress(_name);
        require(!registered[_address], "Account does not exist");

        Conversation storage newConvo = conVersations[msg.sender][_address];

        return newConvo.text;
    }
}
