// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";
import {BasicNft} from "src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;

    address USER = makeAddr("user");
    string public constant MYLO = "https://gateway.pinata.cloud/ipfs/QmYnhBp5nXYBGeLVTnYccoaLG5ifcXhLTXE5JzgcCNz8Gx";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public {
        string memory expectedName = "NEKO";
        string memory actualName = basicNft.name();

        /* String is a complex type and it is dynamic array of bytes 
        / so, we can't compare them using '=='
        assert(expectedName == actualName); */

        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(MYLO);

        assert(basicNft.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(MYLO)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
    }
}
