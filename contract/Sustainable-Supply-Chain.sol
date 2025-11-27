// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;



contract Project {
    struct Item {
        uint256 id;
        string name;
        string origin;
        bool isSustainable;
        address owner;
    }

    uint256 public nextItemId;
    mapping(uint256 => Item) public items;

    event ItemRegistered(uint256 indexed id, string name, string origin, address indexed owner);
    event OwnershipTransferred(uint256 indexed id, address indexed previousOwner, address indexed newOwner);
    event SustainabilityUpdated(uint256 indexed id, bool isSustainable);

    // Register an item into the supply chain
    function registerItem(string calldata name, string calldata origin, bool isSustainable) external {
        items[nextItemId] = Item(nextItemId, name, origin, isSustainable, msg.sender);
        emit ItemRegistered(nextItemId, name, origin, msg.sender);
        nextItemId++;
    }

    // Transfer ownership of an item to another participant
    function transferOwnership(uint256 itemId, address newOwner) external {
        Item storage item = items[itemId];
        require(msg.sender == item.owner, "only owner can transfer item");
        address previousOwner = item.owner;
        item.owner = newOwner;
        emit OwnershipTransferred(itemId, previousOwner, newOwner);
    }

    // Update sustainability status 
    function updateSustainabilityStatus(uint256 itemId, bool status) external {
        Item storage item = items[itemId];
        require(msg.sender == item.owner, "only item owner can update status");
        item.isSustainable = status;
        emit SustainabilityUpdated(itemId, status);
    }
}
