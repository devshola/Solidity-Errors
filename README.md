
# PrimeCounter

This simple Solidity voting smart contract counts the number of prime numbers between 1 and a given number. The purpose of this program is to show the error-handling mechanisms of the Solidity programming language which are ```revert, assert, require```

## Description

This program is a simple contract written in Solidity, a programming language for developing smart contracts on the Ethereum blockchain. 
The contract has 2 functions as listed below.

- ```countPrimes```: this function takes in a uint256 argument and returns the number of prime numbers are there between 1 and the given number. 
- ```isPrime```: This function takes in a uint256 number and returns true or false depending on whether the number is a prime number.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., PrimeCounter.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract PrimeCounter {
    
    error InvalidInput(string message);

    uint256[] primeNumbers;

    event Primes(uint256[] primeNumbers);

    function countPrimes(uint256 limit) public returns (uint256) {
        if (limit < 2) revert InvalidInput("Limit must be at least 2");

        uint256 primeCount = 0;
        for (uint256 i = 2; i <= limit; i++) {
            if (isPrime(i)) {
                primeNumbers.push(i);
                primeCount++;
            }
        }

        assert(primeCount >= 0);

        emit Primes(primeNumbers);

        delete primeNumbers;

        return primeCount;
    }

    function isPrime(uint256 number) public pure returns (bool) {
        require(number > 1, "Number must be greater than 1");

        if (number == 2) return true;
        if (number % 2 == 0) return false;

        for (uint256 i = 3; i * i <= number; i += 2) {
            if (number % i == 0) {
                return false;
            }
        }
        return true;
    }
}
```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.17" (or another compatible version), and then click on the "Compile PrimeCounter.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "PrimeCounter" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it the contract.

## Authors

Samuel Shola

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
