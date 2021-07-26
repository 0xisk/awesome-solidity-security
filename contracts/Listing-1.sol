pragma solidity ^0.4.25;


/**
 * @dev Listing 1: A “Gamble” smart contract. However, this contract
 * contains several contract defects.
 */
contract Gamble {
    address owner;
    address[] members;
    address[] participators;
    uint participatorID = 0;

    modifier onlyOwner {
        require(tx.origin == owner);
    }

    constructor () {
        owner = 0x5217A4c4af2BaDC36251D21F5e294aa1F66032F4;
    }

    function() payable {
        ReceiveEth();
    }

    function ReceiveEth() payable {
        if (msg.value != 1 ether) {
            revert();
        } 
        members.push(msg.sender);
        participators[participatorID] = msg.sender;
        participatorID++;
        if (this.balance == 10 ether) {
            getWinner();
        }
    }
 
    // Choose a member to be the winner
    function getWinner() {
        /**
        * Block Info Dependency
        */
        uint winnerID = uint(block.blockhash(block.number)) % participants.length;
        participants[winnerID].send(8 ether);
        participatorID = 0;
    }

    function giveBonus() returns (bool) {
        for (uint256 i = 0; i < members.length; i++) {
            if (this.balance > 0.1 ether) {
                members[i].transfer(0.1 ether);
            }
        }
    }

    function suicide(address addr) onlyOwner {
        selfdestruct(addr);
    }

    function withDraw(uint amount) onlyOwner {
        address receiver = 0x5217A4c4af2BaDC36251D21F5e294aa1F66032F4;
        receiver.call.value(amount);
    }
}