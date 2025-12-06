// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;
import {Base_TestV1} from "./Base_TestV1.t.sol";
import {HorseStore} from "../src/HorseStoreV1.sol";
import {HuffDeployer} from "foundry-huff/HuffDeployer.sol";

contract HorseStoreHuff is Base_TestV1 {
    string public constant HORSE_STORE_HUFF_LOCATION = "horseStoreV1/horsestore";

    function setUp() public override {
        // Deploy the Huff implementation
        horseStore = HorseStore(HuffDeployer.config().deploy(HORSE_STORE_HUFF_LOCATION));
    }
}
