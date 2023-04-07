// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";

contract PolyXNFTGiveAwayW2023 {
bytes32 public sealedSeed;
uint public storedBlockNumber;
    bytes32 private seed;
    address public owner;
    address public pxdContract;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor(bytes32 _sealedSeed, address _pxdContract) {
        owner = msg.sender;
        // Save the sealed seed s.t. keccak256(msg.sender, seed) == sealed seed
        sealedSeed = _sealedSeed;
        // Save the block number in which the seed was sealed
        storedBlockNumber = block.number;
        // Save PXD NFT contract address
        pxdContract = _pxdContract;
    }

    function giveAway(bytes32 _seed, address[] memory recipients) public onlyOwner {
        require(recipients.length > 0, "At least one recipient required");
        require(storedBlockNumber < block.number); // Ensure that the block number has advanced since the seed was sealed
        require(keccak256(abi.encodePacked(msg.sender, _seed)) == sealedSeed); // Verify that the provided seed matches the sealed seed
        
        // Combine revealed seed with the stored block number as new seed
        seed = keccak256(abi.encodePacked(_seed, blockhash(storedBlockNumber)));

        // Shuffle the list of recipients
        for (uint i = 0; i < recipients.length; i++) {
            // Note: biased random output due to the modulo, but we will do with it
            uint j = i + uint(_getRandom(i)) % (recipients.length - i);
            (recipients[i], recipients[j]) = (recipients[j], recipients[i]);
        }

        // Get the list of NFT tokens owned by the contract owner
        IERC721Enumerable nft = IERC721Enumerable(pxdContract);
        uint[] memory tokenIds = tokensOf(msg.sender, nft);

        // Transfer each NFT token to a recipient in the shuffled list
        // Only the first tokenIds.length recipients will get one
        uint recipientIndex = 0;
        for (uint i = 0; i < tokenIds.length; i++) {
            uint tokenId = tokenIds[i];
            nft.safeTransferFrom(msg.sender, recipients[recipientIndex], tokenId);
            // if there are fewer recipients than NFTs, loop over
            recipientIndex = (recipientIndex + 1) % recipients.length;
        }

        // Self-destruct the contract to prevent further NFTs from being transferred by calling this contract again
        destroy();
    }

    // Private function to generate a random number based on the sealed seed and the block hash
    function _getRandom(uint256 i) private view returns (bytes32) {
        return keccak256(abi.encodePacked(seed, i));
    }

    // Internal function that returns an array of the NFT tokens owned by a particular address
    function tokensOf(address nftOwner, IERC721Enumerable nftContract) internal view returns (uint[] memory) {
        uint256 tokenCount = nftContract.balanceOf(nftOwner);
        uint[] memory result = new uint[](tokenCount);
        for (uint i = 0; i < tokenCount; i++) {
            result[i] = nftContract.tokenOfOwnerByIndex(nftOwner, i);
        }
        return result;
    }

    function destroy() public onlyOwner {
        selfdestruct(payable(owner));
    }
}