module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool_factory {
    struct POOL_FACTORY has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolFactory has key {
        id: 0x2::object::UID,
        pools: 0x2::linked_table::LinkedTable<0x2::object::ID, PoolInfo>,
    }

    struct PoolInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_a_type: 0x1::type_name::TypeName,
        coin_b_type: 0x1::type_name::TypeName,
        stable: bool,
    }

    public fun all_pools(arg0: &PoolFactory, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PoolInfo> {
        all_pools_(arg0, arg1, arg2)
    }

    fun all_pools_(arg0: &PoolFactory, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PoolInfo> {
        let v0 = 0x1::vector::empty<PoolInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x2::linked_table::front<0x2::object::ID, PoolInfo>(&arg0.pools)
        } else {
            0x2::linked_table::next<0x2::object::ID, PoolInfo>(&arg0.pools, *0x1::vector::borrow<0x2::object::ID>(&arg1, 0))
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<0x2::object::ID>(v2) && v3 < arg2) {
            let v4 = 0x2::linked_table::borrow<0x2::object::ID, PoolInfo>(&arg0.pools, *0x1::option::borrow<0x2::object::ID>(v2));
            v2 = 0x2::linked_table::next<0x2::object::ID, PoolInfo>(&arg0.pools, v4.pool_key);
            0x1::vector::push_back<PoolInfo>(&mut v0, *v4);
            v3 = v3 + 1;
        };
        v0
    }

    public fun coin_types(arg0: &PoolInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_a_type, arg0.coin_b_type)
    }

    public fun create_pool<T0, T1, T2>(arg0: &mut PoolFactory, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!has_pool<T0, T1, T2>(arg0), 0);
        0x2::transfer::public_share_object<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>>(create_pool_internal<T0, T1, T2>(arg0, 0x2::coin::get_decimals<T0>(arg1), 0x2::coin::get_decimals<T1>(arg2), arg3));
    }

    public fun create_pool_coin_currency<T0, T1, T2>(arg0: &mut PoolFactory, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin_registry::Currency<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!has_pool<T0, T1, T2>(arg0), 0);
        0x2::transfer::public_share_object<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>>(create_pool_internal<T0, T1, T2>(arg0, 0x2::coin::get_decimals<T0>(arg1), 0x2::coin_registry::decimals<T1>(arg2), arg3));
    }

    public fun create_pool_currency_coin<T0, T1, T2>(arg0: &mut PoolFactory, arg1: &0x2::coin_registry::Currency<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!has_pool<T0, T1, T2>(arg0), 0);
        0x2::transfer::public_share_object<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>>(create_pool_internal<T0, T1, T2>(arg0, 0x2::coin_registry::decimals<T0>(arg1), 0x2::coin::get_decimals<T1>(arg2), arg3));
    }

    public fun create_pool_currency_currency<T0, T1, T2>(arg0: &mut PoolFactory, arg1: &0x2::coin_registry::Currency<T0>, arg2: &0x2::coin_registry::Currency<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!has_pool<T0, T1, T2>(arg0), 0);
        0x2::transfer::public_share_object<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>>(create_pool_internal<T0, T1, T2>(arg0, 0x2::coin_registry::decimals<T0>(arg1), 0x2::coin_registry::decimals<T1>(arg2), arg3));
    }

    fun create_pool_internal<T0, T1, T2>(arg0: &mut PoolFactory, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2> {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 1);
        let v2 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>();
        let v3 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::new_pool_key<T0, T1>(v2);
        let v4 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::init_pool<T0, T1, T2>(arg1, arg2, arg3);
        let v5 = PoolInfo{
            pool_id     : 0x2::object::id<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>>(&v4),
            pool_key    : v3,
            coin_a_type : v0,
            coin_b_type : v1,
            stable      : v2,
        };
        0x2::linked_table::push_back<0x2::object::ID, PoolInfo>(&mut arg0.pools, v3, v5);
        v4
    }

    public fun has_pool<T0, T1, T2>(arg0: &PoolFactory) : bool {
        0x2::linked_table::contains<0x2::object::ID, PoolInfo>(&arg0.pools, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::new_pool_key<T0, T1>(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>()))
    }

    fun init(arg0: POOL_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolFactory{
            id    : 0x2::object::new(arg1),
            pools : 0x2::linked_table::new<0x2::object::ID, PoolInfo>(arg1),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<PoolFactory>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun pool_info<T0, T1, T2>(arg0: &PoolFactory) : PoolInfo {
        *0x2::linked_table::borrow<0x2::object::ID, PoolInfo>(&arg0.pools, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::new_pool_key<T0, T1>(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>()))
    }

    // decompiled from Move bytecode v6
}

