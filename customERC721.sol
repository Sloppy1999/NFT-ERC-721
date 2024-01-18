// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Person 1 (Owner): 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// Person 2 (Operator): 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

// Import OpenZeppelin Smart Contracts
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ERC721Contract is ERC721 {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // Metadata structure
    struct NFTMetadata {
        string name;
        string description;
    }

    // Mapping from token ID to metadata
    mapping(uint256 => NFTMetadata) private _tokenMetadata;

    constructor (string memory _name, string memory _symbol) ERC721(_name, _symbol) {}

    // Minting NFT with metadata
    function mintNFT(address _account, string memory _name, string memory _description) public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(_account, newItemId);

        // Store metadata
        _tokenMetadata[newItemId] = NFTMetadata(_name, _description);
    }

    // Access metadata for a given token ID
    function getMetadata(uint256 _tokenId) public view returns (NFTMetadata memory) {
        return _tokenMetadata[_tokenId];
    }
}
