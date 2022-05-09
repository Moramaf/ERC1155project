
import { ethers } from "hardhat";
import { tokenUri } from "../config";


async function main() {

  const Token = await ethers.getContractFactory("NFT1155token");
  const token = await Token.deploy(tokenUri);


  await token.deployed();

  console.log("Token deployed to:", token.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
