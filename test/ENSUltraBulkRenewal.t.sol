// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ENSUltraBulkRenewal.sol";
import "../src/ETHRegistrarController.sol";
import "../src/IPriceOracle.sol";

contract ENSUltraBulkRenewalTest is Test {
    UltraBulkRenewal public narwhal;
    ETHRegistrarController public controller;
    IPriceOracle.Price public price;
    uint256 duration = 31536000;

    string[] names_one = ["lucemans"];
    string[] names_two = ["lucemans", "vitalik"];
    string[] names_ten = ["lucemans", "vitalik", "notantony", "notluc", "willbreak", "helgesson", "matoken", "leontalbert", "domico", "gregskril"];
    string[] names_twenty = ["lucemans", "vitalik", "notantony", "notluc", "willbreak", "helgesson", "matoken", "leontalbert", "domico", "gregskril", "lucemans", "vitalik", "notantony", "notluc", "willbreak", "helgesson", "matoken", "leontalbert", "domico", "gregskril"];

    function setUp() public {
        controller = ETHRegistrarController(0x253553366Da8546fC250F225fe3d25d0C782303b);
        narwhal = new UltraBulkRenewal(controller);

        price = controller.rentPrice(
            "lucemans",
            duration
        );
    }

    function testRenewENS_1() public {
        narwhal.renewAll{value: price.base * 1}(names_one, duration, price.base);
    }

    function testRenewENS_2() public {
        narwhal.renewAll{value: price.base * 2}(names_two, duration, price.base);
    }

    function testRenewENS_10() public {
        narwhal.renewAll{value: price.base * 10}(names_ten, duration, price.base);
    }

    function testRenewENS_20() public {
        narwhal.renewAll{value: price.base * 20}(names_twenty, duration, price.base);
    }
}
