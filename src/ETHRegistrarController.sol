// SPDX-License-Identifier: MIT
pragma solidity ~0.8.17;

import "./IPriceOracle.sol";

contract ETHRegistrarController
{
    function renew(
        string calldata name,
        uint256 duration
    ) external payable {}

    function rentPrice(
        string memory name,
        uint256 duration
    ) public view returns (IPriceOracle.Price memory price) {}
}
