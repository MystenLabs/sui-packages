module 0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::factory {
    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        sale_coin: 0x1::type_name::TypeName,
        raise_coin: 0x1::type_name::TypeName,
    }

    struct Pools has store, key {
        id: 0x2::object::UID,
        pool_list: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PoolInfo>,
        index: u64,
    }

    struct InitFactoryEvent has copy, drop {
        pools_id: 0x2::object::ID,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        sale_coin: 0x1::type_name::TypeName,
        raise_coin: 0x1::type_name::TypeName,
    }

    public fun create_pool<T0, T1>(arg0: &0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::config::AdminCap, arg1: &0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::config::ConfigVersion, arg2: address, arg3: &mut Pools, arg4: u128, arg5: 0x2::balance::Balance<T0>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: u64, arg17: u32, arg18: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 2);
        let v2 = new_pool_key<T0, T1>();
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolInfo>(&arg3.pool_list, v2)) {
            abort 1
        };
        let v3 = 0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::pool::initialize<T0, T1>(arg1, arg2, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18);
        let v4 = 0x2::object::id<0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::pool::Pool<T0, T1>>(&v3);
        let v5 = PoolInfo{
            pool_id    : v4,
            pool_key   : v2,
            sale_coin  : v0,
            raise_coin : v1,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PoolInfo>(&mut arg3.pool_list, v2, v5);
        arg3.index = arg3.index + 1;
        let v6 = CreatePoolEvent{
            pool_id    : v4,
            sale_coin  : 0x1::type_name::get<T0>(),
            raise_coin : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<CreatePoolEvent>(v6);
        0x2::transfer::public_share_object<0x68aac2d6a88bc1e868c48ee99918b71373877308f7e63cb22ac1971cad9d6e67::pool::Pool<T0, T1>>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_pools(arg0);
        0x2::transfer::share_object<Pools>(v0);
        let v2 = InitFactoryEvent{pools_id: v1};
        0x2::event::emit<InitFactoryEvent>(v2);
    }

    fun new_pool_key<T0, T1>() : 0x2::object::ID {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T1>())));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(0x1::string::bytes(&v0)))
    }

    fun new_pools(arg0: &mut 0x2::tx_context::TxContext) : (Pools, 0x2::object::ID) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Pools{
            id        : v0,
            pool_list : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PoolInfo>(arg0),
            index     : 0,
        };
        (v1, 0x2::object::uid_to_inner(&v0))
    }

    // decompiled from Move bytecode v6
}

