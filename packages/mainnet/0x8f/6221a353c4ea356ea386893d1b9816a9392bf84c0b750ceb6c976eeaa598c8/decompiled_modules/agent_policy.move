module 0x8f6221a353c4ea356ea386893d1b9816a9392bf84c0b750ceb6c976eeaa598c8::agent_policy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AgentCap has key {
        id: 0x2::object::UID,
        total_budget: u64,
        spent: u64,
        per_tx_limit: u64,
        allowed_protocols: 0x2::vec_set::VecSet<address>,
        allowed_actions: 0x2::vec_set::VecSet<vector<u8>>,
        expiry_timestamp_ms: u64,
        paused: bool,
        owner: address,
        created_at_ms: u64,
    }

    struct SpendReceipt {
        amount: u64,
        protocol: address,
        action: vector<u8>,
    }

    struct AgentCapCreated has copy, drop {
        cap_id: address,
        agent_address: address,
        total_budget: u64,
        per_tx_limit: u64,
        expiry_timestamp_ms: u64,
    }

    struct SpendAuthorized has copy, drop {
        cap_id: address,
        amount: u64,
        remaining: u64,
        protocol: address,
        action: vector<u8>,
        timestamp_ms: u64,
    }

    struct AgentCapRevoked has copy, drop {
        cap_id: address,
        spent_total: u64,
    }

    struct AgentCapPaused has copy, drop {
        cap_id: address,
        paused: bool,
    }

    public fun add_action(arg0: &AdminCap, arg1: &mut AgentCap, arg2: vector<u8>) {
        0x2::vec_set::insert<vector<u8>>(&mut arg1.allowed_actions, arg2);
    }

    public fun add_protocol(arg0: &AdminCap, arg1: &mut AgentCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.allowed_protocols, arg2);
    }

    public fun authorize_spend(arg0: &mut AgentCap, arg1: u64, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock) : SpendReceipt {
        assert!(!arg0.paused, 4);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.expiry_timestamp_ms, 1);
        assert!(arg1 <= arg0.per_tx_limit, 3);
        assert!(arg0.spent + arg1 <= arg0.total_budget, 0);
        assert!(0x2::vec_set::contains<address>(&arg0.allowed_protocols, &arg2), 2);
        assert!(0x2::vec_set::contains<vector<u8>>(&arg0.allowed_actions, &arg3), 5);
        arg0.spent = arg0.spent + arg1;
        let v0 = SpendAuthorized{
            cap_id       : 0x2::object::uid_to_address(&arg0.id),
            amount       : arg1,
            remaining    : arg0.total_budget - arg0.spent,
            protocol     : arg2,
            action       : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SpendAuthorized>(v0);
        SpendReceipt{
            amount   : arg1,
            protocol : arg2,
            action   : arg3,
        }
    }

    public fun cap_id(arg0: &AgentCap) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun consume_receipt(arg0: SpendReceipt) : (u64, address, vector<u8>) {
        let SpendReceipt {
            amount   : v0,
            protocol : v1,
            action   : v2,
        } = arg0;
        (v0, v1, v2)
    }

    public fun create_agent_cap(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: vector<address>, arg5: vector<vector<u8>>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : AgentCap {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg4)) {
            0x2::vec_set::insert<address>(&mut v0, *0x1::vector::borrow<address>(&arg4, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::vec_set::empty<vector<u8>>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(&arg5)) {
            0x2::vec_set::insert<vector<u8>>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg5, v3));
            v3 = v3 + 1;
        };
        let v4 = AgentCap{
            id                  : 0x2::object::new(arg8),
            total_budget        : arg2,
            spent               : 0,
            per_tx_limit        : arg3,
            allowed_protocols   : v0,
            allowed_actions     : v2,
            expiry_timestamp_ms : arg6,
            paused              : false,
            owner               : arg1,
            created_at_ms       : 0x2::clock::timestamp_ms(arg7),
        };
        let v5 = AgentCapCreated{
            cap_id              : 0x2::object::uid_to_address(&v4.id),
            agent_address       : arg1,
            total_budget        : arg2,
            per_tx_limit        : arg3,
            expiry_timestamp_ms : arg6,
        };
        0x2::event::emit<AgentCapCreated>(v5);
        v4
    }

    public fun expiry(arg0: &AgentCap) : u64 {
        arg0.expiry_timestamp_ms
    }

    public fun increase_budget(arg0: &AdminCap, arg1: &mut AgentCap, arg2: u64) {
        arg1.total_budget = arg1.total_budget + arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_expired(arg0: &AgentCap, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expiry_timestamp_ms
    }

    public fun is_paused(arg0: &AgentCap) : bool {
        arg0.paused
    }

    public fun issue_to_agent(arg0: &AdminCap, arg1: AgentCap) {
        0x2::transfer::transfer<AgentCap>(arg1, arg1.owner);
    }

    public fun owner(arg0: &AgentCap) : address {
        arg0.owner
    }

    public fun pause(arg0: &AdminCap, arg1: &mut AgentCap) {
        arg1.paused = true;
        let v0 = AgentCapPaused{
            cap_id : 0x2::object::uid_to_address(&arg1.id),
            paused : true,
        };
        0x2::event::emit<AgentCapPaused>(v0);
    }

    public fun remaining_budget(arg0: &AgentCap) : u64 {
        arg0.total_budget - arg0.spent
    }

    public fun remove_protocol(arg0: &AdminCap, arg1: &mut AgentCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.allowed_protocols, &arg2);
    }

    public fun revoke(arg0: &AdminCap, arg1: AgentCap) {
        let AgentCap {
            id                  : v0,
            total_budget        : _,
            spent               : _,
            per_tx_limit        : _,
            allowed_protocols   : _,
            allowed_actions     : _,
            expiry_timestamp_ms : _,
            paused              : _,
            owner               : _,
            created_at_ms       : _,
        } = arg1;
        0x2::object::delete(v0);
        let v10 = AgentCapRevoked{
            cap_id      : 0x2::object::uid_to_address(&arg1.id),
            spent_total : arg1.spent,
        };
        0x2::event::emit<AgentCapRevoked>(v10);
    }

    public fun spent(arg0: &AgentCap) : u64 {
        arg0.spent
    }

    public fun total_budget(arg0: &AgentCap) : u64 {
        arg0.total_budget
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut AgentCap) {
        arg1.paused = false;
        let v0 = AgentCapPaused{
            cap_id : 0x2::object::uid_to_address(&arg1.id),
            paused : false,
        };
        0x2::event::emit<AgentCapPaused>(v0);
    }

    // decompiled from Move bytecode v7
}

