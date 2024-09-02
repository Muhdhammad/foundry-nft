// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "src/MoodNft.sol";
import "forge-std/console2.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {

    function run() external returns(MoodNft) {
        string memory sadSvg = vm.readFile("./img/sadmood.svg");
        string memory happySvg = vm.readFile("./img/happymood.svg");


        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        console2.log("Sad SVG URI: %s", svgToImageURI(sadSvg));
        vm.stopBroadcast();
        return moodNft;
    }

    function svgToImageURI(string memory _svg) public pure returns (string memory) {
        // example: "data:image/svg+xml;base64,PHN2ZyB4bWxu..."
        // <svg width'"1024px" height="1024px"
        // data:image/svg+xml;base64,PHN2ZyB4bWxu...

        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}