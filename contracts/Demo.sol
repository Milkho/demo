pragma solidity ^0.4.24;

import "./usingOraclize.sol";

contract Demo is usingOraclize {
    
    // indicator constant
    uint256 public constant INDICATOR_SUCCESS = 1;
    
    // oraclize orders
    mapping(bytes32 => address) public orders;

    // current gaslimit value
    uint256 public oraclizeGasLimit = 200000;

    // data source
    bytes public dataSource = "json(https://api.coinmarketcap.com/v1/ticker/ethereum/).0.price_usd";

    // revenue amount
    uint256 public constant REVENUE = 1 ether;

     /**
     * @dev Event for order logging
     * @param beneficiary beneficiary who want to obtain funds
     * @param orderId oraclize orderId
     */
    event OrderEvent(address indexed beneficiary, bytes32 indexed orderId);

    /**
     * @dev Event for revenue logging
     * @param beneficiary beneficiary who obtain funds
     * @param orderId oraclize orderId
     */
    event RevenueEvent(address indexed beneficiary, bytes32 indexed orderId);

    constructor(){
        OAR = OraclizeAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);
    }

    /**
     * @dev Make oraclize order with given params
     */
    function makeCall(uint256 _param1, bytes _param2, bytes _param3) external {
        
        address _beneficiary = msg.sender;

        string memory _par1 = uint2str(_param1);
        string memory _par2 = string(_param2);
        string memory _par3 = string(_param3);

        // // string memory _query = srtConcat(dataSource, "/",  _par1, _par2, _par3);
        string memory _query = "https://www.random.org/integers/?num=1&min=1&max=1&col=1&base=10&format=plain&rnd=new";
        bytes32 _orderId = oraclize_query("URL", _query, oraclizeGasLimit);

        orders[_orderId] = _beneficiary;
        emit OrderEvent(_beneficiary, _orderId);
    }

    /**
     * @dev Get responce from oraclize
     * @param _orderId oraclize order id
     * @param _result oraclize result
     */
    function __callback(bytes32 _orderId, string _result) public {  // solium-disable-line mixedcase
        uint256 _indicator = parseInt(_result);

        if (_indicator == INDICATOR_SUCCESS) {
            address _beneficiary = orders[_orderId];
            _beneficiary.transfer(REVENUE);

            emit RevenueEvent(_beneficiary, _orderId);
        }

    }

    /**
     * @dev Set oraclize gas limit value
     * @param _newGasLimit new value for gas limit
     */
    function setGasLimit(uint256 _newGasLimit) external {
        oraclizeGasLimit = _newGasLimit;
    }

    
}
