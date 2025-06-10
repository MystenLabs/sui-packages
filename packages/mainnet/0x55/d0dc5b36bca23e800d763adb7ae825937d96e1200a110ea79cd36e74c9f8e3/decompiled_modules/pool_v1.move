module 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::pool_v1 {
    struct LPT<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        token_x: 0x2::balance::Balance<T0>,
        token_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LPT<T0, T1>>,
        scale_x: u64,
        scale_y: u64,
        price_feed_x: 0x2::object::ID,
        price_feed_y: 0x2::object::ID,
        kappa: u64,
        swap_fee_pct: u64,
        swap_enabled: bool,
        net_quantity: 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::I256,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::AdminCap, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<LPT<T0, T1>>) {
        assert_version<T0, T1>(arg0);
        let (v0, v1) = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math_v1::add_liquidity(0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y), 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&arg2));
        let v2 = 0x2::balance::supply_value<LPT<T0, T1>>(&arg0.lp_supply);
        let v3 = if (v2 == 0) {
            (0x1::u128::sqrt((v0 as u128) * (v1 as u128)) as u64)
        } else {
            0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::mul_div(v0, v2, 0x2::balance::value<T0>(&arg0.token_x))
        };
        assert!(v3 >= arg3, 2);
        0x2::balance::join<T0>(&mut arg0.token_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.token_y, 0x2::coin::into_balance<T1>(arg2));
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::event_v1::emit_add_liquidity_event(&arg0.id, v0, v1, v3);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, 0x2::coin::value<T0>(&arg1) - v0), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, 0x2::coin::value<T1>(&arg2) - v1), arg5), 0x2::coin::from_balance<LPT<T0, T1>>(0x2::balance::increase_supply<LPT<T0, T1>>(&mut arg0.lp_supply, v3), arg5))
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LPT<T0, T1>>, arg2: u64, arg3: u64, arg4: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::AdminCap, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<LPT<T0, T1>>(&arg1);
        let (v1, v2) = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math_v1::remove_liquidity(0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y), 0x2::balance::supply_value<LPT<T0, T1>>(&arg0.lp_supply), v0);
        assert!(v1 >= arg2 && v2 >= arg3, 2);
        0x2::balance::decrease_supply<LPT<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LPT<T0, T1>>(arg1));
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::event_v1::emit_remove_liquidity_event(&arg0.id, v1, v2, v0);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, v1), arg5), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, v2), arg5))
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::OracleHolder, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        assert!(arg0.swap_enabled, 3);
        let v0 = get_price<T0, T1>(arg0, arg1);
        swap_x_to_<T0, T1>(arg0, v0, arg2, arg3, arg4)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::OracleHolder, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0, T1>(arg0);
        assert!(arg0.swap_enabled, 3);
        let v0 = get_price<T0, T1>(arg0, arg1);
        swap_y_to_<T0, T1>(arg0, v0, arg2, arg3, arg4)
    }

    fun assert_version<T0, T1>(arg0: &Pool<T0, T1>) {
        let v0 = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.allowed_versions, &v0), 0);
    }

    public fun create_pool<T0, T1>(arg0: &mut 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::Registry, arg1: &0x2::coin::CoinMetadata<T0>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::OracleConfig, arg4: &0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::OracleConfig, arg5: u64, arg6: u64, arg7: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::AdminCap, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0 && arg6 > 0, 1);
        let v0 = LPT<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id               : 0x2::object::new(arg8),
            allowed_versions : 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::allowed_versions(arg0),
            token_x          : 0x2::balance::zero<T0>(),
            token_y          : 0x2::balance::zero<T1>(),
            lp_supply        : 0x2::balance::create_supply<LPT<T0, T1>>(v0),
            scale_x          : 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::power_of_ten(0x2::coin::get_decimals<T0>(arg1)),
            scale_y          : 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::power_of_ten(0x2::coin::get_decimals<T1>(arg2)),
            price_feed_x     : 0x2::object::id<0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::OracleConfig>(arg3),
            price_feed_y     : 0x2::object::id<0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::OracleConfig>(arg4),
            kappa            : arg5,
            swap_fee_pct     : arg6,
            swap_enabled     : true,
            net_quantity     : 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::zero(),
        };
        let v2 = 0x2::object::id<Pool<T0, T1>>(&v1);
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::register_pool<T0, T1>(arg0, v2);
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::event_v1::emit_create_pool_event(v2);
    }

    fun get_price<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::OracleHolder) : u64 {
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::div(0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::price(0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::price_feed(arg1, &arg0.price_feed_x)), 0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::price(0x5139d8caf0dc93516f2cf4eaa3a52b33ce9a4324037dc939a9de1923bc497c12::oracle::price_feed(arg1, &arg0.price_feed_y)))
    }

    fun init_pool_math<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math_v1::PoolMath {
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math_v1::new(arg0.kappa, 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::scale_up(0x2::balance::value<T0>(&arg0.token_x), arg0.scale_x), 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::scale_up(0x2::balance::value<T1>(&arg0.token_y), arg0.scale_y), arg0.net_quantity, arg1)
    }

    public fun net_quantity<T0, T1>(arg0: &Pool<T0, T1>) : 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::I256 {
        arg0.net_quantity
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.token_x), 0x2::balance::value<T1>(&arg0.token_y), 0x2::balance::supply_value<LPT<T0, T1>>(&arg0.lp_supply))
    }

    public(friend) fun swap_x_to_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::mul(v0, arg0.swap_fee_pct);
        let v2 = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::scale_up(v0 - v1, arg0.scale_x);
        let v3 = init_pool_math<T0, T1>(arg0, arg1);
        let v4 = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::abs_u64(0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::scale_down(0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math_v1::swap_x_to_y(&v3, v2), arg0.scale_y));
        assert!(v4 >= arg3, 2);
        arg0.net_quantity = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::add(arg0.net_quantity, v2);
        0x2::balance::join<T0>(&mut arg0.token_x, 0x2::coin::into_balance<T0>(arg2));
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::event_v1::emit_swap_event(&arg0.id, v3, true, v0, v4, v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, v4), arg4)
    }

    public(friend) fun swap_y_to_<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::mul(v0, arg0.swap_fee_pct);
        let v2 = init_pool_math<T0, T1>(arg0, arg1);
        let v3 = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math_v1::swap_y_to_x(&v2, 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::scale_up(v0 - v1, arg0.scale_y));
        let v4 = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::abs_u64(0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::math::scale_down(v3, arg0.scale_x));
        assert!(v4 >= arg3, 2);
        arg0.net_quantity = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256::add(arg0.net_quantity, v3);
        0x2::balance::join<T1>(&mut arg0.token_y, 0x2::coin::into_balance<T1>(arg2));
        0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::event_v1::emit_swap_event(&arg0.id, v2, false, v0, v4, v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, v4), arg4)
    }

    public fun update_allowed_versions<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::Registry, arg2: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::AdminCap) {
        arg0.allowed_versions = 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::allowed_versions(arg1);
    }

    public fun update_kappa<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::AdminCap) {
        assert!(arg1 > 0, 1);
        arg0.kappa = arg1;
    }

    public fun update_swap_enabled<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::AdminCap) {
        arg0.swap_enabled = arg1;
    }

    public fun update_swap_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::registry::AdminCap) {
        assert!(arg1 > 0, 1);
        arg0.swap_fee_pct = arg1;
    }

    // decompiled from Move bytecode v6
}

