
// File: @openzeppelin/contracts/utils/introspection/IERC165.sol


// OpenZeppelin Contracts v4.4.1 (utils/introspection/IERC165.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC165 standard, as defined in the
 * https://eips.ethereum.org/EIPS/eip-165[EIP].
 *
 * Implementers can declare support of contract interfaces, which can then be
 * queried by others ({ERC165Checker}).
 *
 * For an implementation, see {ERC165}.
 */
interface IERC165 {
    /**
     * @dev Returns true if this contract implements the interface defined by
     * `interfaceId`. See the corresponding
     * https://eips.ethereum.org/EIPS/eip-165#how-interfaces-are-identified[EIP section]
     * to learn more about how these ids are created.
     *
     * This function call must use less than 30 000 gas.
     */
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

// File: @openzeppelin/contracts/token/ERC721/IERC721.sol


// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC721/IERC721.sol)

pragma solidity ^0.8.0;


/**
 * @dev Required interface of an ERC721 compliant contract.
 */
interface IERC721 is IERC165 {
    /**
     * @dev Emitted when `tokenId` token is transferred from `from` to `to`.
     */
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables `approved` to manage the `tokenId` token.
     */
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);

    /**
     * @dev Emitted when `owner` enables or disables (`approved`) `operator` to manage all of its assets.
     */
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    /**
     * @dev Returns the number of tokens in ``owner``'s account.
     */
    function balanceOf(address owner) external view returns (uint256 balance);

    /**
     * @dev Returns the owner of the `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function ownerOf(uint256 tokenId) external view returns (address owner);

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes calldata data
    ) external;

    /**
     * @dev Safely transfers `tokenId` token from `from` to `to`, checking first that contract recipients
     * are aware of the ERC721 protocol to prevent tokens from being forever locked.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must exist and be owned by `from`.
     * - If the caller is not `from`, it must have been allowed to move this token by either {approve} or {setApprovalForAll}.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Transfers `tokenId` token from `from` to `to`.
     *
     * WARNING: Note that the caller is responsible to confirm that the recipient is capable of receiving ERC721
     * or else they may be permanently lost. Usage of {safeTransferFrom} prevents loss, though the caller must
     * understand this adds an external call which potentially creates a reentrancy vulnerability.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     * - If the caller is not `from`, it must be approved to move this token by either {approve} or {setApprovalForAll}.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;

    /**
     * @dev Gives permission to `to` to transfer `tokenId` token to another account.
     * The approval is cleared when the token is transferred.
     *
     * Only a single account can be approved at a time, so approving the zero address clears previous approvals.
     *
     * Requirements:
     *
     * - The caller must own the token or be an approved operator.
     * - `tokenId` must exist.
     *
     * Emits an {Approval} event.
     */
    function approve(address to, uint256 tokenId) external;

    /**
     * @dev Approve or remove `operator` as an operator for the caller.
     * Operators can call {transferFrom} or {safeTransferFrom} for any token owned by the caller.
     *
     * Requirements:
     *
     * - The `operator` cannot be the caller.
     *
     * Emits an {ApprovalForAll} event.
     */
    function setApprovalForAll(address operator, bool _approved) external;

    /**
     * @dev Returns the account approved for `tokenId` token.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function getApproved(uint256 tokenId) external view returns (address operator);

    /**
     * @dev Returns if the `operator` is allowed to manage all of the assets of `owner`.
     *
     * See {setApprovalForAll}
     */
    function isApprovedForAll(address owner, address operator) external view returns (bool);
}

// File: @openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol


// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC721/extensions/IERC721Enumerable.sol)

pragma solidity ^0.8.0;


/**
 * @title ERC-721 Non-Fungible Token Standard, optional enumeration extension
 * @dev See https://eips.ethereum.org/EIPS/eip-721
 */
interface IERC721Enumerable is IERC721 {
    /**
     * @dev Returns the total amount of tokens stored by the contract.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns a token ID owned by `owner` at a given `index` of its token list.
     * Use along with {balanceOf} to enumerate all of ``owner``'s tokens.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256);

    /**
     * @dev Returns a token ID at a given `index` of all the tokens stored by the contract.
     * Use along with {totalSupply} to enumerate all tokens.
     */
    function tokenByIndex(uint256 index) external view returns (uint256);
}

// File: PolyXNFTGiveAwayW2023.sol


pragma solidity ^0.8.0;



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