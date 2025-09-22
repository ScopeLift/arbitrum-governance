// SPDX-License-Identifier: AGPL-3.0-only
// slither-disable-start reentrancy-benign

pragma solidity 0.8.16;

import {Script} from "forge-std/Script.sol";
import {SharedGovernorConstants} from "scripts/forge-scripts/SharedGovernorConstants.sol";
import "@openzeppelin/contracts-upgradeable/governance/GovernorUpgradeable.sol";
import {CreateL2ArbSysProposal} from "scripts/forge-scripts/CreateL2ArbSysProposal.sol";

contract SubmitUpgradeProposalScript is Script, SharedGovernorConstants, CreateL2ArbSysProposal {
    address PROPOSER_ADDRESS =
        vm.envOr("PROPOSER_ADDRESS", 0x1B686eE8E31c5959D9F5BBd8122a58682788eeaD); //L2Beat

    function run(address _timelockRolesUpgrader, uint256 _minDelay)
        public
        returns (
            address[] memory targets,
            uint256[] memory values,
            bytes[] memory calldatas,
            string memory description,
            uint256 _proposalId
        )
    {
        return proposeUpgrade(_timelockRolesUpgrader, _minDelay);
    }

    function proposeUpgrade(address _timelockRolesUpgrader, uint256 _minDelay)
        internal
        returns (
            address[] memory _targets,
            uint256[] memory _values,
            bytes[] memory _calldatas,
            string memory _description,
            uint256 _proposalId
        )
    {
        _description = "Proposal Description here";
        (_targets, _values, _calldatas) =
            createL2ArbSysProposal(_description, _timelockRolesUpgrader, _minDelay);
        vm.startBroadcast(PROPOSER_ADDRESS);
        _proposalId = GovernorUpgradeable(payable(L2_CORE_GOVERNOR)).propose(
            _targets, _values, _calldatas, _description
        );
        vm.stopBroadcast();
    }
}
