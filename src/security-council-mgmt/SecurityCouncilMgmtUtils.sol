// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

library SecurityCouncilMgmtUtils {
    function copyAddressArray(address[] memory source) public pure returns (address[] memory) {
        uint256 length = source.length;
        address[] memory destination = new address[](length);

        for (uint256 i = 0; i < length; i++) {
            destination[i] = source[i];
        }

        return destination;
    }

    function isInArray(address addr, address[] memory arr) internal pure returns (bool) {
        for (uint256 i = 0; i < arr.length; i++) {
            if (arr[i] == addr) {
                return true;
            }
        }
        return false;
    }
}
