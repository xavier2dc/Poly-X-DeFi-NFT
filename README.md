# `Poly-X-DeFi-NFT`

This repository contains the Solidity smart contracts that implement the ERC721 non-fungible token (NFT) called `Poly-X-DeFi-NFT` (published [on Ethereum](https://etherscan.io/token/0x6b0770ef27310057dc3269b67f8c725e7661518d)). It is simply based on [OpenZeppelin's implementation](https://wizard.openzeppelin.com/#erc721) of an ERC721 token that is mintable with auto-increment IDs, enumerable, with URI storage, and ownable.

The initial series of 10+1 NFTs were minted during the during the Winter 2023 term of the Decentralized Finance (COMP5568) course at the Hong Kong Polytechnic University. You can view them on OpenSea [here](https://opensea.io/collection/poly-x-defi-nft).

Minting NFTs for each lecture was a successful way to engage students and demonstrate how NFTs work.

The NFTs' `tokenURI` points to JSON metadata files stored on IPFS, which in turn point to an `image` file on IPFS. You can find these files in the `tokens` and `art` folders.

At the end of the term, 10 NFTs were randomly distributed to students using the contract included in this repository. You can view the transaction details [here](https://etherscan.io/tx/0xb27d9fbbc826976c34fed0294e1f304abe04e0af42458e2be415ed5a0f75d2a8).

## Create NFT contract and mint NFTs
- Edit `Poly-X-DeFi.sol` under `contracts` to match your desired NFT parameters. Refer to the ERC721 constructor that takes the name and symbol of the NFT.
- Deploy the contract on Ethereum, e.g., using [Remix](https://remix.ethereum.org/).
- Upload the image for the first NFT to IPFS, note down the CID.
- Create a metadata file to represent the NFT (refer to the files in the `tokens` folder). Make sure that the `tokenId`matches the expected token ID for the next NFT in the deployed contract, as the ID is auto-incremented. Adjust the `image` value to `ipfs://` followed by the CID of your image.
- Upload the metadata file to IPFS, note down the CID.
- Call `safeMint(address to, string memory uri)` by passing your address as `to` and the `ipfs://` followed by the CID of the metadata file as `uri`.
- Go to [OpenSea](https://opensea.io/) and search for the address of your NFT contract to see the new NFT.

## Randomly distribute NFTs
- Edit `seal-seed.py` and adjust the owner variable to the address that will be used to create the giveaway contract, and adjust the seed variable to a 32-byte secret.
- Run `seal-seed.py` to obtain the sealed seed as `keccak256(address+seed)`.
- Deploy `PolyXNFTGiveAwayW2023.sol` on Ethereum with the previously sealed seed as `_sealedSeed` and the address of the NFT contract as `_pxdContract`. Use the same address to create the contract as the one that created the NFT contract.
- Wait for the contract creation transaction to be included in a block (i.e., at least 1 confirmation).
- Call `setApprovalForAll(address operator, bool approved)` with the address of the NFT contract as `operator` and `true` as `approved` to let the giveaway contract transfer the tokens on your behalf.
- Call `giveAway(bytes32 _seed, address[] memory recipients)` by passing the seed as `_seed` and an array of addresses as `recipients`, which will possibly receive an NFT. All NFTs owned by the owner of this giveaway contract will be transferred to the recipients.

The contract shuffles the list of recipients using randomness coming from the hash of the block that included the contract creation transaction, and the seed. This way, the owner of the contract has no control over the randomness that will be used to distribute the tokens at the time the seed is committed. The miner/validator that generates the block also cannot predict the resulting randomness due to the secret seed. Overall, this mechanism allows for reasonably good entropy while also prohibiting unfair advantages.

Note that if the list of recipient is longer than the list of NFTs, recipients may receive more than one NFT. Conversely, if there are more NFTs than recipients, some recipients will not receive an NFT.