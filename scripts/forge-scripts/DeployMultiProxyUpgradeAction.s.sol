// SPDX-License-Identifier: AGPL-3.0-only
// slither-disable-start reentrancy-benign

pragma solidity 0.8.16;

import {Script} from "forge-std/Script.sol";
import {MultiProxyUpgradeAction} from
    "src/gov-action-contracts/gov-upgrade-contracts/upgrade-proxy/MultiProxyUpgradeAction.sol";
import {SharedGovernorConstants} from "scripts/forge-scripts/SharedGovernorConstants.sol";

contract DeployMultiProxyUpgradeAction is SharedGovernorConstants, Script {
    function run(address _newCoreGovernor, address _newTreasuryGovernor)
        public
        returns (MultiProxyUpgradeAction multiProxyUpgradeAction)
    {
        vm.startBroadcast();
        multiProxyUpgradeAction = new MultiProxyUpgradeAction(
            L2_PROXY_ADMIN_CONTRACT,
            L2_CORE_GOVERNOR,
            _newCoreGovernor,
            L2_TREASURY_GOVERNOR,
            _newTreasuryGovernor
        );
        vm.stopBroadcast();
    }
}
