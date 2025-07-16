module 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::factory {
    struct PoolSimpleInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct Pools has store, key {
        id: 0x2::object::UID,
        list: 0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::LinkedTable<0x2::object::ID, PoolSimpleInfo>,
        index: u64,
    }

    struct InitFactoryEvent has copy, drop {
        pools_id: 0x2::object::ID,
    }

    struct CreatePoolEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type_a: 0x1::string::String,
        coin_type_b: 0x1::string::String,
        tick_spacing: u32,
        initialize_price: u128,
    }

    public fun coin_types(arg0: &PoolSimpleInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public fun create_pool<T0, T1>(arg0: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::checked_package_version(arg0);
        assert!(0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::is_in_whitelist<T0>(arg0) || 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::is_in_whitelist<T1>(arg0), 1);
        let v0 = create_pool_internal<T0, T1>(arg1, arg0, arg2, arg3, arg4, arg11, arg12);
        let v1 = 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::open_position<T0, T1>(arg0, &mut v0, arg5, arg6, arg9, arg12);
        let v2 = 0x2::coin::value<T0>(&arg7);
        let v3 = 0x2::coin::value<T1>(&arg8);
        let v4 = if (arg10) {
            v2
        } else {
            v3
        };
        let v5 = 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::add_liquidity_fix_coin<T0, T1>(arg0, &mut v0, &mut v1, v4, arg10, arg11);
        let (v6, v7) = 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::add_liquidity_pay_amount<T0, T1>(&v5);
        assert!(v6 > 0, 16);
        assert!(v7 > 0, 16);
        assert!(0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::liquidity<T0, T1>(&v0) > 0, 16);
        if (arg10) {
            assert!(v7 <= v3, 4);
        } else {
            assert!(v6 <= v2, 5);
        };
        0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::repay_add_liquidity<T0, T1>(arg0, &mut v0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg7, v6, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg8, v7, arg12)), v5);
        0x2::transfer::public_share_object<0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>>(v0);
        (v1, arg7, arg8)
    }

    fun create_pool_internal<T0, T1>(arg0: &mut Pools, arg1: &0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1> {
        assert!(arg3 > 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::tick_math::min_sqrt_price() && arg3 < 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::tick_math::max_sqrt_price(), 2);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 3);
        let v2 = new_pool_key<T0, T1>(arg2);
        if (0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.list, v2)) {
            abort 1
        };
        let v3 = if (0x1::string::length(&arg4) == 0) {
            0x1::string::utf8(b"https://m.media-amazon.com/images/I/717-+5W5VSL.jpg")
        } else {
            arg4
        };
        let v4 = 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::new<T0, T1>(arg2, arg3, 0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::config::get_fee_rate(arg2, arg1), v3, arg0.index, arg5, arg6);
        arg0.index = arg0.index + 1;
        let v5 = 0x2::object::id<0x677a8ee8489097070f95ffdac5c385ee1ee84e1056ea3d29ede5e09f3e612420::pool::Pool<T0, T1>>(&v4);
        let v6 = PoolSimpleInfo{
            pool_id      : v5,
            pool_key     : v2,
            coin_type_a  : v0,
            coin_type_b  : v1,
            tick_spacing : arg2,
        };
        0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::push_back<0x2::object::ID, PoolSimpleInfo>(&mut arg0.list, v2, v6);
        let v7 = CreatePoolEvent{
            pool_id          : v5,
            coin_type_a      : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b      : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            tick_spacing     : arg2,
            initialize_price : arg3,
        };
        0x2::event::emit<CreatePoolEvent>(v7);
        v4
    }

    public fun fetch_pools(arg0: &Pools, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PoolSimpleInfo> {
        let v0 = 0x1::vector::empty<PoolSimpleInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::head<0x2::object::ID, PoolSimpleInfo>(&arg0.list)
        } else {
            0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::next<0x2::object::ID, PoolSimpleInfo>(0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::borrow_node<0x2::object::ID, PoolSimpleInfo>(&arg0.list, *0x1::vector::borrow<0x2::object::ID>(&arg1, 0)))
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v2) && v3 < arg2) {
            let v4 = 0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::borrow_node<0x2::object::ID, PoolSimpleInfo>(&arg0.list, *0x1::option::borrow<0x2::object::ID>(&v2));
            v2 = 0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::next<0x2::object::ID, PoolSimpleInfo>(v4);
            0x1::vector::push_back<PoolSimpleInfo>(&mut v0, *0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::borrow_value<0x2::object::ID, PoolSimpleInfo>(v4));
            v3 = v3 + 1;
        };
        v0
    }

    public fun index(arg0: &Pools) : u64 {
        arg0.index
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pools{
            id    : 0x2::object::new(arg0),
            list  : 0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::new<0x2::object::ID, PoolSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Pools>(v0);
        let v1 = InitFactoryEvent{pools_id: 0x2::object::id<Pools>(&v0)};
        0x2::event::emit<InitFactoryEvent>(v1);
    }

    public fun new_pool_key<T0, T1>(arg0: u32) : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0;
        let v5 = false;
        while (v4 < 0x1::vector::length<u8>(&v3)) {
            let v6 = *0x1::vector::borrow<u8>(&v3, v4);
            if (!v5 && v4 < 0x1::vector::length<u8>(&v1)) {
                let v7 = *0x1::vector::borrow<u8>(&v1, v4);
                if (v7 < v6) {
                    abort 6
                };
                if (v7 > v6) {
                    v5 = true;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v6);
            v4 = v4 + 1;
        };
        if (!v5) {
            if (0x1::vector::length<u8>(&v1) < 0x1::vector::length<u8>(&v3)) {
                abort 6
            };
            if (0x1::vector::length<u8>(&v1) == 0x1::vector::length<u8>(&v3)) {
                abort 3
            };
        };
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u32>(&arg0));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun pool_id(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_key(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_key
    }

    public fun pool_simple_info(arg0: &Pools, arg1: 0x2::object::ID) : &PoolSimpleInfo {
        0x9fa2e28f4edf66743ee175237c70245dadd3ee1aee4545eaf8e010b197fb2326::linked_table::borrow<0x2::object::ID, PoolSimpleInfo>(&arg0.list, arg1)
    }

    public fun tick_spacing(arg0: &PoolSimpleInfo) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v6
}

