// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// We keep these imports and a dummy contract just to we can run the test suite after transpilation.

import {Address} from "@openzeppelin-v5/contracts/utils/Address.sol";
import {Arrays} from "@openzeppelin-v5/contracts/utils/Arrays.sol";
import {AuthorityUtils} from "@openzeppelin-v5/contracts/access/manager/AuthorityUtils.sol";
import {Base64} from "@openzeppelin-v5/contracts/utils/Base64.sol";
import {BitMaps} from "@openzeppelin-v5/contracts/utils/structs/BitMaps.sol";
import {Checkpoints} from "@openzeppelin-v5/contracts/utils/structs/Checkpoints.sol";
import {CircularBuffer} from "@openzeppelin-v5/contracts/utils/structs/CircularBuffer.sol";
import {Clones} from "@openzeppelin-v5/contracts/proxy/Clones.sol";
import {Create2} from "@openzeppelin-v5/contracts/utils/Create2.sol";
import {DoubleEndedQueue} from "@openzeppelin-v5/contracts/utils/structs/DoubleEndedQueue.sol";
import {ECDSA} from "@openzeppelin-v5/contracts/utils/cryptography/ECDSA.sol";
import {EnumerableMap} from "@openzeppelin-v5/contracts/utils/structs/EnumerableMap.sol";
import {EnumerableSet} from "@openzeppelin-v5/contracts/utils/structs/EnumerableSet.sol";
import {ERC1155HolderUpgradeable} from "../token/ERC1155/utils/ERC1155HolderUpgradeable.sol";
import {ERC165Upgradeable} from "../utils/introspection/ERC165Upgradeable.sol";
import {ERC165Checker} from "@openzeppelin-v5/contracts/utils/introspection/ERC165Checker.sol";
import {ERC1967Utils} from "@openzeppelin-v5/contracts/proxy/ERC1967/ERC1967Utils.sol";
import {ERC721HolderUpgradeable} from "../token/ERC721/utils/ERC721HolderUpgradeable.sol";
import {Math} from "@openzeppelin-v5/contracts/utils/math/Math.sol";
import {MerkleProof} from "@openzeppelin-v5/contracts/utils/cryptography/MerkleProof.sol";
import {MessageHashUtils} from "@openzeppelin-v5/contracts/utils/cryptography/MessageHashUtils.sol";
import {Panic} from "@openzeppelin-v5/contracts/utils/Panic.sol";
import {Packing} from "@openzeppelin-v5/contracts/utils/Packing.sol";
import {SafeCast} from "@openzeppelin-v5/contracts/utils/math/SafeCast.sol";
import {SafeERC20} from "@openzeppelin-v5/contracts/token/ERC20/utils/SafeERC20.sol";
import {ShortStrings} from "@openzeppelin-v5/contracts/utils/ShortStrings.sol";
import {SignatureChecker} from "@openzeppelin-v5/contracts/utils/cryptography/SignatureChecker.sol";
import {SignedMath} from "@openzeppelin-v5/contracts/utils/math/SignedMath.sol";
import {StorageSlot} from "@openzeppelin-v5/contracts/utils/StorageSlot.sol";
import {Strings} from "@openzeppelin-v5/contracts/utils/Strings.sol";
import {Time} from "@openzeppelin-v5/contracts/utils/types/Time.sol";
import {Initializable} from "../proxy/utils/Initializable.sol";

contract Dummy1234Upgradeable is Initializable {    function __Dummy1234_init() internal onlyInitializing {
    }

    function __Dummy1234_init_unchained() internal onlyInitializing {
    }
}
