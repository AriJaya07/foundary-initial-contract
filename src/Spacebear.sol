// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.5.0
pragma solidity ^0.8.21;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/utils/Strings.sol";

contract Spacebear is ERC721, Ownable {
    uint256 private _tokenIdCounter;

    constructor() ERC721("Spacebear", "SBR") Ownable(msg.sender) {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://todo-meta.onrender.com/nftdata/";
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter;
        _tokenIdCounter++;
        _safeMint(to, tokenId);
    }

    function buyToken() public payable {
        uint256 tokenId = _tokenIdCounter;
        require(msg.value == tokenId * 0.1 ether, "Not enough funds sent");
        _tokenIdCounter++;
        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        pure
        override(ERC721)
        returns (string memory)
    {
        return string(abi.encodePacked(_baseURI(), "spacebear_", Strings.toString(tokenId + 1), ".json"));
    }
}