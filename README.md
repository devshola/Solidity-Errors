
# Voting

This is a simple Solidity voting smart contract that allows voters to maintain a queue to vote. A voter on the second line cannot vote before the voter on the first line. The purpose of this program is to show the error-handling mechanisms of the Solidity programming language which are ```revert, assert, require```

## Description

This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. 
The contract has 3 functions as listed below.

- vote: allows the voters that has been added at the constructor level to vote. If voted before, you cannot vote again and you cannot vote before the voter before you.
- voters: This function allows for a voter to be searched for. 
- indexing: finds the address of a voter by it's position.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., Voting.sol). Copy and paste the following code into the file:

```javascript
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
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.17" (or another compatible version), and then click on the "Compile Voting.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Voting" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it the contract.

## Authors

Samuel Shola

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
