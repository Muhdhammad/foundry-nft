// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";


contract MoodNft is ERC721 {

    error MoodNft__CantFlipMoodNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        happy,
        sad
    }

    mapping(uint256 => Mood) public s_tokenIdToMood;

    constructor(string memory sadSvgImageUri, string memory happySvgImageUri) ERC721("MoodNft", "MN") {
        s_tokenCounter = 0;
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
    }

    function mint() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.happy;
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenID) public {
        if (!_isApprovedOrOwner(msg.sender, tokenID)) {
            revert MoodNft__CantFlipMoodNotOwner();
        }
        if (s_tokenIdToMood[tokenID] == Mood.happy) {
            s_tokenIdToMood[tokenID] == Mood.sad;
        } else {
            s_tokenIdToMood[tokenID] == Mood.happy;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenID) public view override returns (string memory) {
        uint256 tokenID;
        string memory imageURI;
        if (s_tokenIdToMood[tokenID] == Mood.happy) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes( // bytes casting actually unnecessary as 'abi.encodePacked()' returns a bytes
                        abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"NFT that reflects the mood, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }
}
