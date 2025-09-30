// SPDX-License-Identifier: Apache-2.0
pragma solidity 0.8.16;

import {TimelockControllerUpgradeable} from
    "@openzeppelin/contracts-upgradeable/governance/TimelockControllerUpgradeable.sol";
import {ProxyAdmin} from "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import {TransparentUpgradeableProxy} from
    "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";
import {ProxyUpgradeAction} from "./ProxyUpgradeAction.sol";

/// @title MultiProxyUpgradeAction
/// @notice A contract to proxy upgrade the Core and Treasury Governor contracts.
/// @custom:security-contact https://immunefi.com/bug-bounty/arbitrum/information/
contract MultiProxyUpgradeAction is ProxyUpgradeAction {
    /// @notice The address of the Proxy Admin contract.
    address public immutable PROXY_ADMIN;
    /// @notice The address of the current Core Governor contract.
    address public immutable CURRENT_CORE_GOVERNOR;
    /// @notice The address of the new Core Governor contract.
    address public immutable NEW_CORE_GOVERNOR_IMPLEMENTATION;
    /// @notice The address of the current Treasury Governor contract.
    address public immutable CURRENT_TREASURY_GOVERNOR;
    /// @notice The address of the new Treasury Governor contract.
    address public immutable NEW_TREASURY_GOVERNOR_IMPLEMENTATION;

    /// @notice Sets up the contract with the given parameters.
    /// @param _proxyAdmin The address of the Proxy Admin contract.
    /// @param _currentCoreGovernor The address of the current Core Governor contract.
    /// @param _newCoreGovernor The address of the new Core Governor contract.
    /// @param _currentTreasuryGovernor The address of the current Treasury Governor contract.
    /// @param _newTreasuryGovernor The address of the new Treasury Governor contract.
    constructor(
        address _proxyAdmin,
        address _currentCoreGovernor,
        address _newCoreGovernor,
        address _currentTreasuryGovernor,
        address _newTreasuryGovernor
    ) {
        if (
            _proxyAdmin == address(0) || _currentCoreGovernor == address(0)
                || _newCoreGovernor == address(0) || _currentTreasuryGovernor == address(0)
                || _newTreasuryGovernor == address(0)
        ) {
            revert("MultiProxyUpgradeAction: zero address");
        }
        PROXY_ADMIN = _proxyAdmin;
        CURRENT_CORE_GOVERNOR = _currentCoreGovernor;
        NEW_CORE_GOVERNOR_IMPLEMENTATION = _newCoreGovernor;
        CURRENT_TREASURY_GOVERNOR = _currentTreasuryGovernor;
        NEW_TREASURY_GOVERNOR_IMPLEMENTATION = _newTreasuryGovernor;
    }

    // @notice Proxy upgrades the Core and Treasury Governor contracts.
    function perform() external {
        perform(PROXY_ADMIN, payable(CURRENT_CORE_GOVERNOR), NEW_CORE_GOVERNOR_IMPLEMENTATION);
        perform(
            PROXY_ADMIN, payable(CURRENT_TREASURY_GOVERNOR), NEW_TREASURY_GOVERNOR_IMPLEMENTATION
        );
        require(
            ProxyAdmin(payable(PROXY_ADMIN)).getProxyImplementation(
                TransparentUpgradeableProxy(payable(CURRENT_CORE_GOVERNOR))
            ) == NEW_CORE_GOVERNOR_IMPLEMENTATION,
            "MultiProxyUpgradeAction: Core Governor not upgraded"
        );
        require(
            ProxyAdmin(payable(PROXY_ADMIN)).getProxyImplementation(
                TransparentUpgradeableProxy(payable(CURRENT_TREASURY_GOVERNOR))
            ) == NEW_TREASURY_GOVERNOR_IMPLEMENTATION,
            "MultiProxyUpgradeAction: Treasury Governor not upgraded"
        );
    }
}
