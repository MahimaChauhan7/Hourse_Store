// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Script} from "forge-std/Script.sol";
import {HorseStore} from "../src/HorseStoreV1.sol";

contract DeployHorseStore is Script {
    function run() external returns (HorseStore) {
        vm.startBroadcast();
        HorseStore horseStore = new HorseStore();
        vm.stopBroadcast();
        return horseStore;
    }
}

