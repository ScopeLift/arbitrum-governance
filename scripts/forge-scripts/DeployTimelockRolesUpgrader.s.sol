// SPDX-License-Identifier: AGPL-3.0-only
// slither-disable-start reentrancy-benign

pragma solidity 0.8.16;

import {Script} from "forge-std/Script.sol";
import {BaseGovernorDeployer} from "scripts/forge-scripts/BaseGovernorDeployer.sol";
import {TimelockRolesUpgrader} from
    "src/gov-action-contracts/gov-upgrade-contracts/update-timelock-roles/TimelockRolesUpgrader.sol";
import {SharedGovernorConstants} from "scripts/forge-scripts/SharedGovernorConstants.sol";

contract DeployTimelockRolesUpgrader is SharedGovernorConstants, Script {
    function run(address _newCoreGovernor, address _newTreasuryGovernor)
        public
        returns (TimelockRolesUpgrader timelockRolesUpgrader)
    {
        vm.startBroadcast();
        timelockRolesUpgrader = new TimelockRolesUpgrader(
            L2_CORE_GOVERNOR_TIMELOCK,
            L2_CORE_GOVERNOR,
            _newCoreGovernor,
            L2_TREASURY_GOVERNOR_TIMELOCK,
            L2_TREASURY_GOVERNOR,
            _newTreasuryGovernor
        );
        vm.stopBroadcast();
    }
}
