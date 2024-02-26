// SPDX-License-Identifier: GPLv3
pragma solidity ~0.8.17;

import "./ETHRegistrarController.sol";
import "./IUltraBulkRenewal.sol";
import "solmate/auth/Owned.sol";

contract UltraBulkRenewal is IUltraBulkRenewal, Owned {
    ETHRegistrarController controller;

    constructor(ETHRegistrarController _controller) Owned(msg.sender) {
        controller = _controller;
    }

    function renewAll(
        string[] calldata names,
        uint256 duration,
        uint256 price
    ) external payable override {
        uint256 length = names.length;
        uint256 i = 0;
        while (i < length) {
            controller.renew{value: price}(names[i], duration);
            unchecked {
                ++i;
            }
        }
    }

    function refund() external payable onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }
}
