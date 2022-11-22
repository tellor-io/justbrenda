// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "usingtellor/contracts/UsingTellor.sol";

contract mycontract is UsingTellor {
// Storage
    bytes queryData = abi.encode("SpotPrice", abi.encode("eth", "usd"));
    bytes32 queryId = keccak256(queryData);
    uint256 public ethPrice;

// Events
    event NewEthPrice(uint _value);

    constructor(address payable _tellorAddress) 
    UsingTellor(_tellorAddress) {}

       function readEthPrice()
        public
        returns (uint256, uint256)
    {
        (bytes memory _value, uint256 _timestampRetrieved) =
            getDataBefore(queryId, block.timestamp - 15 minutes);
        uint256 _val = abi.decode(_value, (uint256));
        if (_timestampRetrieved > 0) {
            ethPrice = _val;
            emit NewEthPrice (_val);
            return (_val, _timestampRetrieved);
        } else {
            return (0, 0);  
        }
    }

}