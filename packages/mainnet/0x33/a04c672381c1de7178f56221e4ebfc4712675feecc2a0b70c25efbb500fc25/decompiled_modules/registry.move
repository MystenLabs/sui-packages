module 0x33a04c672381c1de7178f56221e4ebfc4712675feecc2a0b70c25efbb500fc25::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CapitalRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        tokens: 0x2::table::Table<address, TokenRecord>,
        launch_count: u64,
    }

    struct TokenRecord has store {
        agent: address,
        coin_type: 0x1::type_name::TypeName,
        launcher: address,
        bound_at_ms: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        lock_id: 0x1::option::Option<0x2::object::ID>,
        finalized_at_ms: 0x1::option::Option<u64>,
    }

    struct AgentTokenBound has copy, drop {
        agent: address,
        coin_type: 0x1::type_name::TypeName,
        launcher: address,
        timestamp_ms: u64,
    }

    struct AgentTokenFinalized has copy, drop {
        agent: address,
        coin_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    fun assert_launcher(arg0: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg1: address, arg2: address) {
        assert!(0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::is_registered(arg0, arg1), 2);
        let v0 = 0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::borrow_record(arg0, arg1);
        let v1 = if (arg2 == arg1) {
            true
        } else {
            let v2 = 0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::owner(v0);
            0x1::option::contains<address>(&v2, &arg2)
        };
        assert!(v1, 1);
    }

    fun assert_version(arg0: &CapitalRegistry) {
        assert!(arg0.version == 1, 3);
    }

    public fun bind<T0>(arg0: &mut CapitalRegistry, arg1: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert_launcher(arg1, arg2, v0);
        assert!(!0x2::table::contains<address, TokenRecord>(&arg0.tokens, arg2), 0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = TokenRecord{
            agent           : arg2,
            coin_type       : v2,
            launcher        : v0,
            bound_at_ms     : v1,
            pool_id         : 0x1::option::none<0x2::object::ID>(),
            lock_id         : 0x1::option::none<0x2::object::ID>(),
            finalized_at_ms : 0x1::option::none<u64>(),
        };
        0x2::table::add<address, TokenRecord>(&mut arg0.tokens, arg2, v3);
        let v4 = AgentTokenBound{
            agent        : arg2,
            coin_type    : v2,
            launcher     : v0,
            timestamp_ms : v1,
        };
        0x2::event::emit<AgentTokenBound>(v4);
    }

    public fun borrow_record(arg0: &CapitalRegistry, arg1: address) : &TokenRecord {
        0x2::table::borrow<address, TokenRecord>(&arg0.tokens, arg1)
    }

    public fun coin_type(arg0: &TokenRecord) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun finalize<T0>(arg0: &mut CapitalRegistry, arg1: &0x7669be207f9ac28a34d2cbd45dcfdade11e6fd503ad24e687c180931be9a45e9::registry::Registry, arg2: address, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_launcher(arg1, arg2, 0x2::tx_context::sender(arg6));
        assert!(0x2::table::contains<address, TokenRecord>(&arg0.tokens, arg2), 4);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x2::table::borrow_mut<address, TokenRecord>(&mut arg0.tokens, arg2);
        assert!(0x1::option::is_none<u64>(&v2.finalized_at_ms), 5);
        assert!(v2.coin_type == v1, 6);
        v2.pool_id = 0x1::option::some<0x2::object::ID>(arg3);
        v2.lock_id = 0x1::option::some<0x2::object::ID>(arg4);
        v2.finalized_at_ms = 0x1::option::some<u64>(v0);
        arg0.launch_count = arg0.launch_count + 1;
        let v3 = AgentTokenFinalized{
            agent        : arg2,
            coin_type    : v1,
            pool_id      : arg3,
            lock_id      : arg4,
            timestamp_ms : v0,
        };
        0x2::event::emit<AgentTokenFinalized>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CapitalRegistry{
            id           : 0x2::object::new(arg0),
            version      : 1,
            tokens       : 0x2::table::new<address, TokenRecord>(arg0),
            launch_count : 0,
        };
        0x2::transfer::share_object<CapitalRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_finalized(arg0: &TokenRecord) : bool {
        0x1::option::is_some<u64>(&arg0.finalized_at_ms)
    }

    public fun is_tokenized(arg0: &CapitalRegistry, arg1: address) : bool {
        0x2::table::contains<address, TokenRecord>(&arg0.tokens, arg1)
    }

    public fun launch_count(arg0: &CapitalRegistry) : u64 {
        arg0.launch_count
    }

    public fun launcher(arg0: &TokenRecord) : address {
        arg0.launcher
    }

    public fun lock_id(arg0: &TokenRecord) : 0x1::option::Option<0x2::object::ID> {
        arg0.lock_id
    }

    public fun migrate(arg0: &mut CapitalRegistry, arg1: &AdminCap) {
        assert!(arg0.version < 1, 3);
        arg0.version = 1;
    }

    public fun pool_id(arg0: &TokenRecord) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    // decompiled from Move bytecode v7
}

