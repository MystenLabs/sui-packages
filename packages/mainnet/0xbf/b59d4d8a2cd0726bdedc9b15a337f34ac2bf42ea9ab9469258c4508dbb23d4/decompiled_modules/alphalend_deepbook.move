module 0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook {
    struct ProtocolState has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        version: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolCreatedEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
    }

    fun check_and_upgrade_version(arg0: &mut ProtocolState) {
        assert!(arg0.version <= 1, 1);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun create_pool<T0: drop>(arg0: &AdminCap, arg1: &mut ProtocolState, arg2: &mut 0x2::coin_registry::CoinRegistry, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x2::clock::Clock, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        check_and_upgrade_version(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg1.pools, v0), 0);
        let v1 = 0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::create<T0>(arg2, arg4, arg3, arg5, arg6, arg7);
        let v2 = 0x2::object::id<0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::Pool<T0>>(&v1);
        0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::share_pool<T0>(v1);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg1.pools, v0, v2);
        let v3 = PoolCreatedEvent{
            coin_type : v0,
            pool_id   : v2,
        };
        0x2::event::emit<PoolCreatedEvent>(v3);
    }

    public fun create_pool_admin_cap<T0>(arg0: &AdminCap, arg1: &0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::PoolAdminCap<T0> {
        0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::assert_version<T0>(arg1);
        0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::create_pool_admin_cap<T0>(arg1, arg2)
    }

    public fun disable_pool_admin_cap<T0>(arg0: &AdminCap, arg1: &mut 0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::Pool<T0>, arg2: 0x2::object::ID) {
        0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::check_and_upgrade_version<T0>(arg1);
        0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool::disable_pool_admin_cap<T0>(arg1, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolState{
            id      : 0x2::object::new(arg0),
            pools   : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<ProtocolState>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

