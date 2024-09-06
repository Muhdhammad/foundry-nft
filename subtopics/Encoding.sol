// SPDX-License Identifier: MIT

pragma solidity ^0.8.26;

contract Encoding {

    // abi.encodePacked() returns bytes
    function concatString() public pure returns (string memory) {
        return string(abi.encodePacked("hello ", "there!"));
        // or
        // return string.concat("hey ", "there!");
    }

    function stringEncode() public pure returns (bytes memory) {
        return abi.encode("Any String");
    }

    function stringEncodePacked() public pure returns (bytes memory) {
        return abi.encodePacked("Any String");
    }

    function stringDecode() public pure returns (string memory) {
        return abi.decode(stringEncode(), (string));
    }

    function multiEncode() public pure returns (bytes memory) {
        return abi.encode("some string", "some other string");
    }

    function multiDecode() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(multiEncode(), (string, string));
        return (someString, someOtherString);
    }

    function multiEncodePacked() public pure returns (bytes memory) {
        return abi.encodePacked("some string ", "some other string");
    }

    // This function won't work because we are trying to decode string which is encodePacked
    function multiDecodePacked() public pure returns (string memory, string memory) {
        (string memory someString, string memory someOtherString) = abi.decode(multiEncodePacked(), (string,string));
        return (someString, someOtherString);
    }

    function multiStringCastPacked() public pure returns (string memory) {
        return string(multiEncodePacked());
    }

    // ABI
    // Contract Address
    // How do we send transactions that just call functions with data field populated?
    // How do we populate data fields?

    // call: How we call function to change the state of the blockchain
    // staticcall: This is how (at low level) we do our 'pure' and 'view' function calls

    // for example
    function withdraw(address recentWinner) public {
        (bool success, ) = recentWinner.call{value: address(this).balance}("");
        require(success, "Transfer Failed");
    }

    // - In our {}, we are able to pass specific fields of transaction, like value
    // - In our (), we are able to pass data in order to call a specific function, if it is empty then it means there is no data sent
    // - In above example, we only sent ETH so we did'nt need to call a function
    // - If we want to call a function or send any data, we will do it in these parenthesis ()
}