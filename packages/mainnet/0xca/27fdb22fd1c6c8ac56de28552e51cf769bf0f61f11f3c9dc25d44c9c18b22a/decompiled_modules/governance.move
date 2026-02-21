module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::governance {
    struct GovernanceConfig has key {
        id: 0x2::object::UID,
        total_proposals: u64,
        total_executed: u64,
        total_supply_for_quorum: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        proposal_id: u64,
        proposer: address,
        title: vector<u8>,
        description: vector<u8>,
        action_type: u8,
        action_data: vector<u8>,
        yes_votes: u64,
        no_votes: u64,
        total_voters: u64,
        vote_end_ms: u64,
        timelock_end_ms: u64,
        status: u8,
        created_at: u64,
        executed_at: u64,
    }

    struct VoteReceipt has store, key {
        id: 0x2::object::UID,
        proposal_id: u64,
        voter: address,
        vote_power: u64,
        support: bool,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        proposer: address,
        title: vector<u8>,
        action_type: u8,
        vote_end_ms: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: u64,
        voter: address,
        vote_power: u64,
        support: bool,
    }

    struct ProposalFinalized has copy, drop {
        proposal_id: u64,
        status: u8,
        yes_votes: u64,
        no_votes: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: u64,
        executor: address,
    }

    entry fun cancel_proposal(arg0: &mut Proposal, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1001);
        assert!(0x2::tx_context::sender(arg1) == arg0.proposer, 1000);
        arg0.status = 4;
    }

    entry fun create_proposal(arg0: &0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::access_control::GovernanceCap, arg1: &mut GovernanceConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = v0 + 604800000;
        let v2 = arg1.total_proposals + 1;
        arg1.total_proposals = v2;
        let v3 = Proposal{
            id              : 0x2::object::new(arg7),
            proposal_id     : v2,
            proposer        : 0x2::tx_context::sender(arg7),
            title           : arg2,
            description     : arg3,
            action_type     : arg4,
            action_data     : arg5,
            yes_votes       : 0,
            no_votes        : 0,
            total_voters    : 0,
            vote_end_ms     : v1,
            timelock_end_ms : v1 + 172800000,
            status          : 0,
            created_at      : v0,
            executed_at     : 0,
        };
        let v4 = ProposalCreated{
            proposal_id : v2,
            proposer    : 0x2::tx_context::sender(arg7),
            title       : arg2,
            action_type : arg4,
            vote_end_ms : v1,
        };
        0x2::event::emit<ProposalCreated>(v4);
        0x2::transfer::share_object<Proposal>(v3);
    }

    entry fun execute_proposal(arg0: &0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::access_control::GovernanceCap, arg1: &mut Proposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 1008);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.timelock_end_ms, 1003);
        arg1.status = 3;
        arg1.executed_at = 0x2::clock::timestamp_ms(arg2);
        let v0 = ProposalExecuted{
            proposal_id : arg1.proposal_id,
            executor    : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProposalExecuted>(v0);
    }

    entry fun finalize_proposal(arg0: &GovernanceConfig, arg1: &mut Proposal, arg2: &0x2::clock::Clock) {
        assert!(arg1.status == 0, 1001);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.vote_end_ms, 1002);
        if (arg1.yes_votes + arg1.no_votes >= arg0.total_supply_for_quorum * 2500 / 10000 && arg1.yes_votes > arg1.no_votes) {
            arg1.status = 1;
        } else {
            arg1.status = 2;
        };
        let v0 = ProposalFinalized{
            proposal_id : arg1.proposal_id,
            status      : arg1.status,
            yes_votes   : arg1.yes_votes,
            no_votes    : arg1.no_votes,
        };
        0x2::event::emit<ProposalFinalized>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceConfig{
            id                      : 0x2::object::new(arg0),
            total_proposals         : 0,
            total_executed          : 0,
            total_supply_for_quorum : 1000000000000000000,
        };
        0x2::transfer::share_object<GovernanceConfig>(v0);
    }

    public fun proposal_id(arg0: &Proposal) : u64 {
        arg0.proposal_id
    }

    public fun proposal_no_votes(arg0: &Proposal) : u64 {
        arg0.no_votes
    }

    public fun proposal_status(arg0: &Proposal) : u8 {
        arg0.status
    }

    public fun proposal_yes_votes(arg0: &Proposal) : u64 {
        arg0.yes_votes
    }

    public fun total_executed(arg0: &GovernanceConfig) : u64 {
        arg0.total_executed
    }

    public fun total_proposals(arg0: &GovernanceConfig) : u64 {
        arg0.total_proposals
    }

    entry fun vote(arg0: &mut Proposal, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1001);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.vote_end_ms, 1001);
        assert!(arg1 > 0, 1007);
        let v0 = 0x2::tx_context::sender(arg4);
        if (arg2) {
            arg0.yes_votes = arg0.yes_votes + arg1;
        } else {
            arg0.no_votes = arg0.no_votes + arg1;
        };
        arg0.total_voters = arg0.total_voters + 1;
        let v1 = VoteReceipt{
            id          : 0x2::object::new(arg4),
            proposal_id : arg0.proposal_id,
            voter       : v0,
            vote_power  : arg1,
            support     : arg2,
        };
        let v2 = VoteCast{
            proposal_id : arg0.proposal_id,
            voter       : v0,
            vote_power  : arg1,
            support     : arg2,
        };
        0x2::event::emit<VoteCast>(v2);
        0x2::transfer::transfer<VoteReceipt>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

