module 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::delegation {
    struct DelegationCap has store, key {
        id: 0x2::object::UID,
        parent_passport: 0x2::object::ID,
        parent_owner: address,
        parent_runtime: address,
        child_agent: address,
        allowed_skills: vector<vector<u8>>,
        allowed_capabilities: vector<vector<u8>>,
        spend_limit: u64,
        spent: u64,
        expiry_ms: u64,
        revoked: bool,
    }

    struct DelegationGranted has copy, drop {
        cap_id: 0x2::object::ID,
        parent_passport: 0x2::object::ID,
        parent_owner: address,
        child_agent: address,
        spend_limit: u64,
        expiry_ms: u64,
    }

    struct DelegationRevoked has copy, drop {
        cap_id: 0x2::object::ID,
        parent_owner: address,
        child_agent: address,
    }

    struct DelegationConsumed has copy, drop {
        cap_id: 0x2::object::ID,
        amount: u64,
        new_spent: u64,
    }

    public fun allowed_capabilities(arg0: &DelegationCap) : vector<vector<u8>> {
        arg0.allowed_capabilities
    }

    public fun allowed_skills(arg0: &DelegationCap) : vector<vector<u8>> {
        arg0.allowed_skills
    }

    public fun assert_valid(arg0: &DelegationCap, arg1: &0x2::clock::Clock, arg2: vector<u8>) {
        assert!(!arg0.revoked, 3);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.expiry_ms, 4);
        if (!0x1::vector::is_empty<vector<u8>>(&arg0.allowed_skills)) {
            let v0 = false;
            let v1 = 0;
            while (v1 < 0x1::vector::length<vector<u8>>(&arg0.allowed_skills)) {
                if (*0x1::vector::borrow<vector<u8>>(&arg0.allowed_skills, v1) == arg2) {
                    v0 = true;
                    break
                };
                v1 = v1 + 1;
            };
            assert!(v0, 6);
        };
    }

    public fun child_agent(arg0: &DelegationCap) : address {
        arg0.child_agent
    }

    public fun consume(arg0: &mut DelegationCap, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(!arg0.revoked, 3);
        assert!(arg0.child_agent == 0x2::tx_context::sender(arg2), 7);
        assert!(arg0.spent + arg1 <= arg0.spend_limit, 5);
        arg0.spent = arg0.spent + arg1;
        let v0 = DelegationConsumed{
            cap_id    : 0x2::object::id<DelegationCap>(arg0),
            amount    : arg1,
            new_spent : arg0.spent,
        };
        0x2::event::emit<DelegationConsumed>(v0);
    }

    public fun expiry_ms(arg0: &DelegationCap) : u64 {
        arg0.expiry_ms
    }

    public fun grant(arg0: &0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport, arg1: address, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : DelegationCap {
        let v0 = 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::owner(arg0);
        let v1 = 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::runtime_wallet(arg0);
        let v2 = 0x2::tx_context::sender(arg6);
        assert!(v2 == v0 || v2 == v1, 1);
        assert!(0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::is_active(arg0), 2);
        let v3 = DelegationCap{
            id                   : 0x2::object::new(arg6),
            parent_passport      : 0x2::object::id<0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport>(arg0),
            parent_owner         : v0,
            parent_runtime       : v1,
            child_agent          : arg1,
            allowed_skills       : arg2,
            allowed_capabilities : arg3,
            spend_limit          : arg4,
            spent                : 0,
            expiry_ms            : arg5,
            revoked              : false,
        };
        let v4 = DelegationGranted{
            cap_id          : 0x2::object::id<DelegationCap>(&v3),
            parent_passport : 0x2::object::id<0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport>(arg0),
            parent_owner    : v0,
            child_agent     : arg1,
            spend_limit     : arg4,
            expiry_ms       : arg5,
        };
        0x2::event::emit<DelegationGranted>(v4);
        v3
    }

    public fun is_expired(arg0: &DelegationCap, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.expiry_ms
    }

    public fun is_revoked(arg0: &DelegationCap) : bool {
        arg0.revoked
    }

    public fun parent_owner(arg0: &DelegationCap) : address {
        arg0.parent_owner
    }

    public fun parent_passport(arg0: &DelegationCap) : 0x2::object::ID {
        arg0.parent_passport
    }

    public fun parent_runtime(arg0: &DelegationCap) : address {
        arg0.parent_runtime
    }

    public fun record_subagent_execution(arg0: &mut 0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport, arg1: &DelegationCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg1.revoked, 3);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1.expiry_ms, 4);
        assert!(arg1.child_agent == 0x2::tx_context::sender(arg3), 7);
        assert!(arg1.parent_passport == 0x2::object::id<0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::AgentPassport>(arg0), 8);
        0xe4e30b29e4aca4566e496bf3e221b32e33de92318a8d8992fe36df47f1530693::agent_passport::record_execution_internal(arg0);
    }

    public fun revoke(arg0: &mut DelegationCap, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.parent_owner || v0 == arg0.parent_runtime, 1);
        arg0.revoked = true;
        let v1 = DelegationRevoked{
            cap_id       : 0x2::object::id<DelegationCap>(arg0),
            parent_owner : arg0.parent_owner,
            child_agent  : arg0.child_agent,
        };
        0x2::event::emit<DelegationRevoked>(v1);
    }

    public fun spend_limit(arg0: &DelegationCap) : u64 {
        arg0.spend_limit
    }

    public fun spent(arg0: &DelegationCap) : u64 {
        arg0.spent
    }

    // decompiled from Move bytecode v7
}

