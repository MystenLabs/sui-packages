module 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events {
    struct AgentCreated has copy, drop {
        agent_id: 0x2::object::ID,
        owner: address,
    }

    struct KeyIssued has copy, drop {
        agent_id: 0x2::object::ID,
        key_id: vector<u8>,
    }

    struct KeyActivated has copy, drop {
        agent_id: 0x2::object::ID,
        key_id: vector<u8>,
        activated_at_epoch: u64,
    }

    struct KeyCharged has copy, drop {
        agent_id: 0x2::object::ID,
        amount_usdc_micro: u64,
        solana_tx: vector<u8>,
    }

    struct WalkRecorded has copy, drop {
        agent_id: 0x2::object::ID,
        vertex: vector<u8>,
        cost_usdc_micro: u64,
    }

    struct AgentRetired has copy, drop {
        agent_id: 0x2::object::ID,
    }

    struct TicketMinted has copy, drop {
        agent_id: 0x2::object::ID,
        seq: u64,
        max_cost: u64,
        kind: u8,
        commitment: 0x1::option::Option<vector<u8>>,
        minted_ms: u64,
        expires_ms: u64,
    }

    struct TicketSettled has copy, drop {
        agent_id: 0x2::object::ID,
        seq: u64,
        escrow: u64,
        actual: u64,
        commitment: 0x1::option::Option<vector<u8>>,
        treasury: address,
    }

    struct TicketReclaimed has copy, drop {
        agent_id: 0x2::object::ID,
        seq: u64,
        amount: u64,
        caller: address,
    }

    struct LlmPolicySet has copy, drop {
        agent_id: 0x2::object::ID,
        max_open_micro: u64,
        model_allow_hash: 0x1::option::Option<vector<u8>>,
    }

    public(friend) fun emit_agent_created(arg0: 0x2::object::ID, arg1: address) {
        let v0 = AgentCreated{
            agent_id : arg0,
            owner    : arg1,
        };
        0x2::event::emit<AgentCreated>(v0);
    }

    public(friend) fun emit_agent_retired(arg0: 0x2::object::ID) {
        let v0 = AgentRetired{agent_id: arg0};
        0x2::event::emit<AgentRetired>(v0);
    }

    public(friend) fun emit_key_activated(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = KeyActivated{
            agent_id           : arg0,
            key_id             : arg1,
            activated_at_epoch : arg2,
        };
        0x2::event::emit<KeyActivated>(v0);
    }

    public(friend) fun emit_key_charged(arg0: 0x2::object::ID, arg1: u64, arg2: vector<u8>) {
        let v0 = KeyCharged{
            agent_id          : arg0,
            amount_usdc_micro : arg1,
            solana_tx         : arg2,
        };
        0x2::event::emit<KeyCharged>(v0);
    }

    public(friend) fun emit_key_issued(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = KeyIssued{
            agent_id : arg0,
            key_id   : arg1,
        };
        0x2::event::emit<KeyIssued>(v0);
    }

    public(friend) fun emit_llm_policy_set(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::option::Option<vector<u8>>) {
        let v0 = LlmPolicySet{
            agent_id         : arg0,
            max_open_micro   : arg1,
            model_allow_hash : arg2,
        };
        0x2::event::emit<LlmPolicySet>(v0);
    }

    public(friend) fun emit_ticket_minted(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::option::Option<vector<u8>>, arg5: u64, arg6: u64) {
        let v0 = TicketMinted{
            agent_id   : arg0,
            seq        : arg1,
            max_cost   : arg2,
            kind       : arg3,
            commitment : arg4,
            minted_ms  : arg5,
            expires_ms : arg6,
        };
        0x2::event::emit<TicketMinted>(v0);
    }

    public(friend) fun emit_ticket_reclaimed(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: address) {
        let v0 = TicketReclaimed{
            agent_id : arg0,
            seq      : arg1,
            amount   : arg2,
            caller   : arg3,
        };
        0x2::event::emit<TicketReclaimed>(v0);
    }

    public(friend) fun emit_ticket_settled(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: 0x1::option::Option<vector<u8>>, arg5: address) {
        let v0 = TicketSettled{
            agent_id   : arg0,
            seq        : arg1,
            escrow     : arg2,
            actual     : arg3,
            commitment : arg4,
            treasury   : arg5,
        };
        0x2::event::emit<TicketSettled>(v0);
    }

    public(friend) fun emit_walk_recorded(arg0: 0x2::object::ID, arg1: vector<u8>, arg2: u64) {
        let v0 = WalkRecorded{
            agent_id        : arg0,
            vertex          : arg1,
            cost_usdc_micro : arg2,
        };
        0x2::event::emit<WalkRecorded>(v0);
    }

    // decompiled from Move bytecode v7
}

