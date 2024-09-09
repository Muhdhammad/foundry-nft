# Getting Started 🚀

## About 
This project focuses on developing two distinct types of NFTs
1. IPFS Hosted NFT
2. SVG NFT (hosted 100% on-chain)

Here are the simple NFTs used for the projects.


<div style="display: flex; align-items: center; gap: 10px;">
  <img src="img/mylo.png" width="200" height="200" alt="Basic NFT">
  <img src="img/happymood.png" width="150" height="150" alt="Happy Mood">
  <img src="img/sadmood.png" width="150" height="150" alt="Sad Mood">
</div>

---

## Quickstart
```
git clone https://github.com/Muhdhammad/foundry-nft.git
cd foundry-nft
forge install
forge build
```

## Requirements
[git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git): 
Ensure Git is installed. Verify by running ```git --version```. If you see something like ```git version x.x.x```, you're all set.


[foundry](https://getfoundry.sh/):
Ensure Foundry is installed. Check with ```forge --version```. If you see a version string like ```forge 0.2.0 (f2518c9 2024-08-06T00:18:13.943817879Z)```, you're good to go.

## Usage
### Spin Up a Local Node
Start your local blockchain node to deploy contracts:
```
make anvil
```

### Deploy
With your local node up and running, deploy your contracts with:
```
make deploy
```

### Deployment to testnet or mainnet
1. Setup Environment Variables 

You'll need to configure your environment with `$SEPOLIA_RPC_URL` and `PRIVATE_KEY` in a `.env` file:

- `$PRIVATE_KEY`: Your account's private key (e.g., from [Metamask](https://metamask.io/)). **SERIOUS NOTE:** For development, use a key without real funds.

- `$SEPOLIA_RPC_URL`: URL of the Sepolia testnet node you're using. You can get this from any free service provider like [Alchemy](https://www.alchemy.com/).

- **Optionally:** Add `ETHERSCAN_API_KEY` if you want to verify your contract on [Etherscan](https://etherscan.io/).

2. Get testnet ETH 
 
Go to [faucets.chain.link](https://faucets.chain.link/) or any other faucet to get testnet ETH, you should see ETH appear in you wallet.

3. Deploy IPFS NFT

```
make deploy ARGS="--network sepolia"
```

4. Deploy SVG NFT
```
make deployMood ARGS="--network sepolia"
```


### Testing

This project consists of three basic testings to ensure its functionality.
1. Unit 
2. Integration
3. Forked

```
forge test
```
You can also,
```
// Only run test functions matching the specified regex pattern.

forge test --match-test testFunctionName
```

or
```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage
```
forge coverage
```
## Base-64
To get base64 of an image, run
```
echo "data:image/svg+xml;base64,$(base64 -i ./img/happymood.svg)"
```
## Gas Estimation
You can estimate how much gas different things cost by running
```
forge snapshot
```
You'll see any output file called `.gas-snapshot`

## Formatting
To format your code
```
forge fmt
```

## Additional Note ⚠️

Best practice to use your `$PRIVATE_KEY` is to encode it and then use it, you should never hard copy paste your private key with the real funds in the `.env` file.

## Thanks 🙌
Thank you for staying engaged with this project, if you appreciated this, feel free to follow!


