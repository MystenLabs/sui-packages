module 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::pool_v1 {
    struct Pool<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        version: u64,
        token_x: 0x2::balance::Balance<T0>,
        token_y: 0x2::balance::Balance<T1>,
        lp_cap: 0x2::coin::TreasuryCap<T2>,
        scale_x: u64,
        scale_y: u64,
        price_feed_x: 0x2::object::ID,
        price_feed_y: 0x2::object::ID,
        kappa: u64,
        swap_fee_pct: u64,
        swap_enabled: bool,
        net_quantity: 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::I256,
    }

    public fun add_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        assert_version<T0, T1, T2>(arg0);
        let (v0, v1) = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math_v1::add_liquidity(0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y), 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&arg2));
        let v2 = 0x2::coin::total_supply<T2>(&arg0.lp_cap);
        let v3 = if (v2 == 0) {
            (0x1::u128::sqrt((v0 as u128) * (v1 as u128)) as u64)
        } else {
            0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::mul_div(v0, v2, 0x2::balance::value<T0>(&arg0.token_x))
        };
        assert!(v3 >= arg3, 3);
        0x2::balance::join<T0>(&mut arg0.token_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.token_y, 0x2::coin::into_balance<T1>(arg2));
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::event_v1::emit_add_liquidity_event(&arg0.id, v0, v1, v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, 0x2::coin::value<T0>(&arg1) - v0), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, 0x2::coin::value<T1>(&arg2) - v1), arg5), 0x2::coin::mint<T2>(&mut arg0.lp_cap, v3, arg5))
    }

    public fun remove_liquidity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1, T2>(arg0);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let (v1, v2) = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math_v1::remove_liquidity(0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y), 0x2::coin::total_supply<T2>(&arg0.lp_cap), v0);
        assert!(v1 >= arg2 && v2 >= arg3, 3);
        0x2::coin::burn<T2>(&mut arg0.lp_cap, arg1);
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::event_v1::emit_remove_liquidity_event(&arg0.id, v1, v2, v0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, v1), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, v2), arg5))
    }

    public fun swap_x_to_y<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.swap_enabled, 4);
        let v0 = get_price<T0, T1, T2>(arg0, arg1);
        swap_x_to_<T0, T1, T2>(arg0, v0, arg2, arg3, arg4)
    }

    public fun swap_y_to_x<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1, T2>(arg0);
        assert!(arg0.swap_enabled, 4);
        let v0 = get_price<T0, T1, T2>(arg0, arg1);
        swap_y_to_<T0, T1, T2>(arg0, v0, arg2, arg3, arg4)
    }

    fun assert_version<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) {
        assert!(arg0.version <= 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::constants::current_version(), 0);
    }

    public fun create_pool<T0, T1, T2>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg4: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig, arg5: u64, arg6: u64, arg7: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<T2>(&arg2) == 0, 1);
        assert!(arg5 > 0 && arg6 > 0, 2);
        let v0 = Pool<T0, T1, T2>{
            id           : 0x2::object::new(arg8),
            version      : 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::constants::current_version(),
            token_x      : 0x2::balance::zero<T0>(),
            token_y      : 0x2::balance::zero<T1>(),
            lp_cap       : arg2,
            scale_x      : 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::power_of_ten(0x2::coin::get_decimals<T0>(arg0)),
            scale_y      : 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::power_of_ten(0x2::coin::get_decimals<T1>(arg1)),
            price_feed_x : 0x2::object::id<0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig>(arg3),
            price_feed_y : 0x2::object::id<0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleConfig>(arg4),
            kappa        : arg5,
            swap_fee_pct : arg6,
            swap_enabled : true,
            net_quantity : 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::zero(),
        };
        0x2::transfer::share_object<Pool<T0, T1, T2>>(v0);
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::event_v1::emit_create_pool_event(0x2::object::id<Pool<T0, T1, T2>>(&v0));
    }

    fun get_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::OracleHolder) : u64 {
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::div(0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::price(0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::price_feed(arg1, &arg0.price_feed_x)), 0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::price(0x8c36ea167c5e6da8c3d60b4fc897416105dcb986471bd81cfbfd38720a4487c0::oracle::price_feed(arg1, &arg0.price_feed_y)))
    }

    fun init_pool_math<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math_v1::PoolMath {
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math_v1::new(arg0.kappa, 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::scale_up(0x2::balance::value<T0>(&arg0.token_x), arg0.scale_x), 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::scale_up(0x2::balance::value<T1>(&arg0.token_y), arg0.scale_y), arg0.net_quantity, arg1)
    }

    public fun net_quantity<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::I256 {
        arg0.net_quantity
    }

    public fun reserves<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y), 0x2::coin::total_supply<T2>(&arg0.lp_cap))
    }

    public fun reset_net_quantity<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap) {
        arg0.net_quantity = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::zero();
    }

    public(friend) fun swap_x_to_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::mul(v0, arg0.swap_fee_pct);
        let v2 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::scale_up(v0 - v1, arg0.scale_x);
        let v3 = init_pool_math<T0, T1, T2>(arg0, arg1);
        let (v4, v5) = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math_v1::swap_x_to_y(&v3, v2);
        let v6 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::abs_u64(0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::scale_down(v4, arg0.scale_y));
        assert!(v6 >= arg3, 3);
        arg0.net_quantity = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::add(arg0.net_quantity, v2);
        0x2::balance::join<T0>(&mut arg0.token_x, 0x2::coin::into_balance<T0>(arg2));
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::event_v1::emit_swap_event(&arg0.id, v3, true, v0, v6, v1, v5);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, v6), arg4)
    }

    public(friend) fun swap_y_to_<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::mul(v0, arg0.swap_fee_pct);
        let v2 = init_pool_math<T0, T1, T2>(arg0, arg1);
        let (v3, v4) = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math_v1::swap_y_to_x(&v2, 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::scale_up(v0 - v1, arg0.scale_y));
        let v5 = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::abs_u64(0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::math::scale_down(v3, arg0.scale_x));
        assert!(v5 >= arg3, 3);
        arg0.net_quantity = 0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::i256::add(arg0.net_quantity, v3);
        0x2::balance::join<T1>(&mut arg0.token_y, 0x2::coin::into_balance<T1>(arg2));
        0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::event_v1::emit_swap_event(&arg0.id, v2, false, v0, v5, v1, v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, v5), arg4)
    }

    public fun update_kappa<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap) {
        assert!(arg1 > 0, 2);
        arg0.kappa = arg1;
    }

    public fun update_swap_enabled<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: bool, arg2: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap) {
        arg0.swap_enabled = arg1;
    }

    public fun update_swap_fee<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap) {
        assert!(arg1 > 0, 2);
        arg0.swap_fee_pct = arg1;
    }

    public fun update_version<T0, T1, T2>(arg0: &mut Pool<T0, T1, T2>, arg1: u64, arg2: &0x4142285db093ba0cf0623b3cbc07372fb4f5ed00af1fb62be6d55f49a42c0b0e::admin::AdminCap) {
        arg0.version = arg1;
    }

    // decompiled from Move bytecode v6
}

