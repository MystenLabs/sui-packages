module 0x75b7f5d2926f333d8849726655904111420d4f86acb2578274b31338bcf8142c::agent_policy {
    struct AgentPolicy has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        remaining_budget: u64,
        per_tx_cap: u64,
        allowed_protocols: 0x2::vec_set::VecSet<0x1::string::String>,
        expires_at_ms: u64,
        revoked: bool,
        total_spent: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        agent: address,
        budget: u64,
        per_tx_cap: u64,
        expires_at_ms: u64,
    }

    struct SpendAuthorized has copy, drop {
        policy_id: 0x2::object::ID,
        agent: address,
        amount: u64,
        protocol: 0x1::string::String,
        remaining: u64,
    }

    struct PolicyRevoked has copy, drop {
        policy_id: 0x2::object::ID,
    }

    struct ToppedUp has copy, drop {
        policy_id: 0x2::object::ID,
        added: u64,
        remaining: u64,
    }

    struct ExpiryExtended has copy, drop {
        policy_id: 0x2::object::ID,
        new_expires_at_ms: u64,
    }

    public fun agent(arg0: &AgentPolicy) : address {
        arg0.agent
    }

    public fun allows(arg0: &AgentPolicy, arg1: &0x1::string::String) : bool {
        0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_protocols, arg1)
    }

    fun assert_owner(arg0: &AgentPolicy, arg1: &OwnerCap) {
        assert!(arg1.policy_id == 0x2::object::id<AgentPolicy>(arg0), 6);
    }

    public fun authorize_spend(arg0: &mut AgentPolicy, arg1: &0x2::clock::Clock, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.agent, 7);
        assert!(!arg0.revoked, 1);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_at_ms, 2);
        assert!(arg2 <= arg0.per_tx_cap, 3);
        assert!(arg2 <= arg0.remaining_budget, 4);
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.allowed_protocols, &arg3), 5);
        arg0.remaining_budget = arg0.remaining_budget - arg2;
        arg0.total_spent = arg0.total_spent + arg2;
        let v0 = SpendAuthorized{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            agent     : arg0.agent,
            amount    : arg2,
            protocol  : arg3,
            remaining : arg0.remaining_budget,
        };
        0x2::event::emit<SpendAuthorized>(v0);
    }

    public fun create_policy(arg0: address, arg1: u64, arg2: u64, arg3: vector<0x1::string::String>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : OwnerCap {
        let v0 = 0x2::vec_set::empty<0x1::string::String>();
        0x1::vector::reverse<0x1::string::String>(&mut arg3);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg3)) {
            let v2 = 0x1::vector::pop_back<0x1::string::String>(&mut arg3);
            if (!0x2::vec_set::contains<0x1::string::String>(&v0, &v2)) {
                0x2::vec_set::insert<0x1::string::String>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg3);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = AgentPolicy{
            id                : 0x2::object::new(arg5),
            owner             : v3,
            agent             : arg0,
            remaining_budget  : arg1,
            per_tx_cap        : arg2,
            allowed_protocols : v0,
            expires_at_ms     : arg4,
            revoked           : false,
            total_spent       : 0,
        };
        let v5 = 0x2::object::id<AgentPolicy>(&v4);
        let v6 = PolicyCreated{
            policy_id     : v5,
            owner         : v3,
            agent         : arg0,
            budget        : arg1,
            per_tx_cap    : arg2,
            expires_at_ms : arg4,
        };
        0x2::event::emit<PolicyCreated>(v6);
        0x2::transfer::share_object<AgentPolicy>(v4);
        OwnerCap{
            id        : 0x2::object::new(arg5),
            policy_id : v5,
        }
    }

    entry fun create_policy_entry(arg0: address, arg1: u64, arg2: u64, arg3: vector<0x1::string::String>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = create_policy(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun expires_at_ms(arg0: &AgentPolicy) : u64 {
        arg0.expires_at_ms
    }

    public fun extend_expiry(arg0: &mut AgentPolicy, arg1: &OwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        arg0.expires_at_ms = arg2;
        let v0 = ExpiryExtended{
            policy_id         : 0x2::object::id<AgentPolicy>(arg0),
            new_expires_at_ms : arg2,
        };
        0x2::event::emit<ExpiryExtended>(v0);
    }

    public fun is_revoked(arg0: &AgentPolicy) : bool {
        arg0.revoked
    }

    public fun owner(arg0: &AgentPolicy) : address {
        arg0.owner
    }

    public fun per_tx_cap(arg0: &AgentPolicy) : u64 {
        arg0.per_tx_cap
    }

    public fun remaining_budget(arg0: &AgentPolicy) : u64 {
        arg0.remaining_budget
    }

    public fun revoke(arg0: &mut AgentPolicy, arg1: &OwnerCap) {
        assert_owner(arg0, arg1);
        arg0.revoked = true;
        let v0 = PolicyRevoked{policy_id: 0x2::object::id<AgentPolicy>(arg0)};
        0x2::event::emit<PolicyRevoked>(v0);
    }

    public fun top_up(arg0: &mut AgentPolicy, arg1: &OwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        arg0.remaining_budget = arg0.remaining_budget + arg2;
        let v0 = ToppedUp{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            added     : arg2,
            remaining : arg0.remaining_budget,
        };
        0x2::event::emit<ToppedUp>(v0);
    }

    public fun total_spent(arg0: &AgentPolicy) : u64 {
        arg0.total_spent
    }

    // decompiled from Move bytecode v6
}

