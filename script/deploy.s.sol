// SPDX-License-Identifier: MIT

import {Exchange} from "../src/exchange.sol";
import {Token} from "../src/erc20.sol";
import {console2} from "lib/forge-std/src/console2.sol";

pragma solidity ^0.8.26;

contract Deployer {
    Exchange public exchange;
    Token public token;

    address tokenAddress;

    string name = "token1";
    string symbol = "TKN1";
    uint256 initialSupply = 10000 ether;
    
    function run() public {
        Token _token = new Token(name, symbol, initialSupply);
        token = _token;

        tokenAddress = address(token);
        console2.log("Token Address: ", tokenAddress);

        Exchange _exchange = new Exchange(tokenAddress);
        exchange = _exchange;
        console2.log("Exchange Address: ", address(exchange));
    }
}
