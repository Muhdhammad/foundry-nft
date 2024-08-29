// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {

    function run() external returns(MoodNft) {
        string memory sadSvg = vm.readFile("img/sadmood.svg");
        string memory happySvg = vm.readFile("img/happymood.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft();
    }

    function svgToImageURI(string memory svg) public pure returns(string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";

        string memory svgBase64Encoded = bytes(string(abi.encode(svg)));
        return string(abi.encode(baseURL, svgBase64Encoded));
    }
}