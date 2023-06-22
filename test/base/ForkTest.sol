// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract ForkTest is Test {
    uint256 public forkBlockNumber;
    uint256 public forkId;

    function setUp() public virtual {
        forkId = vm.createSelectFork(vm.rpcUrl("mainnet_url"), forkBlockNumber);
    }

    // @dev retrieve bytecode at _addr
    function readBytecodeAt(address _addr) public view returns (bytes memory bytecode) {
        assembly {
            // retrieve the size of the code
            let size := extcodesize(_addr)
            // allocate output byte array
            // by using bytecode = new bytes(size)
            bytecode := mload(0x40)
            // new "memory end" including padding
            mstore(0x40, add(bytecode, and(add(add(size, 0x20), 0x1f), not(0x1f))))
            // store length in memory
            mstore(bytecode, size)
            // actually retrieve the code, this needs assembly
            extcodecopy(_addr, add(bytecode, 0x20), 0, size)
        }
    }
}
