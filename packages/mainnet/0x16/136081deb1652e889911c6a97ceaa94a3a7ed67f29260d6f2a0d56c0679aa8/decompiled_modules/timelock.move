module 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::timelock {
    struct TimelockRegistry has key {
        id: 0x2::object::UID,
        proposals: 0x2::table::Table<u64, TimelockProposal>,
        next_proposal_id: u64,
    }

    struct TimelockProposal has drop, store {
        proposal_id: u64,
        action_type: u8,
        payload: vector<u8>,
        proposed_at_ms: u64,
        executable_after_ms: u64,
        proposer: address,
    }

    struct ProposalCreatedEvent has copy, drop {
        proposal_id: u64,
        action_type: u8,
        proposer: address,
        proposed_at_ms: u64,
        executable_after_ms: u64,
    }

    struct ProposalExecutedEvent has copy, drop {
        proposal_id: u64,
        action_type: u8,
        executed_at_ms: u64,
    }

    struct ProposalCancelledEvent has copy, drop {
        proposal_id: u64,
        cancelled_at_ms: u64,
    }

    public fun action_register_protocol() : u8 {
        2
    }

    public fun action_set_fee_recipient() : u8 {
        5
    }

    public fun action_update_crank_config() : u8 {
        1
    }

    public fun action_update_fee() : u8 {
        3
    }

    public fun action_update_tvl_cap() : u8 {
        4
    }

    public fun cancel(arg0: &mut TimelockRegistry, arg1: &0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<u64, TimelockProposal>(&arg0.proposals, arg2), 301);
        0x2::table::remove<u64, TimelockProposal>(&mut arg0.proposals, arg2);
        let v0 = ProposalCancelledEvent{
            proposal_id     : arg2,
            cancelled_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProposalCancelledEvent>(v0);
    }

    public fun create_registry(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TimelockRegistry{
            id               : 0x2::object::new(arg0),
            proposals        : 0x2::table::new<u64, TimelockProposal>(arg0),
            next_proposal_id : 0,
        };
        0x2::transfer::share_object<TimelockRegistry>(v0);
    }

    public fun delay_ms() : u64 {
        172800000
    }

    public fun execute(arg0: &mut TimelockRegistry, arg1: u64, arg2: &0x2::clock::Clock) : (u8, vector<u8>) {
        assert!(0x2::table::contains<u64, TimelockProposal>(&arg0.proposals, arg1), 301);
        let v0 = 0x2::table::remove<u64, TimelockProposal>(&mut arg0.proposals, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.executable_after_ms, 300);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_timelock_delay(v1 - v0.proposed_at_ms);
        let v2 = ProposalExecutedEvent{
            proposal_id    : arg1,
            action_type    : v0.action_type,
            executed_at_ms : v1,
        };
        0x2::event::emit<ProposalExecutedEvent>(v2);
        (v0.action_type, v0.payload)
    }

    public fun get_proposal_info(arg0: &TimelockRegistry, arg1: u64) : (u8, u64, u64, address) {
        let v0 = 0x2::table::borrow<u64, TimelockProposal>(&arg0.proposals, arg1);
        (v0.action_type, v0.proposed_at_ms, v0.executable_after_ms, v0.proposer)
    }

    public fun has_proposal(arg0: &TimelockRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, TimelockProposal>(&arg0.proposals, arg1)
    }

    public fun next_proposal_id(arg0: &TimelockRegistry) : u64 {
        arg0.next_proposal_id
    }

    public fun propose(arg0: &mut TimelockRegistry, arg1: &0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::AdminCap, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = arg0.next_proposal_id;
        let v2 = TimelockProposal{
            proposal_id         : v1,
            action_type         : arg2,
            payload             : arg3,
            proposed_at_ms      : v0,
            executable_after_ms : v0 + 172800000,
            proposer            : 0x2::tx_context::sender(arg5),
        };
        0x2::table::add<u64, TimelockProposal>(&mut arg0.proposals, v1, v2);
        arg0.next_proposal_id = v1 + 1;
        let v3 = ProposalCreatedEvent{
            proposal_id         : v1,
            action_type         : arg2,
            proposer            : 0x2::tx_context::sender(arg5),
            proposed_at_ms      : v0,
            executable_after_ms : v0 + 172800000,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
        v1
    }

    // decompiled from Move bytecode v6
}

