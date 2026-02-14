module 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::factory {
    struct PoolSimpleInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        pool_key: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        tick_spacing: u32,
    }

    struct Pools has store, key {
        id: 0x2::object::UID,
        list: 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::LinkedTable<0x2::object::ID, PoolSimpleInfo>,
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
        fee_scheduler_enabled: bool,
        fee_scheduler_mode: 0x1::option::Option<u8>,
        dynamic_fee_enabled: bool,
        activation_timestamp: u64,
        collect_fee_mode: u8,
        is_quote_y: bool,
    }

    public fun coin_types(arg0: &PoolSimpleInfo) : (0x1::type_name::TypeName, 0x1::type_name::TypeName) {
        (arg0.coin_type_a, arg0.coin_type_b)
    }

    public fun create_pool<T0, T1>(arg0: &0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::GlobalConfig, arg1: &mut Pools, arg2: u32, arg3: u128, arg4: u32, arg5: u32, arg6: 0x1::string::String, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: bool, arg10: u8, arg11: bool, arg12: u8, arg13: bool, arg14: bool, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::position::Position, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::checked_package_version(arg0);
        assert!(!0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::global_paused(arg0), 309);
        if (!0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::get_allow_create_pair(arg0)) {
            0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::check_pool_manager_role(arg0, 0x2::tx_context::sender(arg17));
        };
        assert!(0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::is_in_whitelist<T0>(arg0) || 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::is_in_whitelist<T1>(arg0), 301);
        let (v0, v1, v2, v3) = if (arg13) {
            if (arg12 == 0) {
                0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::linear_fee_scheduler(arg0, arg2)
            } else {
                assert!(arg12 == 1, 310);
                0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::exponential_fee_scheduler(arg0, arg2)
            }
        } else {
            0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::linear_fee_scheduler(arg0, arg2)
        };
        let v4 = 0x2::clock::timestamp_ms(arg16);
        if (arg15 == 0) {
            arg15 = v4;
        };
        assert!(arg15 >= v4, 310);
        let v5 = create_pool_internal<T0, T1>(arg1, arg0, arg2, arg3, arg6, arg15, arg10, arg11, arg14, 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::filter_period(arg0, arg2), 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::decay_period(arg0, arg2), 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::reduction_factor(arg0, arg2), 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::variable_fee_control(arg0, arg2), 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::max_volatility_accumulator(arg0, arg2), arg12, arg13, v0, v1, v2, v3, arg16, arg17);
        let v6 = 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::open_position<T0, T1>(arg0, &mut v5, arg4, arg5, arg17);
        let v7 = 0x2::coin::value<T0>(&arg7);
        let v8 = 0x2::coin::value<T1>(&arg8);
        let v9 = if (arg9) {
            v7
        } else {
            v8
        };
        let v10 = 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::add_liquidity_fix_coin<T0, T1>(arg0, &mut v5, &mut v6, v9, arg9, arg16);
        let (v11, v12) = 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::add_liquidity_pay_amount<T0, T1>(&v10);
        assert!(v11 > 0 || v12 > 0, 308);
        assert!(0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::liquidity<T0, T1>(&v5) > 0, 308);
        if (arg9) {
            assert!(v12 <= v8, 304);
        } else {
            assert!(v11 <= v7, 305);
        };
        0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::repay_add_liquidity<T0, T1>(arg0, &mut v5, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg7, v11, arg17)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg8, v12, arg17)), v10);
        0x2::transfer::public_share_object<0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::Pool<T0, T1>>(v5);
        (v6, arg7, arg8)
    }

    fun create_pool_internal<T0, T1>(arg0: &mut Pools, arg1: &0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::GlobalConfig, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u64, arg6: u8, arg7: bool, arg8: bool, arg9: u16, arg10: u16, arg11: u16, arg12: u32, arg13: u32, arg14: u8, arg15: bool, arg16: u64, arg17: u16, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::Pool<T0, T1> {
        assert!(arg3 > 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::tick_math::min_sqrt_price() && arg3 < 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::tick_math::max_sqrt_price(), 302);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(v0 != v1, 303);
        let v2 = new_pool_key<T0, T1>(arg2, arg6, arg14, arg15, arg8);
        if (0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::contains<0x2::object::ID, PoolSimpleInfo>(&arg0.list, v2)) {
            abort 307
        };
        let v3 = if (0x1::string::length(&arg4) == 0) {
            0x1::string::utf8(b"https://ferra.ag/Certified-Ferra-LPer.png")
        } else {
            arg4
        };
        let v4 = 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::new<T0, T1>(arg2, arg3, 0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::config::get_fee_rate(arg2, arg1), v3, arg0.index, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21);
        arg0.index = arg0.index + 1;
        let v5 = 0x2::object::id<0x66fb6a132c415278c32ab52ecdc2bd73b08b649e396841f48f6f9cccd01b6bbb::pool::Pool<T0, T1>>(&v4);
        let v6 = PoolSimpleInfo{
            pool_id      : v5,
            pool_key     : v2,
            coin_type_a  : v0,
            coin_type_b  : v1,
            tick_spacing : arg2,
        };
        0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::push_back<0x2::object::ID, PoolSimpleInfo>(&mut arg0.list, v2, v6);
        let v7 = if (arg15) {
            0x1::option::some<u8>(arg14)
        } else {
            0x1::option::none<u8>()
        };
        let v8 = CreatePoolEvent{
            pool_id               : v5,
            coin_type_a           : 0x1::string::from_ascii(0x1::type_name::into_string(v0)),
            coin_type_b           : 0x1::string::from_ascii(0x1::type_name::into_string(v1)),
            tick_spacing          : arg2,
            initialize_price      : arg3,
            fee_scheduler_enabled : arg15,
            fee_scheduler_mode    : v7,
            dynamic_fee_enabled   : arg8,
            activation_timestamp  : arg5,
            collect_fee_mode      : arg6,
            is_quote_y            : arg7,
        };
        0x2::event::emit<CreatePoolEvent>(v8);
        v4
    }

    public fun fetch_pools(arg0: &Pools, arg1: vector<0x2::object::ID>, arg2: u64) : vector<PoolSimpleInfo> {
        let v0 = 0x1::vector::empty<PoolSimpleInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::head<0x2::object::ID, PoolSimpleInfo>(&arg0.list)
        } else {
            0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::next<0x2::object::ID, PoolSimpleInfo>(0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::borrow_node<0x2::object::ID, PoolSimpleInfo>(&arg0.list, *0x1::vector::borrow<0x2::object::ID>(&arg1, 0)))
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v2) && v3 < arg2) {
            let v4 = 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::borrow_node<0x2::object::ID, PoolSimpleInfo>(&arg0.list, *0x1::option::borrow<0x2::object::ID>(&v2));
            v2 = 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::next<0x2::object::ID, PoolSimpleInfo>(v4);
            0x1::vector::push_back<PoolSimpleInfo>(&mut v0, *0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::borrow_value<0x2::object::ID, PoolSimpleInfo>(v4));
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
            list  : 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::new<0x2::object::ID, PoolSimpleInfo>(arg0),
            index : 0,
        };
        0x2::transfer::share_object<Pools>(v0);
        let v1 = InitFactoryEvent{pools_id: 0x2::object::id<Pools>(&v0)};
        0x2::event::emit<InitFactoryEvent>(v1);
    }

    public fun new_pool_key<T0, T1>(arg0: u32, arg1: u8, arg2: u8, arg3: bool, arg4: bool) : 0x2::object::ID {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = *0x1::ascii::as_bytes(&v0);
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v3 = *0x1::ascii::as_bytes(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        let v5 = 0x1::vector::length<u8>(&v3);
        let v6 = if (v4 < v5) {
            v4
        } else {
            v5
        };
        let v7 = 0;
        let v8 = false;
        let v9 = false;
        while (v7 < v6) {
            let v10 = *0x1::vector::borrow<u8>(&v1, v7);
            let v11 = *0x1::vector::borrow<u8>(&v3, v7);
            if (v10 > v11) {
                v8 = true;
                break
            };
            if (v11 > v10) {
                v9 = true;
                break
            };
            v7 = v7 + 1;
        };
        if (!v8 && !v9) {
            if (v4 > v5) {
                v8 = true;
            } else if (v5 > v4) {
                v9 = true;
            };
        };
        let v12 = if (v8) {
            0x1::vector::append<u8>(&mut v1, v3);
            v1
        } else {
            assert!(v9, 306);
            0x1::vector::append<u8>(&mut v3, v1);
            v3
        };
        let v13 = v12;
        0x1::vector::append<u8>(&mut v13, 0x1::bcs::to_bytes<u32>(&arg0));
        0x1::vector::append<u8>(&mut v13, 0x1::bcs::to_bytes<u8>(&arg1));
        0x1::vector::append<u8>(&mut v13, 0x1::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v13, 0x1::bcs::to_bytes<bool>(&arg3));
        0x1::vector::append<u8>(&mut v13, 0x1::bcs::to_bytes<bool>(&arg4));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(&v13))
    }

    public fun pool_id(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_key(arg0: &PoolSimpleInfo) : 0x2::object::ID {
        arg0.pool_key
    }

    public fun pool_simple_info(arg0: &Pools, arg1: 0x2::object::ID) : &PoolSimpleInfo {
        0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::linked_table::borrow<0x2::object::ID, PoolSimpleInfo>(&arg0.list, arg1)
    }

    public fun tick_spacing(arg0: &PoolSimpleInfo) : u32 {
        arg0.tick_spacing
    }

    // decompiled from Move bytecode v6
}

