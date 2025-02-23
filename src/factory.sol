// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Exchange} from "./exchange.sol";

contract Factory {
    mapping(address tokenAddress => address exchangeAddress)
        public tokenToExchangeAddress;

    function createExchange(address _tokenAddress) public returns (address) {
        require(_tokenAddress != address(0), "invalid token address");
        require(
            tokenToExchangeAddress[_tokenAddress] == address(0),
            "exchange already exists"
        );

        Exchange exchange = new Exchange(_tokenAddress);
        tokenToExchangeAddress[_tokenAddress] = address(exchange);

        return address(exchange);
    }

    function getExchange(address _tokenAddress) public view returns (address) {
        return tokenToExchangeAddress[_tokenAddress];
    }
}

interface IFactory {
    function getExchange(address _tokenAddress) external returns (address);
  }
  