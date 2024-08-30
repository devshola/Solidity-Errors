import { ethers } from "hardhat";

async function main() {

  const PrimeCounter = await ethers.deployContract("PrimeCounter");

  await PrimeCounter.waitForDeployment();

  console.log(
    `PrimeCounter contract deployed to ${PrimeCounter.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
