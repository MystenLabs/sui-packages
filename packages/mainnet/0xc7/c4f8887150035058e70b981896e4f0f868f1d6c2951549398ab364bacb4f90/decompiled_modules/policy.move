module 0x250880a4c1a268da8011b164f599d4e100cefce84f862d36396cd1a943ee8a35::policy {
    struct AgentPolicy has key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        budget_mist: u64,
        spent_mist: u64,
        max_per_tx_mist: u64,
        max_slippage_bps: u64,
        allowed_coins: vector<vector<u8>>,
        allowed_protocols: vector<address>,
        expiry_ms: u64,
        revoked: bool,
        created_ms: u64,
    }

    struct PolicyOwnerCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct ActionReceipt has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        agent: address,
        kind: 0x1::string::String,
        coin_type: vector<u8>,
        protocol: address,
        amount_mist: u64,
        spent_after_mist: u64,
        memo: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        agent: address,
        budget_mist: u64,
        max_per_tx_mist: u64,
        expiry_ms: u64,
    }

    struct ActionRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        agent: address,
        kind: 0x1::string::String,
        amount_mist: u64,
        spent_after_mist: u64,
        timestamp_ms: u64,
    }

    struct PolicyRevoked has copy, drop {
        policy_id: 0x2::object::ID,
        by: address,
    }

    struct BudgetToppedUp has copy, drop {
        policy_id: 0x2::object::ID,
        added_mist: u64,
        budget_mist: u64,
    }

    struct AgentRotated has copy, drop {
        policy_id: 0x2::object::ID,
        old_agent: address,
        new_agent: address,
    }

    public fun agent(arg0: &AgentPolicy) : address {
        arg0.agent
    }

    public fun allowed_coins(arg0: &AgentPolicy) : vector<vector<u8>> {
        arg0.allowed_coins
    }

    public fun allowed_protocols(arg0: &AgentPolicy) : vector<address> {
        arg0.allowed_protocols
    }

    public fun budget_mist(arg0: &AgentPolicy) : u64 {
        arg0.budget_mist
    }

    fun coin_allowed(arg0: &AgentPolicy, arg1: &vector<u8>) : bool {
        0x1::vector::is_empty<vector<u8>>(&arg0.allowed_coins) || 0x1::vector::contains<vector<u8>>(&arg0.allowed_coins, arg1)
    }

    entry fun create_policy(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<address>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_policy(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<PolicyOwnerCap>(v1, 0x2::tx_context::sender(arg8));
        0x2::transfer::share_object<AgentPolicy>(v0);
    }

    public fun enforce_spend<T0>(arg0: &mut AgentPolicy, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : ActionReceipt {
        assert!(0x2::tx_context::sender(arg6) == arg0.agent, 0);
        assert!(!arg0.revoked, 1);
        assert!(arg1 > 0, 8);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg0.expiry_ms == 0 || v0 <= arg0.expiry_ms, 2);
        assert!(arg1 <= arg0.max_per_tx_mist, 3);
        assert!(arg0.spent_mist + arg1 <= arg0.budget_mist, 4);
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        assert!(coin_allowed(arg0, &v1), 5);
        assert!(protocol_allowed(arg0, arg2), 6);
        arg0.spent_mist = arg0.spent_mist + arg1;
        let v2 = ActionReceipt{
            id               : 0x2::object::new(arg6),
            policy_id        : 0x2::object::id<AgentPolicy>(arg0),
            agent            : arg0.agent,
            kind             : 0x1::string::utf8(arg3),
            coin_type        : v1,
            protocol         : arg2,
            amount_mist      : arg1,
            spent_after_mist : arg0.spent_mist,
            memo             : 0x1::string::utf8(arg4),
            timestamp_ms     : v0,
        };
        let v3 = ActionRecorded{
            policy_id        : 0x2::object::id<AgentPolicy>(arg0),
            receipt_id       : 0x2::object::id<ActionReceipt>(&v2),
            agent            : arg0.agent,
            kind             : v2.kind,
            amount_mist      : arg1,
            spent_after_mist : arg0.spent_mist,
            timestamp_ms     : v0,
        };
        0x2::event::emit<ActionRecorded>(v3);
        v2
    }

    public fun expiry_ms(arg0: &AgentPolicy) : u64 {
        arg0.expiry_ms
    }

    public fun is_expired(arg0: &AgentPolicy, arg1: &0x2::clock::Clock) : bool {
        arg0.expiry_ms != 0 && 0x2::clock::timestamp_ms(arg1) > arg0.expiry_ms
    }

    public fun is_revoked(arg0: &AgentPolicy) : bool {
        arg0.revoked
    }

    public fun max_per_tx_mist(arg0: &AgentPolicy) : u64 {
        arg0.max_per_tx_mist
    }

    public fun max_slippage_bps(arg0: &AgentPolicy) : u64 {
        arg0.max_slippage_bps
    }

    public fun new_policy(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: vector<vector<u8>>, arg5: vector<address>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (AgentPolicy, PolicyOwnerCap) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = AgentPolicy{
            id                : 0x2::object::new(arg8),
            owner             : v0,
            agent             : arg0,
            budget_mist       : arg1,
            spent_mist        : 0,
            max_per_tx_mist   : arg2,
            max_slippage_bps  : arg3,
            allowed_coins     : arg4,
            allowed_protocols : arg5,
            expiry_ms         : arg6,
            revoked           : false,
            created_ms        : 0x2::clock::timestamp_ms(arg7),
        };
        let v2 = 0x2::object::id<AgentPolicy>(&v1);
        let v3 = PolicyOwnerCap{
            id        : 0x2::object::new(arg8),
            policy_id : v2,
        };
        let v4 = PolicyCreated{
            policy_id       : v2,
            owner           : v0,
            agent           : arg0,
            budget_mist     : arg1,
            max_per_tx_mist : arg2,
            expiry_ms       : arg6,
        };
        0x2::event::emit<PolicyCreated>(v4);
        (v1, v3)
    }

    public fun owner(arg0: &AgentPolicy) : address {
        arg0.owner
    }

    public fun owner_cap_policy_id(arg0: &PolicyOwnerCap) : 0x2::object::ID {
        arg0.policy_id
    }

    fun protocol_allowed(arg0: &AgentPolicy, arg1: address) : bool {
        0x1::vector::is_empty<address>(&arg0.allowed_protocols) || 0x1::vector::contains<address>(&arg0.allowed_protocols, &arg1)
    }

    public fun receipt_amount_mist(arg0: &ActionReceipt) : u64 {
        arg0.amount_mist
    }

    public fun receipt_policy_id(arg0: &ActionReceipt) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun receipt_spent_after_mist(arg0: &ActionReceipt) : u64 {
        arg0.spent_after_mist
    }

    entry fun record_action<T0>(arg0: &mut AgentPolicy, arg1: u64, arg2: address, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.owner;
        0x2::transfer::public_transfer<ActionReceipt>(enforce_spend<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
    }

    public fun remaining_mist(arg0: &AgentPolicy) : u64 {
        arg0.budget_mist - arg0.spent_mist
    }

    entry fun revoke(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.policy_id == 0x2::object::id<AgentPolicy>(arg0), 7);
        arg0.revoked = true;
        let v0 = PolicyRevoked{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<PolicyRevoked>(v0);
    }

    entry fun rotate_agent(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: address) {
        assert!(arg1.policy_id == 0x2::object::id<AgentPolicy>(arg0), 7);
        arg0.agent = arg2;
        let v0 = AgentRotated{
            policy_id : 0x2::object::id<AgentPolicy>(arg0),
            old_agent : arg0.agent,
            new_agent : arg2,
        };
        0x2::event::emit<AgentRotated>(v0);
    }

    public fun share_policy(arg0: AgentPolicy) {
        0x2::transfer::share_object<AgentPolicy>(arg0);
    }

    public fun spent_mist(arg0: &AgentPolicy) : u64 {
        arg0.spent_mist
    }

    entry fun top_up(arg0: &mut AgentPolicy, arg1: &PolicyOwnerCap, arg2: u64) {
        assert!(arg1.policy_id == 0x2::object::id<AgentPolicy>(arg0), 7);
        arg0.budget_mist = arg0.budget_mist + arg2;
        let v0 = BudgetToppedUp{
            policy_id   : 0x2::object::id<AgentPolicy>(arg0),
            added_mist  : arg2,
            budget_mist : arg0.budget_mist,
        };
        0x2::event::emit<BudgetToppedUp>(v0);
    }

    public fun would_allow<T0>(arg0: &AgentPolicy, arg1: u64, arg2: address, arg3: &0x2::clock::Clock) : bool {
        if (!arg0.revoked) {
            if (arg1 > 0) {
                if (arg0.expiry_ms == 0 || 0x2::clock::timestamp_ms(arg3) <= arg0.expiry_ms) {
                    if (arg1 <= arg0.max_per_tx_mist) {
                        if (arg0.spent_mist + arg1 <= arg0.budget_mist) {
                            let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
                            if (coin_allowed(arg0, &v1)) {
                                protocol_allowed(arg0, arg2)
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    // decompiled from Move bytecode v7
}

