// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {Test} from "forge-std/Test.sol";
import {HorseStore} from "../../src/HorseStoreV2/HorseStoreV2.sol";

abstract contract Base_TestV2 is Test {
    HorseStore public horseStore;

    function setUp() public virtual {
        horseStore = new HorseStore();
    }

    function testMintHorse() public virtual {
        vm.prank(address(1));
        horseStore.mintHorse();
        assertEq(horseStore.balanceOf(address(1)), 1);
    }

    function testFeedHorse() public {
        vm.startPrank(address(1));
        horseStore.mintHorse();
        uint256 tokenId = 0;
        horseStore.feedHorse(tokenId);
        assertGt(horseStore.horseIdToFedTimeStamp(tokenId), 0);
        vm.stopPrank();
    }

    function testIsHappyHorse() public {
        // Warp time forward to avoid underflow in timestamp subtraction
        vm.warp(2 days);
        vm.startPrank(address(1));
        horseStore.mintHorse();
        uint256 tokenId = 0;
        horseStore.feedHorse(tokenId);
        assertTrue(horseStore.isHappyHorse(tokenId));
        vm.stopPrank();
    }
}
