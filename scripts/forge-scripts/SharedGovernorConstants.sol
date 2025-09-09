// SPDX-License-Identifier: AGPL-3.0-only
// slither-disable-start reentrancy-benign

pragma solidity 0.8.26;

// Inheritable extension holding governor deployment constants that are shared between the Core Governor and the
// Treasury Governor. These should be carefully checked and reviewed before final deployment.
contract SharedGovernorConstants {
  uint256 constant FORK_BLOCK = 245_608_716; // Arbitrary recent block
  address public constant L2_ARB_TOKEN_ADDRESS = 0x912CE59144191C1204E64559FE8253a0e49E6548;

  address public constant L2_CORE_GOVERNOR = 0xf07DeD9dC292157749B6Fd268E37DF6EA38395B9;
  address public constant L2_CORE_GOVERNOR_TIMELOCK = 0x34d45e99f7D8c45ed05B5cA72D54bbD1fb3F98f0;
  address public constant L2_TREASURY_GOVERNOR = 0x789fC99093B09aD01C34DC7251D0C89ce743e5a4;
  address public constant L2_TREASURY_GOVERNOR_TIMELOCK = 0xbFc1FECa8B09A5c5D3EFfE7429eBE24b9c09EF58;
  address public constant L2_PROXY_ADMIN = 0xdb216562328215E010F819B5aBe947bad4ca961e;

  address public constant L2_ARB_SYS = 0x0000000000000000000000000000000000000064;
  address public constant L2_ARB_TREASURY_FIXED_DELEGATE = 0xF3FC178157fb3c87548bAA86F9d24BA38E649B58;
  address public constant L2_ARB_RETRYABLE_TX = 0x000000000000000000000000000000000000006E;
  address public constant L2_SECURITY_COUNCIL_9 = 0x423552c0F05baCCac5Bfa91C6dCF1dc53a0A1641;

  address public constant L1_TIMELOCK = 0xE6841D92B0C345144506576eC13ECf5103aC7f49;
  uint256 public constant L1_TIMELOCK_MIN_DELAY = 259_200; // TODO: Make sure this is up to date.
  address public constant L1_ARB_ONE_DELAYED_INBOX = 0x4Dbd4fc535Ac27206064B68FfCf827b0A60BAB3f;

  address public constant L2_CORE_GOVERNOR_ONCHAIN = 0x7796F378B3c56ceD57350B938561D8c52256456b;
  address public constant L2_TREASURY_GOVERNOR_ONCHAIN = 0x4fd1216c8b5E72b22785169Ae5C1e8f3b30C19E4;
  address public constant TIMELOCK_ROLES_UPGRADER_ONCHAIN = 0x1a425339a34ea3C75fd96D6b08358Ee3f6e29f3B;
  bool public constant UPGRADE_PROPOSAL_PASSED_ONCHAIN = false; // TODO: Update after the upgrade proposal is passed.

  address public constant L2_UPGRADE_EXECUTOR = 0xCF57572261c7c2BCF21ffD220ea7d1a27D40A827;

  address public constant RETRYABLE_TICKET_MAGIC = 0xa723C008e76E379c55599D2E4d93879BeaFDa79C;

  address public constant EXCLUDE_ADDRESS = address(0xA4b86);
  uint256 public constant QUORUM_DENOMINATOR = 10_000;

  bytes32 public constant TIMELOCK_PROPOSER_ROLE = 0xb09aa5aeb3702cfd50b6b62bc4532604938f21248a27a1d5ca736082b6819cc1;

  uint8 public constant VOTE_TYPE_FRACTIONAL = 255;

  // These values match the current production values for both governors. Note that they are expressed in L1 blocks,
  // with an assumed 12 second block time, because on Arbitrum, block.number returns the number of the L1.
  uint48 public constant INITIAL_VOTING_DELAY = 21_600; // 3 days
  uint32 public constant INITIAL_VOTING_PERIOD = 100_800; // 14 days
  uint48 public constant INITIAL_VOTE_EXTENSION = 14_400; // 2 days

  // This value matches the current production value for both governors. 1M Arb in raw decimals.
  uint256 public constant INITIAL_PROPOSAL_THRESHOLD = 1_000_000_000_000_000_000_000_000;

  address[] public _majorDelegates;

  enum ProposalState {
    Pending,
    Active,
    Canceled,
    Defeated,
    Succeeded,
    Queued,
    Expired,
    Executed
  }

  enum VoteType {
    Against,
    For,
    Abstain
  }

  constructor() {
    _majorDelegates = new address[](18);
    _majorDelegates[0] = 0x9AA835Bc7b8cE13B9B0C9764A52FbF71AC62cCF1; // a16z
    _majorDelegates[1] = 0x7E959eAB54932f5cFd10239160a7fd6474171318;
    _majorDelegates[2] = 0x8169522c2C57883E8EF80C498aAB7820dA539806; // Geoffrey Hayes
    _majorDelegates[3] = 0x683a4F9915D6216f73d6Df50151725036bD26C02; // Gauntlet
    _majorDelegates[4] = 0x8d07D225a769b7Af3A923481E1FdF49180e6A265; // MonetSupply
    _majorDelegates[5] = 0x2210dc066aacB03C9676C4F1b36084Af14cCd02E; // bryancolligan
    _majorDelegates[6] = 0xB933AEe47C438f22DE0747D57fc239FE37878Dd1; // Wintermute Governance
    _majorDelegates[7] = 0x13BDaE8c5F0fC40231F0E6A4ad70196F59138548; // Michigan Blockchain
    _majorDelegates[8] = 0x070341aA5Ed571f0FB2c4a5641409B1A46b4961b; // Franklin DAO
    _majorDelegates[9] = 0x66cD62c6F8A4BB0Cd8720488BCBd1A6221B765F9; // allthecolors
  }
}
