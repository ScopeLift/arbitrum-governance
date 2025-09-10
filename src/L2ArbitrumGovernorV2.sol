// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

import {
    L2ArbitrumGovernor,
    GovernorUpgradeable,
    IGovernorUpgradeable
} from "src/L2ArbitrumGovernor.sol";

contract L2ArbitrumGovernorV2 is L2ArbitrumGovernor {
    error ProposalNotPending(GovernorUpgradeable.ProposalState state);
    error NotProposer(address sender, address proposer);

    mapping(uint256 => address) private proposers;

    function propose(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        string memory description
    ) public override(GovernorUpgradeable, IGovernorUpgradeable) returns (uint256) {
        uint256 _proposalId = GovernorUpgradeable.propose(targets, values, calldatas, description);
        proposers[_proposalId] = msg.sender;
        return _proposalId;
    }

    /// @notice Allows a proposer to cancel a proposal when it is pending.
    /// @param targets A list of target addresses for calls to be made in the proposal.
    /// @param values A list of values (ETH) to be passed to the calls in the proposal.
    /// @param calldatas A list of calldata for the calls in the proposal.
    /// @param descriptionHash The hash of the description for the proposal.
    /// @return The id of the proposal.
    function cancel(
        address[] memory targets,
        uint256[] memory values,
        bytes[] memory calldatas,
        bytes32 descriptionHash
    ) public returns (uint256) {
        uint256 _proposalId = hashProposal(targets, values, calldatas, descriptionHash);

        if (state(_proposalId) != ProposalState.Pending) {
            revert ProposalNotPending(state(_proposalId));
        }

        address _proposer = proposers[_proposalId];
        if (msg.sender != _proposer) {
            revert NotProposer(msg.sender, _proposer);
        }

        delete proposers[_proposalId];

        return GovernorUpgradeable._cancel(targets, values, calldatas, descriptionHash);
    }
}
