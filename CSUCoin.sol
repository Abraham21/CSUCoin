pragma solidity ^0.4.11;

import './IERC20.sol';

contract CSUCoin is IERC20 {
    
    uint public constant _totalSupply=10000000;
    
    string public constant symbol="CSUC";
    string public constant name = "CSUCoin";
    uint8 public constant decimals = 3;

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    
    
    function CSUCoin() {
        balances[msg.sender] = _totalSupply;
    }
    
    function totalSupply() constant returns (uint256 total){
        return _totalSupply;
        
    }
    
    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
        
    }
    
    function transfer(address _to, uint256 _value) returns (bool success) {
        require(
            balances[msg.sender] >=_value
            &&_value>0
            );
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender,_to,_value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        require(
            allowed[_from][msg.sender] >= _value
            && balances[_from] >= _value
            && _value > 0
            );
            balances[_from] -= _value;
            balances[_to] += _value;
            allowed[_from][msg.sender] -= _value;
            Transfer(_from, _to, _value);
            return true;
    }
    
    function approve(address _spender, uint256 _value) returns (bool success){
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function allowance(address _owner, address _spender) constant returns(uint256 remaining){
        return allowed[_owner][_spender];
    }
    
    event Transfer(address indexed_from, address indexed_to, uint256 _value);
    event Approval(address indexed_owner, address indexed_spender,uint _value);
    
    
    }
