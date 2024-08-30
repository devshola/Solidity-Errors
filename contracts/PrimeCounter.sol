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
