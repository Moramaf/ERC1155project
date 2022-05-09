import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import { tokenAddress } from "../config";


// task("mint", "mint a new NFT tokens")
// .addOptionalParam("addressTo", "address to own new NFT")
// .addOptionalParam("id", "Id of NFT token")
// .addOptionalParam("amount", "Amount of NFT tokens")
// .addOptionalParam("data", "Aditional bytes data")
// .setAction(async (taskArgs, hre) => {
//     const token = await hre.ethers.getContractAt("NFT1155token", tokenAddress);
//     const tx = await token.mint(taskArgs.addressTo, taskArgs.id, taskArgs.amount,taskArgs.data);
//     await tx.wait();
//     console.log(`${taskArgs.addressTo} get new NFT`);
// });