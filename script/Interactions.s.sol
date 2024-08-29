// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "src/BasicNft.sol";

contract MintBasicNft is Script {
    string public constant MYLO = "https://gateway.pinata.cloud/ipfs/QmYnhBp5nXYBGeLVTnYccoaLG5ifcXhLTXE5JzgcCNz8Gx";

    function run() external {
        address mostRecentDeployment = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentDeployment);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(MYLO);
        vm.stopBroadcast();
    }
}
