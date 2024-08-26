# Aptos DAO Contract Documentation

## Overview
This contract implements a Decentralized Autonomous Organization (DAO) on the Aptos blockchain. It allows users to create spaces, join spaces, create proposals, and vote on proposals.

## Structures

### Space
Represents a DAO instance.

- `space_id`: u64
- `img_link`: String
- `name`: String
- `description`: String
- `creator`: address
- `members`: vector<address>
- `proposals`: vector<u64>
- `ended_time`: u64

### Proposal
Represents a proposal within a space.

- `id`: u64
- `img_link`: String
- `title`: String
- `description`: String
- `creator`: address
- `created_at`: u64
- `ended_time`: u64
- `is_closed`: bool
- `count_user_voted`: u64
- `voter`: vector<address>
- `count_vote_yes`: u64
- `count_vote_no`: u64

## Entry Functions

### create_space
Creates a new space in the DAO.

Parameters:
- `account`: &signer
- `img_link`: String
- `name`: String
- `description`: String
- `ended_time`: u64

### join_space
Allows a user to join an existing space.

Parameters:
- `account`: &signer
- `space_id`: u64

### create_proposal
Creates a new proposal within a space.

Parameters:
- `account`: &signer
- `space_id`: u64
- `img_link`: String
- `title`: String
- `description`: String
- `ended_time`: u64

### vote_proposal
Allows a user to vote on a proposal.

Parameters:
- `account`: &signer
- `proposal_id`: u64
- `vote`: bool

## View Functions

### get_space
Retrieves a space by its ID.

Parameters:
- `space_id`: u64

Returns: Space

### get_proposal_active
Retrieves an active proposal by its ID.

Parameters:
- `proposal_id`: u64

Returns: Proposal

### get_all_proposals
Retrieves all proposals.

Returns: vector<Proposal>

### get_all_proposals_by_space
Retrieves all proposals for a specific space.

Parameters:
- `space_id`: u64

Returns: vector<Proposal>

### get_all_proposals_by_creator
Retrieves all proposals created by a specific address.

Parameters:
- `creator`: address

Returns: vector<Proposal>

### get_all_proposals_voted_by_address
Retrieves all proposals voted on by a specific address.

Parameters:
- `address`: address

Returns: vector<Proposal>

## Error Constants
- `E_SPACE_NAME_USED`: u64 = 1
- `E_PROPOSAL_NOT_ENDED`: u64 = 5
- `E_PROPOSAL_NOT_PENDING`: u64 = 6

Note: The implementation details for storing and managing spaces and proposals are not provided in the given code. The actual storage mechanism and state management would need to be implemented to make this contract fully functional.