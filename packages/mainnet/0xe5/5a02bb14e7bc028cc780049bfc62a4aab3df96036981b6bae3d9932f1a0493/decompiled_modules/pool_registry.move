module 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::pool_registry {
    struct PoolKey has copy, drop, store {
        protocol: 0x1::string::String,
        asset_type: 0x1::type_name::TypeName,
        pool_id: 0x1::option::Option<0x1::string::String>,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<PoolKey, bool>,
    }

    public fun assert_pool_enabled<T0>(arg0: &PoolRegistry, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>) {
        let v0 = PoolKey{
            protocol   : arg1,
            asset_type : 0x1::type_name::with_defining_ids<T0>(),
            pool_id    : arg2,
        };
        assert!(0x2::table::contains<PoolKey, bool>(&arg0.pools, v0), 201);
        assert!(*0x2::table::borrow<PoolKey, bool>(&arg0.pools, v0), 202);
    }

    public fun disable_pool<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: &mut PoolRegistry, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>) {
        let v0 = PoolKey{
            protocol   : arg2,
            asset_type : 0x1::type_name::with_defining_ids<T0>(),
            pool_id    : arg3,
        };
        assert!(0x2::table::contains<PoolKey, bool>(&arg1.pools, v0), 201);
        *0x2::table::borrow_mut<PoolKey, bool>(&mut arg1.pools, v0) = false;
    }

    public fun enable_pool<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: &mut PoolRegistry, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>) {
        let v0 = PoolKey{
            protocol   : arg2,
            asset_type : 0x1::type_name::with_defining_ids<T0>(),
            pool_id    : arg3,
        };
        assert!(0x2::table::contains<PoolKey, bool>(&arg1.pools, v0), 201);
        *0x2::table::borrow_mut<PoolKey, bool>(&mut arg1.pools, v0) = true;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<PoolKey, bool>(arg0),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    public fun is_pool_enabled<T0>(arg0: &PoolRegistry, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>) : bool {
        let v0 = PoolKey{
            protocol   : arg1,
            asset_type : 0x1::type_name::with_defining_ids<T0>(),
            pool_id    : arg2,
        };
        0x2::table::contains<PoolKey, bool>(&arg0.pools, v0) && *0x2::table::borrow<PoolKey, bool>(&arg0.pools, v0)
    }

    public fun register_pool<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: &mut PoolRegistry, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x1::string::String>) {
        let v0 = PoolKey{
            protocol   : arg2,
            asset_type : 0x1::type_name::with_defining_ids<T0>(),
            pool_id    : arg3,
        };
        assert!(!0x2::table::contains<PoolKey, bool>(&arg1.pools, v0), 200);
        0x2::table::add<PoolKey, bool>(&mut arg1.pools, v0, true);
    }

    // decompiled from Move bytecode v6
}

