// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {HorseStore} from "../src/HorseStoreV1.sol";
import {Test, console2} from "forge-std/Test.sol";

abstract contract Base_TestV1 is Test {
    HorseStore public horseStore;

    function setUp() public virtual {
        horseStore = new HorseStore();
    }

    function testReadValue() public {
        uint256 initialValue = horseStore.readNumberOfHorses();
        assertEq(initialValue, 0);
    } // This warning means the Solidity compiler detected that your testReadValue() function doesn't modify any state (storage), so it could be declared as view instead of public for better gas efficiency and clarity.

    function testWriteValue(uint256 numberOfHorses) public {
        horseStore.updateHorseNumber(numberOfHorses);
        assertEq(horseStore.readNumberOfHorses(), numberOfHorses);
    }
}
