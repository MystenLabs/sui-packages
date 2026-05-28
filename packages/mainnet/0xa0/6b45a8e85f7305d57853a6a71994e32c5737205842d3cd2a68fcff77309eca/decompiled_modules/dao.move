module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::dao {
    struct DAOMember has store, key {
        id: 0x2::object::UID,
        member: address,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        proposer: address,
        description: vector<u8>,
        action_type: vector<u8>,
        action_data: vector<u8>,
        yes_votes: u64,
        no_votes: u64,
        voters: 0x2::vec_set::VecSet<address>,
        created_at_ms: u64,
        voting_ends_at_ms: u64,
        executed: bool,
    }

    struct EmergencyAction has key {
        id: 0x2::object::UID,
        action_type: vector<u8>,
        description: vector<u8>,
        approvals: 0x2::vec_set::VecSet<address>,
        threshold: u64,
        executed: bool,
        created_at_ms: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: address,
        proposer: address,
        action_type: vector<u8>,
        voting_ends_at_ms: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: address,
        voter: address,
        in_favor: bool,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: address,
        action_type: vector<u8>,
        yes_votes: u64,
        no_votes: u64,
    }

    struct EmergencyTriggered has copy, drop {
        action_id: address,
        action_type: vector<u8>,
        approvals: u64,
    }

    public fun approve_emergency(arg0: &DAOMember, arg1: &mut EmergencyAction, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg1.executed, 308);
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_set::contains<address>(&arg1.approvals, &v0)) {
            0x2::vec_set::insert<address>(&mut arg1.approvals, v0);
        };
    }

    public fun create_emergency_action(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = EmergencyAction{
            id            : 0x2::object::new(arg5),
            action_type   : arg1,
            description   : arg2,
            approvals     : 0x2::vec_set::empty<address>(),
            threshold     : arg3,
            executed      : false,
            created_at_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::share_object<EmergencyAction>(v0);
    }

    public fun create_proposal(arg0: &DAOMember, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = Proposal{
            id                : 0x2::object::new(arg6),
            proposer          : 0x2::tx_context::sender(arg6),
            description       : arg1,
            action_type       : arg2,
            action_data       : arg3,
            yes_votes         : 0,
            no_votes          : 0,
            voters            : 0x2::vec_set::empty<address>(),
            created_at_ms     : v0,
            voting_ends_at_ms : v0 + arg4,
            executed          : false,
        };
        let v2 = ProposalCreated{
            proposal_id       : 0x2::object::uid_to_address(&v1.id),
            proposer          : 0x2::tx_context::sender(arg6),
            action_type       : arg2,
            voting_ends_at_ms : v0 + arg4,
        };
        0x2::event::emit<ProposalCreated>(v2);
        0x2::transfer::share_object<Proposal>(v1);
    }

    public fun emergency_approval_count(arg0: &EmergencyAction) : u64 {
        0x2::vec_set::size<address>(&arg0.approvals)
    }

    public fun emergency_executed(arg0: &EmergencyAction) : bool {
        arg0.executed
    }

    public fun execute_emergency(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut EmergencyAction) {
        assert!(!arg1.executed, 308);
        assert!(0x2::vec_set::size<address>(&arg1.approvals) >= arg1.threshold, 307);
        arg1.executed = true;
        let v0 = EmergencyTriggered{
            action_id   : 0x2::object::uid_to_address(&arg1.id),
            action_type : arg1.action_type,
            approvals   : 0x2::vec_set::size<address>(&arg1.approvals),
        };
        0x2::event::emit<EmergencyTriggered>(v0);
    }

    public fun execute_proposal(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: &mut Proposal, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.voting_ends_at_ms, 302);
        assert!(!arg1.executed, 304);
        assert!(arg1.yes_votes > arg1.no_votes, 303);
        assert!(arg1.yes_votes + arg1.no_votes >= 1, 305);
        arg1.executed = true;
        let v0 = ProposalExecuted{
            proposal_id : 0x2::object::uid_to_address(&arg1.id),
            action_type : arg1.action_type,
            yes_votes   : arg1.yes_votes,
            no_votes    : arg1.no_votes,
        };
        0x2::event::emit<ProposalExecuted>(v0);
    }

    public fun issue_member_cap(arg0: &0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DAOMember{
            id     : 0x2::object::new(arg2),
            member : arg1,
        };
        0x2::transfer::transfer<DAOMember>(v0, arg1);
    }

    public fun proposal_action_type(arg0: &Proposal) : vector<u8> {
        arg0.action_type
    }

    public fun proposal_executed(arg0: &Proposal) : bool {
        arg0.executed
    }

    public fun proposal_no(arg0: &Proposal) : u64 {
        arg0.no_votes
    }

    public fun proposal_yes(arg0: &Proposal) : u64 {
        arg0.yes_votes
    }

    public fun vote(arg0: &DAOMember, arg1: &mut Proposal, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::vec_set::contains<address>(&arg1.voters, &v0), 300);
        assert!(0x2::clock::timestamp_ms(arg3) < arg1.voting_ends_at_ms, 301);
        0x2::vec_set::insert<address>(&mut arg1.voters, v0);
        if (arg2) {
            arg1.yes_votes = arg1.yes_votes + 1;
        } else {
            arg1.no_votes = arg1.no_votes + 1;
        };
        let v1 = VoteCast{
            proposal_id : 0x2::object::uid_to_address(&arg1.id),
            voter       : v0,
            in_favor    : arg2,
        };
        0x2::event::emit<VoteCast>(v1);
    }

    // decompiled from Move bytecode v7
}

