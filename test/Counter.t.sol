// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {Counter} from "src/Counter.sol";
import {CounterHarness} from "test/harnesses/CounterHarness.sol";

import {ForkTest} from "test/base/ForkTest.sol";

contract CounterTest is ForkTest {
    Counter counter;

    function setUp() public override {
        forkBlockNumber = 17533982;
        super.setUp();

        // use mainnet address for contract you want to debug
        counter = new Counter();

        vm.etch(address(counter), readBytecodeAt(address(new CounterHarness())));
    }

    function testCounter() public {
        // This wil log number after incremented to console
        counter.increment();
        counter.increment();
        counter.increment();
        counter.increment();
    }
}
