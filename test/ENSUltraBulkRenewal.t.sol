// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ENSUltraBulkRenewal.sol";
import "../src/ETHRegistrarController.sol";
import "../src/IPriceOracle.sol";

contract ENSUltraBulkRenewalTest is Test {
    UltraBulkRenewal public narwhal;
    ETHRegistrarController public controller;

    function setUp() public {
        controller = ETHRegistrarController(0x253553366Da8546fC250F225fe3d25d0C782303b);
        narwhal = new UltraBulkRenewal(controller);
    }

    function testRenewENS_1() public {
        uint256 duration = 31536000;
        string memory name = "lucemans";
        IPriceOracle.Price memory price = controller.rentPrice(
            name,
            duration
        );
        string[] memory names = new string[](1);
        names[0] = name;
        narwhal.renewAll{value: price.base}(names, duration, price.base);
    }
}
