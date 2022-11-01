// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol"; 
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";


// initialize the smart contract
contract ChainBattles is ERC721URIStorage {     
    using Strings for uint256;  
    using Counters for Counters.Counter;    
    Counters.Counter private _tokenIds; 
    
    struct Character {
        uint256 level;      // track level
        uint256 health;     // track health
        uint256 strength;   // track strength
        uint256 speed;      // track speed
    }    

// Map to Character struct. tokenIdToLevels keeps track of the NFT level.
mapping(uint256 => Character) public tokenIdToLevels; 

constructor() ERC721 ("Chain Battles", "CBTLS"){

    }


function getCharacter(uint256 tokenId) public returns(string memory){
    // generated with image to svg converter from picsvg.com
    bytes memory svg = abi.encodePacked(
        '<svg version="1.0" xmlns="http://www.w3.org/2000/svg" width="512.000000pt" height="512.000000pt" viewBox="0 0 512.000000 512.000000" preserveAspectRatio="xMidYMid meet">',
        '<style>.character { fill: white; font-family: verdana; font-size: 40px; }</style>',
        '<style>.base { fill: white; font-family: serif; font-size: 20px; }</style>',
        '<g transform="translate(0.000000,512.000000) scale(0.100000,-0.100000)" fill="#000000" stroke="none">',
            '<path d="M0 2560 l0 -2560 519 0 518 0 18 48 c53 145 241 447 398 643 107 133 267 285 338 322 l54 29 -45 -41 c-25 -22 -40 -40 -35 -40 6 -1 44 9 85 20 47 12 138 24 240 30 91 6 210 19 265 30 55 10 118 19 140 20 24 1 1 6 -55 14 -104 14 -173 37 -207 68 -28 25 -29 37 -5 37 9 1 -30 17 -87 36 -216 71 -353 156 -501 311 -102 105 -172 213 -214 331 -28 79 -31 98 -30 207 0 96 4 131 20 175 l21 56 -21 2 c-11 0 -30 6 -41 11 -53 27 -160 69 -167 65 -19 -12 -30 -93 -24 -172 12 -143 93 -385 190 -568 43 -82 20 -64 -39 30 -130 210 -205 468 -205 711 0 132 19 255 66 433 39 149 39 157 -8 261 -74 164 -98 259 -98 393 0 214 61 341 188 389 50 18 72 20 172 16 135 -5 196 -22 379 -107 69 -31 138 -60 153 -64 16 -3 80 4 150 19 286 58 495 53 772 -17 l88 -22 57 21 c31 12 98 40 150 63 237 104 449 98 550 -17 66 -74 101 -191 101 -332 0 -105 -21 -193 -74 -315 -25 -58 -46 -116 -46 -129 0 -13 9 -50 21 -83 66 -190 105 -437 94 -589 -24 -326 -153 -618 -372 -846 -133 -138 -267 -231 -424 -294 l-78 -32 57 -17 c127 -40 189 -82 332 -225 74 -75 169 -182 210 -239 162 -222 297 -462 323 -577 l14 -60 606 -3 607 -2 0 2560 0 2560 -2560 0 -2560 0 0 -2560z"/>', 
            '<path d="M1104 3398 c7 -90 31 -178 73 -268 20 -41 46 -102 58 -135 16 -43 28 -60 41 -60 24 0 68 86 61 117 -4 13 -34 59 -67 103 -33 44 -76 114 -96 155 -19 41 -44 93 -55 115 l-20 40 5 -67z"/>',
            '<path d="M2370 2696 c0 -2 8 -10 18 -17 15 -13 16 -12 3 4 -13 16 -21 21 -21 13z"/>',
            '<path d="M2372 2295 c-77 -17 -142 -52 -161 -86 -12 -22 -12 -31 -2 -57 20 -48 43 -49 134 -3 61 31 101 44 156 50 73 9 91 20 91 52 0 49 -103 70 -218 44z"/>',
            '<path d="M3153 2304 c-30 -7 -45 -28 -41 -60 3 -26 8 -29 71 -40 60 -11 106 -32 170 -77 24 -17 50 1 61 45 11 45 -10 80 -69 108 -42 20 -148 33 -192 24z"/>',
            '<path d="M2812 2150 c-36 -22 -72 -74 -72 -105 0 -11 10 -37 23 -58 58 -95 151 -103 230 -19 42 44 47 99 12 140 -53 63 -130 80 -193 42z m106 -17 c5 -18 -23 -16 -39 3 -11 14 -10 15 11 12 13 -1 25 -9 28 -15z m42 -64 c0 -5 -7 -9 -15 -9 -9 0 -15 9 -15 21 0 18 2 19 15 9 8 -7 15 -16 15 -21z"/>',
            '<path d="M2814 1721 c-18 -11 -35 -25 -39 -31 -13 -21 -98 -70 -122 -70 l-23 0 29 -57 c33 -67 56 -90 99 -103 67 -19 159 37 201 123 l21 42 -33 16 c-17 10 -45 35 -62 58 -16 22 -32 41 -35 41 -3 0 -19 -9 -36 -19z m-2 -113 c6 -11 29 -78 32 -98 1 -3 5 -10 9 -17 9 -15 -52 -34 -85 -26 -48 12 -108 97 -96 135 12 34 119 38 140 6z m131 -39 c-10 -17 -25 -36 -33 -42 -12 -10 -13 -9 -4 3 5 8 18 27 27 43 24 37 32 34 10 -4z"/>',
            '<path d="M1886 645 c-9 -13 -28 -66 -42 -117 -21 -78 -144 -471 -161 -515 -4 -9 6 -13 35 -13 l41 0 11 58 c20 99 40 173 85 312 45 136 72 244 69 268 -1 6 -2 17 -3 22 -2 18 -18 11 -35 -15z"/>',
            '<path d="M3165 575 c2 -27 24 -120 48 -205 45 -154 74 -278 79 -335 2 -24 8 -31 31 -33 15 -2 27 -1 27 2 0 3 -24 74 -53 158 -60 170 -111 337 -126 413 l-10 50 4 -50z"/>',
        '</g>',
        '<rect width="100%" height="100%" opacity="50%" />',
        '<text x="50%" y="40%" class="character" dominant-baseline="middle" text-anchor="middle">',"Warrior Class",'</text>',
        '<text x="50%" y="50%" class="base" dominant-baseline="middle" text-anchor="middle">', "Level: ",getLevel(tokenId),'</text>',
        '<text x="50%" y="60%" class="base" dominant-baseline="middle" text-anchor="middle">', "Health: ",getHealth(tokenId),'</text>',
        '<text x="50%" y="70%" class="base" dominant-baseline="middle" text-anchor="middle">', "Strength: ",getStrength(tokenId),'</text>',
        '<text x="50%" y="80%" class="base" dominant-baseline="middle" text-anchor="middle">', "Speed: ",getSpeed(tokenId),'</text>',
    '</svg>'

    );
    return string(
        abi.encodePacked(
            "data:image/svg+xml;base64,",
            Base64.encode(svg)
        )    
    );
}

// Character statistics
function getLevel(uint256 tokenId) public view returns (string memory){
    // store struct Character.level from Character struct as uint256 _level
    uint256 _level = tokenIdToLevels[tokenId].level; 
    return _level.toString();
}
    // store struct Character.health from Character struct as uint256 _health
function getHealth(uint256 tokenId) public view returns (string memory){
    uint256 _health = tokenIdToLevels[tokenId].health;
    return _health.toString();
}
    // store struct Character.strength as uint256 _strength
function getStrength(uint256 tokenId) public view returns (string memory){
    uint256 _strength = tokenIdToLevels[tokenId].strength;
    return _strength.toString();
}
    // store struct Character.speed as uint256 _speed
function getSpeed(uint256 tokenId) public view returns (string memory){
    uint256 _speed = tokenIdToLevels[tokenId].speed;
    return _speed.toString();
}


function getTokenURI(uint256 tokenId) public returns (string memory) {
    bytes memory dataURI = abi.encodePacked(
        '{',
            '"name": "Chain Battles #', tokenId.toString(), '",',
            '"description": "Battles on-chain",',
            '"image": "', getCharacter(tokenId), '"',
        '}'  
    );
    return string(
        abi.encodePacked(
            "data:application/json;base64,",
            Base64.encode(dataURI)
        )
    );
}

// Create a new NFT
function mint() public {
    _tokenIds.increment();  // increment the value of tokenIds
    uint256 newItemId = _tokenIds.current();    // store the current value to newItemId
    _safeMint(msg.sender, newItemId);   // call safeMint function from the OpenZeppelin ERC721URIStorage.sol library. pass msg sender and current id
    
    // create new item in tokenIdToLevels mapping,
    tokenIdToLevels[newItemId].level = 0;       // initialize level at zero
    tokenIdToLevels[newItemId].health = 10;     // initialize health at 10
    tokenIdToLevels[newItemId].strength = 5;    // initalize strength at 5
    tokenIdToLevels[newItemId].speed = 3;       // initialize speed at 3

    _setTokenURI(newItemId, getTokenURI(newItemId));    // set the token URI passing newItemId, return value of getTokenURI()
}

function train(uint256 tokenId) public {
    require(_exists(tokenId), "Please use an existing token");  // checks if tokenId exists, return message
    require(ownerOf(tokenId) == msg.sender, "You must own this token to train it"); // if the owner of the wallet own the tokenId, return message

    uint256 currentLevel = tokenIdToLevels[tokenId].level;
    uint256 currentHealth = tokenIdToLevels[tokenId].health;
    uint256 currentStrength = tokenIdToLevels[tokenId].strength;
    uint256 currentSpeed = tokenIdToLevels[tokenId].speed;

    tokenIdToLevels[tokenId].level = currentLevel +1;
    // randomize character stats
    tokenIdToLevels[tokenId].health = currentHealth + uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender))) % 20;
    tokenIdToLevels[tokenId].strength = currentStrength + uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender))) % 10;
    tokenIdToLevels[tokenId].speed = currentSpeed + uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender))) % 15;
     
    _setTokenURI(tokenId, getTokenURI(tokenId));        // update the metadata to update the nft
    }
}
