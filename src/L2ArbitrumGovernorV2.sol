// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

import {L2ArbitrumGovernor, GovernorUpgradeable} from "src/L2ArbitrumGovernor.sol";

contract L2ArbitrumGovernorV2 is L2ArbitrumGovernor {
    error ProposalNotPending(GovernorUpgradeable.ProposalState state);

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
        return GovernorUpgradeable._cancel(targets, values, calldatas, descriptionHash);
    }
}
