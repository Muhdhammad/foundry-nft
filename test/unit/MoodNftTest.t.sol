// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "src/MoodNft.sol";

contract MoodNftTest is Test {
    MoodNft moodNft;
    address USER = makeAddr("user");

    string public constant SAD_IMG_URI = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8IS0tIEZhY2UgLS0+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIGZpbGw9IiM4N0NFRUIiIC8+CiAgCiAgPCEtLSBFeWVzIC0tPgogIDxjaXJjbGUgY3g9IjM1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMwMDAiIC8+CiAgPGNpcmNsZSBjeD0iNjUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzAwMCIgLz4KICAKICA8IS0tIFNhZCBNb3V0aCAtLT4KICA8cGF0aCBkPSJNMzUsNjUgUTUwLDUwIDY1LDY1IiBzdHJva2U9IiMwMDAiIHN0cm9rZS13aWR0aD0iMyIgZmlsbD0ibm9uZSIgLz4KPC9zdmc+Cg==";

    string public constant HAPPY_IMG_URL = "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjEwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8IS0tIEZhY2UgLS0+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIGZpbGw9IiNGRkQ3MDAiIC8+CiAgCiAgPCEtLSBFeWVzIC0tPgogIDxjaXJjbGUgY3g9IjM1IiBjeT0iNDAiIHI9IjUiIGZpbGw9IiMwMDAiIC8+CiAgPGNpcmNsZSBjeD0iNjUiIGN5PSI0MCIgcj0iNSIgZmlsbD0iIzAwMCIgLz4KICAKICA8IS0tIFNtaWxlIC0tPgogIDxwYXRoIGQ9Ik0zNSw2MCBRNTAsNzUgNjUsNjAiIHN0cm9rZT0iIzAwMCIgc3Ryb2tlLXdpZHRoPSIzIiBmaWxsPSJub25lIiAvPgo8L3N2Zz4K";

    function setUp() external {
        moodNft = new MoodNft(SAD_IMG_URI, HAPPY_IMG_URL);
    }

    function testViewTokenURI() public {
        vm.prank(USER);
        moodNft.mint();
        console.log(moodNft.tokenURI(0));
    }
}
