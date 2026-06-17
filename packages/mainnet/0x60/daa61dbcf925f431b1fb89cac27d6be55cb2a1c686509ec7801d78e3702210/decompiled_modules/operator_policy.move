module 0x60daa61dbcf925f431b1fb89cac27d6be55cb2a1c686509ec7801d78e3702210::operator_policy {
    struct OperatorPolicy has store, key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        name: 0x1::string::String,
        budget_cap: u64,
        spent: u64,
        allowed_venues: vector<0x1::string::String>,
        max_concentration_bps: u16,
        expires_at_ms: u64,
        auto_approve_pct: u8,
        risk_tolerance: 0x1::string::String,
        revoked: bool,
        created_at_ms: u64,
    }

    struct PolicyCreated has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        agent: address,
        name: 0x1::string::String,
        budget_cap: u64,
        expires_at_ms: u64,
        created_at_ms: u64,
    }

    struct PolicySpend has copy, drop {
        policy_id: 0x2::object::ID,
        agent: address,
        amount: u64,
        venue: 0x1::string::String,
        new_spent: u64,
        ms: u64,
    }

    struct PolicyRevoked has copy, drop {
        policy_id: 0x2::object::ID,
        revoked_by: address,
        ms: u64,
    }

    struct PolicyExtended has copy, drop {
        policy_id: 0x2::object::ID,
        old_budget_cap: u64,
        new_budget_cap: u64,
        old_expires_at_ms: u64,
        new_expires_at_ms: u64,
        ms: u64,
    }

    public fun agent(arg0: &OperatorPolicy) : address {
        arg0.agent
    }

    public fun allowed_venues(arg0: &OperatorPolicy) : &vector<0x1::string::String> {
        &arg0.allowed_venues
    }

    public fun assert_can_spend(arg0: &OperatorPolicy, arg1: u64, arg2: &0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.agent, 2);
        assert!(!arg0.revoked, 3);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.expires_at_ms, 4);
        assert!(arg0.spent + arg1 <= arg0.budget_cap, 5);
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.allowed_venues, arg2), 6);
    }

    public fun auto_approve_pct(arg0: &OperatorPolicy) : u8 {
        arg0.auto_approve_pct
    }

    public fun budget_cap(arg0: &OperatorPolicy) : u64 {
        arg0.budget_cap
    }

    public fun create(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: vector<0x1::string::String>, arg4: u16, arg5: u64, arg6: u8, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg2 > 0, 7);
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg3), 7);
        assert!(arg4 > 0 && arg4 <= 10000, 7);
        assert!(arg6 <= 100, 7);
        let v0 = 0x2::tx_context::sender(arg9);
        let v1 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg5 > v1, 7);
        let v2 = OperatorPolicy{
            id                    : 0x2::object::new(arg9),
            owner                 : v0,
            agent                 : arg0,
            name                  : arg1,
            budget_cap            : arg2,
            spent                 : 0,
            allowed_venues        : arg3,
            max_concentration_bps : arg4,
            expires_at_ms         : arg5,
            auto_approve_pct      : arg6,
            risk_tolerance        : arg7,
            revoked               : false,
            created_at_ms         : v1,
        };
        let v3 = 0x2::object::id<OperatorPolicy>(&v2);
        let v4 = PolicyCreated{
            id            : v3,
            owner         : v0,
            agent         : arg0,
            name          : v2.name,
            budget_cap    : arg2,
            expires_at_ms : arg5,
            created_at_ms : v1,
        };
        0x2::event::emit<PolicyCreated>(v4);
        0x2::transfer::public_share_object<OperatorPolicy>(v2);
        v3
    }

    public fun created_at_ms(arg0: &OperatorPolicy) : u64 {
        arg0.created_at_ms
    }

    public fun expires_at_ms(arg0: &OperatorPolicy) : u64 {
        arg0.expires_at_ms
    }

    public fun extend(arg0: &mut OperatorPolicy, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 1);
        assert!(!arg0.revoked, 3);
        assert!(arg1 >= arg0.budget_cap, 8);
        assert!(arg2 >= arg0.expires_at_ms, 8);
        arg0.budget_cap = arg1;
        arg0.expires_at_ms = arg2;
        let v0 = PolicyExtended{
            policy_id         : 0x2::object::id<OperatorPolicy>(arg0),
            old_budget_cap    : arg0.budget_cap,
            new_budget_cap    : arg1,
            old_expires_at_ms : arg0.expires_at_ms,
            new_expires_at_ms : arg2,
            ms                : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PolicyExtended>(v0);
    }

    public fun max_concentration_bps(arg0: &OperatorPolicy) : u16 {
        arg0.max_concentration_bps
    }

    public fun name(arg0: &OperatorPolicy) : &0x1::string::String {
        &arg0.name
    }

    public fun owner(arg0: &OperatorPolicy) : address {
        arg0.owner
    }

    public fun record_spend(arg0: &mut OperatorPolicy, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_can_spend(arg0, arg1, &arg2, arg3, arg4);
        arg0.spent = arg0.spent + arg1;
        let v0 = PolicySpend{
            policy_id : 0x2::object::id<OperatorPolicy>(arg0),
            agent     : arg0.agent,
            amount    : arg1,
            venue     : arg2,
            new_spent : arg0.spent,
            ms        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PolicySpend>(v0);
    }

    public fun remaining(arg0: &OperatorPolicy) : u64 {
        if (arg0.spent >= arg0.budget_cap) {
            0
        } else {
            arg0.budget_cap - arg0.spent
        }
    }

    public fun revoke(arg0: &mut OperatorPolicy, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.revoked = true;
        let v0 = PolicyRevoked{
            policy_id  : 0x2::object::id<OperatorPolicy>(arg0),
            revoked_by : arg0.owner,
            ms         : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PolicyRevoked>(v0);
    }

    public fun revoked(arg0: &OperatorPolicy) : bool {
        arg0.revoked
    }

    public fun risk_tolerance(arg0: &OperatorPolicy) : &0x1::string::String {
        &arg0.risk_tolerance
    }

    public fun spent(arg0: &OperatorPolicy) : u64 {
        arg0.spent
    }

    // decompiled from Move bytecode v7
}

