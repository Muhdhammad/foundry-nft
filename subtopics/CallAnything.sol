// SPDX-License Identifier: MIT

// In order to call a function using only data field of the call, we need to encode:
// The function name
// The parameters we want to add
// Down to the binary level

// Now contract assigns each function a function ID called as 'function selector'

// 'function selector' is the first 4 bytes of function signature
// 'function signature' is the string that defines function name and parameters

pragma solidity ^0.8.26;

contract callAnything {
    address public s_address;
    uint256 public s_amount;

    function transfer(address _address, uint256 _amount) public {
        s_address = _address;
        s_amount = _amount;
    }

    function getSelectorOne() public pure returns (bytes4 selector) {
        // converts the string to the bytes type so it can be hashed using keccak256
        // then bytes4(..) takes the first 4 bytes of the hash
        selector = bytes4(keccak256(bytes("transfer(address,uint256)")));
    }

    function getDataToCallTransfer(address _address, uint256 _amount) public pure returns (bytes memory) {
        abi.encodeWithSelector(getSelectorOne(), _address, _amount);
    }

    function callTransferFunctionDirectly(address _address, uint256 _amount) public returns(bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(
            // getDataToCallTransfer(_address, amount)
            abi.encodeWithSelector(getSelectorOne(), _address, _amount)
        );
        return (bytes4(returnData), success);
    }

    function callTransferFunctionDirectlySig(address _address, uint256 _amount) public returns(bytes4, bool) {
        (bool success, bytes memory returnData) = address(this).call(
            // getDataToCallTransfer(_address, amount)
            abi.encodeWithSignature("transfer(address,uint256)", _address, _amount)
        );
        return (bytes4(returnData), success);
    }
}