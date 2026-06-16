module 0x26e5c029a07f74308d2a72002f09c54affd5b0914e401de25480046f45316885::policy {
    struct AgentPolicy<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        agent: address,
        budget: 0x2::balance::Balance<T0>,
        total_deposited: u64,
        spent: u64,
        max_per_tx: u64,
        max_slippage_bps: u64,
        allowed_protocols: vector<0x1::string::String>,
        expiry_ms: u64,
        revoked: bool,
        nonce: u64,
    }

    struct AgentCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct ActionReceipt has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        seq: u64,
        agent: address,
        protocol: 0x1::string::String,
        summary: 0x1::string::String,
        amount: u64,
        coin_type: 0x1::string::String,
        status: 0x1::string::String,
        walrus_blob: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
        agent: address,
        max_per_tx: u64,
        expiry_ms: u64,
    }

    struct Deposited has copy, drop {
        policy_id: 0x2::object::ID,
        amount: u64,
        new_remaining: u64,
    }

    struct Spent has copy, drop {
        policy_id: 0x2::object::ID,
        seq: u64,
        protocol: 0x1::string::String,
        amount: u64,
        spent_total: u64,
        remaining: u64,
    }

    struct ActionRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        seq: u64,
        protocol: 0x1::string::String,
        status: 0x1::string::String,
        walrus_blob: 0x1::string::String,
    }

    struct Revoked has copy, drop {
        policy_id: 0x2::object::ID,
        by: address,
    }

    struct Reclaimed has copy, drop {
        policy_id: 0x2::object::ID,
        amount: u64,
    }

    public fun new<T0>(arg0: address, arg1: u64, arg2: u64, arg3: vector<0x1::string::String>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) : (AgentPolicy<T0>, AgentCap) {
        let v0 = AgentPolicy<T0>{
            id                : 0x2::object::new(arg6),
            owner             : 0x2::tx_context::sender(arg6),
            agent             : arg0,
            budget            : 0x2::coin::into_balance<T0>(arg5),
            total_deposited   : 0x2::coin::value<T0>(&arg5),
            spent             : 0,
            max_per_tx        : arg1,
            max_slippage_bps  : arg2,
            allowed_protocols : arg3,
            expiry_ms         : arg4,
            revoked           : false,
            nonce             : 0,
        };
        let v1 = 0x2::object::id<AgentPolicy<T0>>(&v0);
        let v2 = AgentCap{
            id        : 0x2::object::new(arg6),
            policy_id : v1,
        };
        let v3 = PolicyCreated{
            policy_id  : v1,
            owner      : v0.owner,
            agent      : arg0,
            max_per_tx : arg1,
            expiry_ms  : arg4,
        };
        0x2::event::emit<PolicyCreated>(v3);
        (v0, v2)
    }

    public fun agent<T0>(arg0: &AgentPolicy<T0>) : address {
        arg0.agent
    }

    public fun allowed_protocols<T0>(arg0: &AgentPolicy<T0>) : vector<0x1::string::String> {
        arg0.allowed_protocols
    }

    entry fun create<T0>(arg0: address, arg1: u64, arg2: u64, arg3: vector<0x1::string::String>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_share_object<AgentPolicy<T0>>(v0);
        0x2::transfer::public_transfer<AgentCap>(v1, arg0);
    }

    public fun deposit<T0>(arg0: &mut AgentPolicy<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.budget, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        let v1 = Deposited{
            policy_id     : 0x2::object::id<AgentPolicy<T0>>(arg0),
            amount        : v0,
            new_remaining : 0x2::balance::value<T0>(&arg0.budget),
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun expiry_ms<T0>(arg0: &AgentPolicy<T0>) : u64 {
        arg0.expiry_ms
    }

    fun is_allowed(arg0: &vector<0x1::string::String>, arg1: &0x1::string::String) : bool {
        if (0x1::vector::is_empty<0x1::string::String>(arg0)) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(arg0)) {
            if (*0x1::vector::borrow<0x1::string::String>(arg0, v0) == *arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_revoked<T0>(arg0: &AgentPolicy<T0>) : bool {
        arg0.revoked
    }

    public fun max_per_tx<T0>(arg0: &AgentPolicy<T0>) : u64 {
        arg0.max_per_tx
    }

    public fun max_slippage_bps<T0>(arg0: &AgentPolicy<T0>) : u64 {
        arg0.max_slippage_bps
    }

    public fun nonce<T0>(arg0: &AgentPolicy<T0>) : u64 {
        arg0.nonce
    }

    public fun owner<T0>(arg0: &AgentPolicy<T0>) : address {
        arg0.owner
    }

    public fun reclaim<T0>(arg0: &mut AgentPolicy<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13906835449948667905);
        let v0 = 0x2::balance::value<T0>(&arg0.budget);
        let v1 = Reclaimed{
            policy_id : 0x2::object::id<AgentPolicy<T0>>(arg0),
            amount    : v0,
        };
        0x2::event::emit<Reclaimed>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.budget, v0), arg1)
    }

    entry fun reclaim_all<T0>(arg0: &mut AgentPolicy<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = reclaim<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun record<T0>(arg0: &mut AgentPolicy<T0>, arg1: &AgentCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.policy_id == 0x2::object::id<AgentPolicy<T0>>(arg0), 13906835303919910915);
        let v0 = ActionReceipt{
            id           : 0x2::object::new(arg9),
            policy_id    : 0x2::object::id<AgentPolicy<T0>>(arg0),
            seq          : arg0.nonce,
            agent        : arg0.agent,
            protocol     : arg2,
            summary      : arg3,
            amount       : arg4,
            coin_type    : arg5,
            status       : arg6,
            walrus_blob  : arg7,
            timestamp_ms : 0x2::clock::timestamp_ms(arg8),
        };
        let v1 = ActionRecorded{
            policy_id   : v0.policy_id,
            receipt_id  : 0x2::object::id<ActionReceipt>(&v0),
            seq         : v0.seq,
            protocol    : v0.protocol,
            status      : v0.status,
            walrus_blob : v0.walrus_blob,
        };
        0x2::event::emit<ActionRecorded>(v1);
        0x2::transfer::freeze_object<ActionReceipt>(v0);
    }

    public fun remaining<T0>(arg0: &AgentPolicy<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.budget)
    }

    public fun revoke<T0>(arg0: &mut AgentPolicy<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13906835419883896833);
        arg0.revoked = true;
        let v0 = Revoked{
            policy_id : 0x2::object::id<AgentPolicy<T0>>(arg0),
            by        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<Revoked>(v0);
    }

    public fun spent<T0>(arg0: &AgentPolicy<T0>) : u64 {
        arg0.spent
    }

    public fun total_deposited<T0>(arg0: &AgentPolicy<T0>) : u64 {
        arg0.total_deposited
    }

    public fun withdraw<T0>(arg0: &mut AgentPolicy<T0>, arg1: &AgentCap, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.policy_id == 0x2::object::id<AgentPolicy<T0>>(arg0), 13906835145006120963);
        assert!(!arg0.revoked, 13906835149301219333);
        if (arg0.expiry_ms != 0) {
            assert!(0x2::clock::timestamp_ms(arg4) < arg0.expiry_ms, 13906835157891284999);
        };
        assert!(arg2 <= arg0.max_per_tx, 13906835166481350665);
        assert!(arg2 <= 0x2::balance::value<T0>(&arg0.budget), 13906835170776449035);
        assert!(is_allowed(&arg0.allowed_protocols, &arg3), 13906835175071547405);
        arg0.spent = arg0.spent + arg2;
        arg0.nonce = arg0.nonce + 1;
        let v0 = Spent{
            policy_id   : 0x2::object::id<AgentPolicy<T0>>(arg0),
            seq         : arg0.nonce,
            protocol    : arg3,
            amount      : arg2,
            spent_total : arg0.spent,
            remaining   : 0x2::balance::value<T0>(&arg0.budget),
        };
        0x2::event::emit<Spent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.budget, arg2), arg5)
    }

    // decompiled from Move bytecode v7
}

