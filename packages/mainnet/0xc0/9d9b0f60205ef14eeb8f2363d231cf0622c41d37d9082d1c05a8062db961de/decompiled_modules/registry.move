module 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::bag::Bag,
    }

    struct PoolKey has copy, drop, store {
        base: 0x1::ascii::String,
        quote: 0x1::ascii::String,
    }

    public fun get_pool_id<T0, T1>(arg0: &Registry) : 0x2::object::ID {
        let v0 = PoolKey{
            base  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        assert!(0x2::bag::contains<PoolKey>(&arg0.pools, v0), 2);
        *0x2::bag::borrow<PoolKey, 0x2::object::ID>(&arg0.pools, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun register_pool<T0, T1>(arg0: &mut Registry, arg1: 0x2::object::ID) {
        let v0 = PoolKey{
            base  : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            quote : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
        };
        assert!(!0x2::bag::contains<PoolKey>(&arg0.pools, v0), 1);
        let v1 = PoolKey{
            base  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        assert!(!0x2::bag::contains<PoolKey>(&arg0.pools, v1), 1);
        0x2::bag::add<PoolKey, 0x2::object::ID>(&mut arg0.pools, v1, arg1);
    }

    public(friend) fun unregister_pool<T0, T1>(arg0: &mut Registry) {
        let v0 = PoolKey{
            base  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            quote : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        assert!(0x2::bag::contains<PoolKey>(&arg0.pools, v0), 2);
        0x2::bag::remove<PoolKey, 0x2::object::ID>(&mut arg0.pools, v0);
    }

    // decompiled from Move bytecode v6
}

