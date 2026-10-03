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

