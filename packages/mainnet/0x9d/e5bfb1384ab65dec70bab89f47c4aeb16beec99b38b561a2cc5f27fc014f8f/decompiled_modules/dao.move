module 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::dao {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DaoConfig has key {
        id: 0x2::object::UID,
        total_supply: u64,
        proposal_count: u64,
        min_propose_tokens: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        dao_id: 0x2::object::ID,
        proposer: address,
        title: vector<u8>,
        description_ipfs: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        votes_abstain: u64,
        start_ms: u64,
        end_ms: u64,
        executed: bool,
        cancelled: bool,
    }

    struct VoteReceipt has store, key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        voter: address,
        power: u64,
        choice: u8,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        end_ms: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        power: u64,
        choice: u8,
    }

    public fun cancel_proposal(arg0: &AdminCap, arg1: &mut Proposal, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg1.end_ms, 3);
        arg1.cancelled = true;
    }

    public fun cancelled(arg0: &Proposal) : bool {
        arg0.cancelled
    }

    public fun create_proposal<T0>(arg0: &mut DaoConfig, arg1: &0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg1) >= arg0.min_propose_tokens, 1);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        arg0.proposal_count = arg0.proposal_count + 1;
        let v1 = 0x2::object::new(arg5);
        let v2 = ProposalCreated{
            proposal_id : 0x2::object::uid_to_inner(&v1),
            proposer    : 0x2::tx_context::sender(arg5),
            end_ms      : v0 + 259200000,
        };
        0x2::event::emit<ProposalCreated>(v2);
        let v3 = Proposal{
            id               : v1,
            dao_id           : 0x2::object::id<DaoConfig>(arg0),
            proposer         : 0x2::tx_context::sender(arg5),
            title            : arg2,
            description_ipfs : arg3,
            votes_for        : 0,
            votes_against    : 0,
            votes_abstain    : 0,
            start_ms         : v0,
            end_ms           : v0 + 259200000,
            executed         : false,
            cancelled        : false,
        };
        0x2::transfer::share_object<Proposal>(v3);
    }

    public fun end_ms(arg0: &Proposal) : u64 {
        arg0.end_ms
    }

    public fun executed(arg0: &Proposal) : bool {
        arg0.executed
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DaoConfig{
            id                 : 0x2::object::new(arg0),
            total_supply       : 1000000000000000000,
            proposal_count     : 0,
            min_propose_tokens : 10000000000000,
        };
        0x2::transfer::share_object<DaoConfig>(v1);
    }

    public(friend) fun mark_executed(arg0: &mut Proposal) {
        assert!(!arg0.executed, 2);
        arg0.executed = true;
    }

    public fun pass_threshold_bps() : u64 {
        5000
    }

    public fun proposal_id(arg0: &Proposal) : 0x2::object::ID {
        0x2::object::id<Proposal>(arg0)
    }

    public(friend) fun proposal_uid(arg0: &Proposal) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun proposal_uid_mut(arg0: &mut Proposal) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun quorum_bps() : u64 {
        1000
    }

    public(friend) fun tally_vote(arg0: &mut Proposal, arg1: u64, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : VoteReceipt {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(!arg0.cancelled, 3);
        assert!(v0 >= arg0.start_ms, 3);
        assert!(v0 < arg0.end_ms, 3);
        assert!(arg2 <= 2, 2);
        assert!(arg1 > 0, 1);
        if (arg2 == 1) {
            arg0.votes_for = arg0.votes_for + arg1;
        } else if (arg2 == 0) {
            arg0.votes_against = arg0.votes_against + arg1;
        } else {
            arg0.votes_abstain = arg0.votes_abstain + arg1;
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = VoteCast{
            proposal_id : 0x2::object::id<Proposal>(arg0),
            voter       : v1,
            power       : arg1,
            choice      : arg2,
        };
        0x2::event::emit<VoteCast>(v2);
        VoteReceipt{
            id          : 0x2::object::new(arg4),
            proposal_id : 0x2::object::id<Proposal>(arg0),
            voter       : v1,
            power       : arg1,
            choice      : arg2,
        }
    }

    public fun total_supply(arg0: &DaoConfig) : u64 {
        arg0.total_supply
    }

    public fun update_total_supply(arg0: &AdminCap, arg1: &mut DaoConfig, arg2: u64) {
        arg1.total_supply = arg2;
    }

    public fun votes_abstain(arg0: &Proposal) : u64 {
        arg0.votes_abstain
    }

    public fun votes_against(arg0: &Proposal) : u64 {
        arg0.votes_against
    }

    public fun votes_for(arg0: &Proposal) : u64 {
        arg0.votes_for
    }

    // decompiled from Move bytecode v6
}

