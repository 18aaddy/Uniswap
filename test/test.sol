// SPDX-License-Identifier: MIT

import {Exchange} from "../src/exchange.sol";
import {Token} from "../src/erc20.sol";
import {console2} from "forge-std/console2.sol";
import {Deployer} from "../script/deploy.s.sol";
import {Test} from "forge-std/Test.sol";

pragma solidity ^0.8.26;

contract Tester is Test {
    Deployer deployer;
    Exchange exchange;
    Token token;

    function setUp() public {
        deployer = new Deployer();
        deployer.run();

        exchange = deployer.exchange();
        token = deployer.token();
    }

    function testAddLiquidity() public {
        addLiquidity(0.01 ether, 0);

        assertEq(exchange.getReserve(), 0.01 ether);
    }

    function testGetTokenAmount() public {
        addLiquidity(0.01 ether, 1 ether);

        uint256 tokensOut = exchange.getTokenAmount(1 gwei);
        assertEq(tokensOut, 9999999);
    }

    function testGetEthAmount() public {
        addLiquidity(0.01 ether, 1 ether);

        uint256 ethOut = exchange.getEthAmount(1 gwei);
        assertEq(ethOut, 99999990000);
    }

    function addLiquidity(uint256 _tokenAmount, uint256 _ethAmount) private {
        vm.startPrank(address(deployer));
        token.approve(address(exchange), _tokenAmount);

        exchange.addLiquidity(_tokenAmount);

        vm.deal(address(exchange), _ethAmount);

        vm.stopPrank();
    }
}