import { ethers } from "hardhat";

async function main() {

  const pollfactory = await ethers.deployContract("VotingPollFactory");

  await pollfactory.waitForDeployment();

  console.log(
    `Poll Factory contract deployed to ${pollfactory.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
