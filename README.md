# ChainQuest

A blockchain-based character management system built on Stacks, implementing SIP009 NFT standard.

## Features

### Character NFTs
- Each character is a unique NFT with associated stats
- Characters have the following attributes:
  - Level
  - Experience Points (XP)
  - Strength
  - Agility
  - Intelligence

### Character Management
- **Minting**: Create new characters with base stats
  - Starting Level: 1
  - Starting XP: 0
  - Base Stats: 5 (Strength, Agility, Intelligence)

- **Training**:
  - Increase character's strength (+1)
  - Gain XP (+10)
  - Only the character owner can train

- **Leveling Up**:
  - Requires 100 XP
  - Increases character level by 1
  - Consumes 100 XP when leveling up
  - Only the character owner can level up

## Technical Implementation

### Core Components
- Implements SIP009 NFT trait
- Uses non-fungible token standard
- Maintains character stats in data map

### Security
- Owner-based access control for character actions
- Protected functions for training and leveling up
- Proper error handling with status codes:
  - 402: Insufficient XP
  - 403: Unauthorized access
  - 404: Character not found

## Getting Started

To interact with the contract, you'll need:
- A Stacks wallet
- STX tokens for transaction fees
