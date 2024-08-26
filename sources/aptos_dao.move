module dao::aptos_dao {
    use std::signer;
    use std::string;
    use std::vector;
    use std::time;
    
    
    const E_SPACE_NAME_USED: u64 = 1;
    const E_SPACE_NOT_FOUND: u64 = 2;
    const E_NOT_SPACE_MEMBER: u64 = 3;
    const E_PROPOSAL_NOT_FOUND: u64 = 4;
    const E_PROPOSAL_NOT_ENDED: u64 = 5;
    const E_PROPOSAL_NOT_PENDING: u64 = 6;
    const E_ALREADY_VOTED: u64 = 7;
    const E_VOTING_CLOSED: u64 = 8;
    const E_UNAUTHORIZED: u64 = 9;
    
    
    struct Space {
        space_id: u64,
        img_link: String,
        name: String,
        description: String,
        creator: address,
        members: vector<address>,
        proposals: vector<u64>,
        ended_time: u64,
    }

    struct DAOState has key {
        spaces: vector<Space>,
        proposals: vector<Proposal>,
        space_count: u64,
        proposal_count: u64,
    }

    struct Proposal {
        id: u64,
        img_link: String,
        title: String,
        description: String,
        creator: address,
        created_at: u64,
        ended_time: u64,
        is_closed: bool,
        count_user_voted: u64,
        voter: vector<address>,
        count_vote_yes: u64,
        count_vote_no: u64,
    }
    
    fun init_module(account: &signer) {
        let dao_state = DAOState {
            spaces: vector::empty(),
            proposals: vector::empty(),
            space_count: 0,
            proposal_count: 0,
        };
        move_to(account, dao_state);
    }

    // ===== entry FUNCS =====
    // CREATE SPACE
    entry fun create_space(
        account: &signer,
        img_link: String,
        name: String,
        description: String,
        ended_time: u64
    ) {
        let creator = signer::address_of(account);
        let new_space = Space {
            space_id: timestamp::now_seconds(),
            img_link,
            name,
            description,
            creator,
            members: vector::empty(),
            proposals: vector::empty(),
            ended_time,
        };
    }

    entry fun join_space(account: &signer, space_id: u64) {
        let member = signer::address_of(account);
    }

    // CREATE THEARDS IN SPACE ID
    entry fun create_proposal(
        account: &signer,
        space_id: u64,
        img_link: String,
        title: String,
        description: String,
        ended_time: u64
    ) {
        let creator = signer::address_of(account);
        let new_proposal = Proposal {
            id: timestamp::now_seconds(),
            img_link,
            title,
            description,
            creator,
            created_at: timestamp::now_seconds(),
            ended_time,
            is_closed: false,
            count_user_voted: 0,
            voter: vector::empty(),
            count_vote_yes: 0,
            count_vote_no: 0,
        };

    }

    entry fun vote_proposal(account: &signer, proposal_id: u64, vote: bool) {
        let voter = signer::address_of(account);
    }

    // ===== VIEWS FUNCS =====
    // get space
       #[view]
    public fun get_space(space_id: u64): Space acquires DAOState {
        let dao_state = borrow_global<DAOState>(@dao);
        *vector::borrow(&dao_state.spaces, space_id)
    }

    #[view]
    public fun get_proposal_active(proposal_id: u64): Proposal acquires DAOState {
        let dao_state = borrow_global<DAOState>(@dao);
        let proposal = vector::borrow(&dao_state.proposals, proposal_id);
        assert!(!proposal.is_closed, E_PROPOSAL_NOT_PENDING);
        *proposal
    }

    #[view]
    public fun get_all_proposals(): vector<Proposal> acquires DAOState {
        let dao_state = borrow_global<DAOState>(@dao);
        dao_state.proposals
    }
    // get all proposals by space id
    #[view]
    public fun get_all_proposals_by_space(space_id: u64): vector<Proposal> {
        self.proposals[space_id]
    }
    // get all proposals by creator
    #[view]
    public fun get_all_proposals_by_creator(creator: address): vector<Proposal> {
        self.proposals[creator]
    }

    // get all proposals by creator
    #[view]
    public fun get_all_proposals_by_creator(creator: address): vector<Proposal> {
        self.proposals[creator]
    }

    // get all proposals voted by address
    #[view]
    public fun get_all_proposals_voted_by_address(address: address): vector<Proposal> {
        self.proposals[address]
    }   

    // ===== HELPER FUNCS =====
        // Helper functions
    fun space_exists(space_id: u64): bool acquires DAOState {
        let dao_state = borrow_global<DAOState>(@dao);
        space_id < dao_state.space_count
    }

    fun proposal_exists(proposal_id: u64): bool acquires DAOState {
        let dao_state = borrow_global<DAOState>(@dao);
        proposal_id < dao_state.proposal_count
    }
}
