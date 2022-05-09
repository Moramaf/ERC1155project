import { HardhatUserConfig, task } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
import { tokenAddress } from "../config";


task("mint", "mint a new NFT tokens")
.addOptionalParam("addressTo", "address to own new NFT")
.addOptionalParam("ids", "Ids of NFT tokens")
.addOptionalParam("amounts", "Amounts of NFT tokens")
.addOptionalParam("data", "Aditional bytes data")
.setAction(async (taskArgs, hre) => {
    const token = await hre.ethers.getContractAt("NFT1155token", tokenAddress);
    const tx = await token.mintBatch(taskArgs.addressTo, taskArgs.ids, taskArgs.amounts,taskArgs.data);
    await tx.wait();
    console.log(`${taskArgs.addressTo} get new NFT`);
});