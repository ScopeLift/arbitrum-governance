// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

import "../L2ArbitrumGovernor.sol";

contract SecurityCouncilMemberRemovalGovernor is L2ArbitrumGovernor {
    uint256 public constant voteSuccessDenominator = 10_000;

    uint256 public voteSuccessNumerator;

    event VoteSuccessNumeratorSet(uint256 indexed voteSuccessNumerator);

    /// @notice Initialize the contract
    /// @dev this method does not include an initializer modifier; it calls its parent's initiaze method which itself prevents repeated initialize calls
    /// @param _voteSuccessNumerator value that with denominator 10_000 determines the ration of for/against votes required for success
    /// @param _token The address of the governance token
    /// @param _timelock A time lock for proposal execution
    /// @param _owner The DAO (Upgrade Executor); admin over proposal role
    /// @param _votingDelay The delay between a proposal submission and voting starts
    /// @param _votingPeriod The period for which the vote lasts
    /// @param _quorumNumerator The proportion of the circulating supply required to reach a quorum
    /// @param _proposalThreshold The number of delegated votes required to create a proposal
    /// @param _minPeriodAfterQuorum The minimum number of blocks available for voting after the quorum is reached
    function initialize(
        uint256 _voteSuccessNumerator,
        IVotesUpgradeable _token,
        TimelockControllerUpgradeable _timelock,
        address _owner,
        uint256 _votingDelay,
        uint256 _votingPeriod,
        uint256 _quorumNumerator,
        uint256 _proposalThreshold,
        uint64 _minPeriodAfterQuorum
    ) public {
        _setVoteSuccessNumerator(_voteSuccessNumerator);
        this.initialize(
            _token,
            _timelock,
            _owner,
            _votingDelay,
            _votingPeriod,
            _quorumNumerator,
            _proposalThreshold,
            _minPeriodAfterQuorum
        );
    }

    /// @notice override to allow for required vote success ratio that isn't 0.5
    /// @param proposalId target proposal id
    function _voteSucceeded(uint256 proposalId)
        internal
        view
        virtual
        override(GovernorCountingSimpleUpgradeable, GovernorUpgradeable)
        returns (bool)
    {
        (uint256 againstVotes, uint256 forVotes, uint256 __) = proposalVotes(proposalId);

        return voteSuccessNumerator * forVotes > againstVotes * voteSuccessDenominator;
    }

    /// @notice set numerator for removal vote to succeed; only DAO can call
    /// @param _voteSuccessNumerator new numberator value
    function setVoteSuccessNumerator(uint256 _voteSuccessNumerator) public onlyOwner {
        _setVoteSuccessNumerator(_voteSuccessNumerator);
    }

    function _setVoteSuccessNumerator(uint256 _voteSuccessNumerator) internal {
        require(
            _voteSuccessNumerator > 0 && _voteSuccessNumerator <= voteSuccessDenominator,
            "SecurityCouncilMemberRemovalGovernor: _voteSuccessNumerator must be within [1, voteSuccessDenominator]"
        );
        voteSuccessNumerator = _voteSuccessNumerator;
        emit VoteSuccessNumeratorSet(_voteSuccessNumerator);
    }
}
