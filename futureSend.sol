pragma solidity ^0.4.18;
contract futureSend {
    mapping (address => uint256) public amount;
    mapping (address => uint256) public lockUntil;
    
    function send(address _to, uint256 _lockSeconds) public payable {
        if(amount[_to] != 0) { revert(); }
        amount[_to] = msg.value;
        lockUntil[_to] = block.timestamp + _lockSeconds;
    }
    
    function withdraw() public {
        if(amount[msg.sender] == 0) { revert(); }
        if(lockUntil[msg.sender] >= block.timestamp) { revert(); }
        var amountToSend = amount[msg.sender];
        amount[msg.sender] = 0;
        msg.sender.transfer(amountToSend);
    }
}
