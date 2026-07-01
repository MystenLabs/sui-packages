module 0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha_governance {
    struct GovernanceRegistry has key {
        id: 0x2::object::UID,
        proposal_count: u64,
        quorum_bps: u64,
        total_supply: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        proposal_id: u64,
        title: vector<u8>,
        description: vector<u8>,
        proposer: address,
        start_time: u64,
        end_time: u64,
        votes_for: u64,
        votes_against: u64,
        executed: bool,
        canceled: bool,
    }

    struct VoteReceipt has store, key {
        id: 0x2::object::UID,
        proposal_id: u64,
        voter: address,
        vote_for: bool,
        voting_power: u64,
    }

    struct VoteLock has key {
        id: 0x2::object::UID,
        owner: address,
        locked_balance: 0x2::balance::Balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>,
        proposal_id: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        proposer: address,
        title: vector<u8>,
    }

    struct VoteCast has copy, drop {
        proposal_id: u64,
        voter: address,
        vote_for: bool,
        voting_power: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: u64,
        passed: bool,
    }

    public fun create_proposal(arg0: &mut GovernanceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.proposal_count + 1;
        arg0.proposal_count = v0;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = Proposal{
            id            : 0x2::object::new(arg4),
            proposal_id   : v0,
            title         : arg1,
            description   : arg2,
            proposer      : 0x2::tx_context::sender(arg4),
            start_time    : v1,
            end_time      : v1 + 604800000,
            votes_for     : 0,
            votes_against : 0,
            executed      : false,
            canceled      : false,
        };
        let v3 = ProposalCreated{
            proposal_id : v0,
            proposer    : 0x2::tx_context::sender(arg4),
            title       : arg1,
        };
        0x2::event::emit<ProposalCreated>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    public fun execute_proposal(arg0: &mut Proposal, arg1: &GovernanceRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_time, 2);
        assert!(!arg0.executed && !arg0.canceled, 0);
        let v0 = arg0.votes_for + arg0.votes_against >= arg1.total_supply * arg1.quorum_bps / 10000 && arg0.votes_for > arg0.votes_against;
        arg0.executed = true;
        let v1 = ProposalExecuted{
            proposal_id : arg0.proposal_id,
            passed      : v0,
        };
        0x2::event::emit<ProposalExecuted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceRegistry{
            id             : 0x2::object::new(arg0),
            proposal_count : 0,
            quorum_bps     : 400,
            total_supply   : 1610800000000000000,
        };
        0x2::transfer::share_object<GovernanceRegistry>(v0);
    }

    public fun is_active(arg0: &Proposal, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.executed) {
            if (!arg0.canceled) {
                0x2::clock::timestamp_ms(arg1) <= arg0.end_time
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun proposal_count(arg0: &GovernanceRegistry) : u64 {
        arg0.proposal_count
    }

    public fun reclaim_tokens(arg0: &Proposal, arg1: VoteLock, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_time, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.owner == v0, 5);
        let VoteLock {
            id             : v1,
            owner          : _,
            locked_balance : v3,
            proposal_id    : _,
        } = arg1;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>>(0x2::coin::from_balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(v3, arg3), v0);
    }

    public fun vote(arg0: &mut Proposal, arg1: 0x2::coin::Coin<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.canceled && !arg0.executed, 0);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.end_time, 1);
        let v0 = 0x2::coin::value<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(&arg1);
        assert!(v0 >= 10000000000, 4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = VoteLock{
            id             : 0x2::object::new(arg4),
            owner          : v1,
            locked_balance : 0x2::coin::into_balance<0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha::ARTHA>(arg1),
            proposal_id    : arg0.proposal_id,
        };
        if (arg2) {
            arg0.votes_for = arg0.votes_for + v0;
        } else {
            arg0.votes_against = arg0.votes_against + v0;
        };
        let v3 = VoteReceipt{
            id           : 0x2::object::new(arg4),
            proposal_id  : arg0.proposal_id,
            voter        : v1,
            vote_for     : arg2,
            voting_power : v0,
        };
        let v4 = VoteCast{
            proposal_id  : arg0.proposal_id,
            voter        : v1,
            vote_for     : arg2,
            voting_power : v0,
        };
        0x2::event::emit<VoteCast>(v4);
        0x2::transfer::share_object<VoteLock>(v2);
        0x2::transfer::public_transfer<VoteReceipt>(v3, v1);
    }

    public fun votes_against(arg0: &Proposal) : u64 {
        arg0.votes_against
    }

    public fun votes_for(arg0: &Proposal) : u64 {
        arg0.votes_for
    }

    // decompiled from Move bytecode v7
}

