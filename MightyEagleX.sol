// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MightyEagleX {
    string public name = "MightyEagleX";       // Name of the token
    string public symbol = "MTEX";              // Symbol of the token
    uint8 public decimals = 18;                  // Number of decimal places
    uint256 public totalSupply;                  // Total supply of the token

    mapping(address => uint256) public balanceOf;                           // Balance mapping
    mapping(address => mapping(address => uint256)) public allowance;      // Allowance mapping

    event Transfer(address indexed from, address indexed to, uint256 value);     // Transfer event
    event Approval(address indexed owner, address indexed spender, uint256 value); // Approval event

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * 10 ** uint256(decimals); // Set total supply with decimals
        balanceOf[msg.sender] = totalSupply; // Assign all tokens to the contract creator
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address"); // Ensure the recipient address is valid
        require(balanceOf[msg.sender] >= _value, "Insufficient balance"); // Ensure sender has enough balance

        balanceOf[msg.sender] -= _value; // Subtract from sender
        balanceOf[_to] += _value; // Add to recipient
        emit Transfer(msg.sender, _to, _value); // Emit transfer event
        return true; // Indicate success
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value; // Set allowance for spender
        emit Approval(msg.sender, _spender, _value); // Emit approval event
        return true; // Indicate success
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Invalid address"); // Ensure the recipient address is valid
        require(balanceOf[_from] >= _value, "Insufficient balance"); // Ensure sender has enough balance
        require(allowance[_from][msg.sender] >= _value, "Allowance exceeded"); // Ensure allowance is sufficient

        balanceOf[_from] -= _value; // Subtract from sender
        balanceOf[_to] += _value; // Add to recipient
        allowance[_from][msg.sender] -= _value; // Reduce the allowance
        emit Transfer(_from, _to, _value); // Emit transfer event
        return true; // Indicate success
    }

    function increaseAllowance(address _spender, uint256 _addedValue) public returns (bool success) {
        allowance[msg.sender][_spender] += _addedValue; // Increase the allowance
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]); // Emit approval event
        return true; // Indicate success
    }

    function decreaseAllowance(address _spender, uint256 _subtractedValue) public returns (bool success) {
        require(allowance[msg.sender][_spender] >= _subtractedValue, "Decreased allowance below zero"); // Ensure allowance is not negative
        allowance[msg.sender][_spender] -= _subtractedValue; // Decrease the allowance
        emit Approval(msg.sender, _spender, allowance[msg.sender][_spender]); // Emit approval event
        return true; // Indicate success
    }
}
