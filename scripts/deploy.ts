import { ethers } from "hardhat";

async function main() {

  const Voting = await ethers.deployContract("Voting");

  await Voting.waitForDeployment();

  console.log(
    `MetaERC20 contract deployed to ${Voting.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
