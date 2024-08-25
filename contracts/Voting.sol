// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting {

    address immutable owner;
    uint allVoters;
    uint voteCount;

    mapping (address => Voter) public voters;
    mapping (uint => address) indexing;

    event VoteDone(string message, uint voteAmount);

    struct Voter {
        uint index;
        address voter;
        bool hasVoted;
    }

    constructor (address[] memory _voters) {
        owner = msg.sender;

        for (uint i = 0; i < _voters.length; i++) {

            uint _index = i + 1;

            Voter storage _voter = voters[_voters[i]];
            _voter.index = _index;
            _voter.voter = _voters[i];


            indexing[_index] = _voters[i];
        }

        allVoters = _voters.length;
    }

    function vote() external {
        require(!voters[msg.sender].hasVoted, "User already voted!");

        uint pos = checkPosition(msg.sender);

        assert(pos <= allVoters);

        if (pos == 1) {

            Voter storage _voter = voters[msg.sender];
            _voter.hasVoted = true;
            voteCount += 1;

        } else {

            pos = pos - 1;
            
            if (!voters[indexing[pos]].hasVoted) {
                revert("It's not your turn to vote!");
            }

            Voter storage _voter = voters[msg.sender];
            _voter.hasVoted = true;
            voteCount += 1;
            
            if (voteCount == allVoters) {
                emit VoteDone("Voting is completed", voteCount);
            }
        }
    }

    function checkPosition(address _caller) public  view returns(uint)  {
        return voters[_caller].index;
    }
}