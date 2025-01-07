module 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::factory {
    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        sale_type: 0x1::type_name::TypeName,
        raise_type: 0x1::type_name::TypeName,
    }

    struct Pools has store, key {
        id: 0x2::object::UID,
        list: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, PoolInfo>,
        index: u64,
    }

    struct InitFactoryEvent has copy, drop {
        pools_id: 0x2::object::ID,
    }

    public fun coin_types(arg0: &PoolInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.sale_type, arg0.raise_type)
    }

    public fun create_oversubscribe_pool<T0, T1>(arg0: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::AdminCap, arg1: &0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::PackageVersion, arg2: &mut Pools, arg3: address, arg4: u128, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u128, arg14: u128, arg15: u32, arg16: 0x2::coin::Coin<T0>, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::config::checked_package_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 2);
        let v2 = new_pool_key(v0, v1);
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, PoolInfo>(&arg2.list, v2), 1);
        let (v3, v4) = 0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::oversubscribe_pool::create<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19);
        let v5 = PoolInfo{
            pool_id    : v4,
            pool_key   : v2,
            sale_type  : v0,
            raise_type : v1,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, PoolInfo>(&mut arg2.list, v2, v5);
        arg2.index = arg2.index + 1;
        0x2::transfer::public_share_object<0xac7093698643ce89fddb169487d5c5680d30cb8a83b3a62a65a95e7ff48f8e6a::oversubscribe_pool::OversubcribePool<T0, T1>>(v3);
    }

    public fun index(arg0: &Pools) : u64 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_pools(arg0);
        0x2::transfer::share_object<Pools>(v0);
        let v2 = InitFactoryEvent{pools_id: v1};
        0x2::event::emit<InitFactoryEvent>(v2);
    }

    fun new_pool_key(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) : 0x2::object::ID {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(arg0));
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(arg1)));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(0x1::string::bytes(&v0)))
    }

    fun new_pools(arg0: &mut 0x2::tx_context::TxContext) : (Pools, 0x2::object::ID) {
        let v0 = 0x2::object::new(arg0);
        let v1 = Pools{
            id    : v0,
            list  : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, PoolInfo>(arg0),
            index : 0,
        };
        (v1, 0x2::object::uid_to_inner(&v0))
    }

    public fun pool_id(arg0: &PoolInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_key(arg0: &PoolInfo) : 0x2::object::ID {
        arg0.pool_key
    }

    public fun pool_simple_info(arg0: &Pools, arg1: 0x2::object::ID) : &PoolInfo {
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<0x2::object::ID, PoolInfo>(&arg0.list, arg1)
    }

    // decompiled from Move bytecode v6
}

