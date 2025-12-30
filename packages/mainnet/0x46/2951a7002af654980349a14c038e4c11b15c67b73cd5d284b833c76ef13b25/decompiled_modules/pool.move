module 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::pool {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        token_x: 0x2::balance::Balance<T0>,
        token_y: 0x2::balance::Balance<T1>,
        scale_x: u64,
        scale_y: u64,
        dex_params: 0x2::object::ID,
        swap_fee_pct: u64,
        swap_enabled: bool,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::AdminCap) {
        assert_version<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut arg0.token_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.token_y, 0x2::coin::into_balance<T1>(arg2));
        0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::events::emit_liquidity_added(&arg0.id, 0x2::coin::value<T0>(&arg1), 0x2::coin::value<T1>(&arg2));
    }

    fun assert_version<T0, T1>(arg0: &Pool<T0, T1>) {
        assert!(arg0.version <= 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::current_version(), 0);
    }

    public fun create_pool<T0, T1>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams, arg3: u64, arg4: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::AdminCap, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id           : 0x2::object::new(arg5),
            version      : 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::current_version(),
            token_x      : 0x2::balance::zero<T0>(),
            token_y      : 0x2::balance::zero<T1>(),
            scale_x      : 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::power_of_ten(0x2::coin::get_decimals<T0>(arg0)),
            scale_y      : 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::power_of_ten(0x2::coin::get_decimals<T1>(arg1)),
            dex_params   : 0x2::object::id<0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams>(arg2),
            swap_fee_pct : arg3,
            swap_enabled : true,
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
        0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::events::emit_pool_created(0x2::object::id<Pool<T0, T1>>(&v0));
    }

    fun init_pool_math<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams, arg2: bool, arg3: &0x2::clock::Clock) : 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::math::PoolMath {
        0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::math::new(arg1, arg2, (0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::scale_up(0x2::balance::value<T0>(&arg0.token_x), arg0.scale_x) as u256), (0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::scale_up(0x2::balance::value<T1>(&arg0.token_y), arg0.scale_y) as u256), 0x2::clock::timestamp_ms(arg3))
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::AdminCap, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert_version<T0, T1>(arg0);
        0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::events::emit_liquidity_removed(&arg0.id, arg1, arg2);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, arg1), arg4), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, arg2), arg4))
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        validate_swap_params<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::mul(v0, arg0.swap_fee_pct);
        let v2 = init_pool_math<T0, T1>(arg0, arg1, true, arg4);
        let v3 = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::scale_down(0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::math::exact_in(&v2, (0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::scale_up(v0 - v1, arg0.scale_x) as u256)), arg0.scale_y);
        assert!(v3 >= arg3, 3);
        0x2::balance::join<T0>(&mut arg0.token_x, 0x2::coin::into_balance<T0>(arg2));
        0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::events::emit_swapped(&arg0.id, v2, true, v0, v3, v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.token_y, v3), arg5)
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        validate_swap_params<T0, T1>(arg0, arg1);
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::mul(v0, arg0.swap_fee_pct);
        let v2 = init_pool_math<T0, T1>(arg0, arg1, false, arg4);
        let v3 = 0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::scale_down(0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::math::exact_in(&v2, (0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::constants::scale_up(v0 - v1, arg0.scale_y) as u256)), arg0.scale_x);
        assert!(v3 >= arg3, 3);
        0x2::balance::join<T1>(&mut arg0.token_y, 0x2::coin::into_balance<T1>(arg2));
        0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::events::emit_swapped(&arg0.id, v2, false, v0, v3, v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_x, v3), arg5)
    }

    public fun update_swap_enabled<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: bool, arg2: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::AdminCap) {
        arg0.swap_enabled = arg1;
    }

    public fun update_swap_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::AdminCap) {
        assert!(arg1 > 0, 1);
        arg0.swap_fee_pct = arg1;
    }

    public fun update_version<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::AdminCap) {
        arg0.version = arg1;
    }

    fun validate_swap_params<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams) {
        assert_version<T0, T1>(arg0);
        assert!(arg0.swap_enabled, 2);
        assert!(0x2::object::id<0x462951a7002af654980349a14c038e4c11b15c67b73cd5d284b833c76ef13b25::params::DexParams>(arg1) == arg0.dex_params, 1);
    }

    // decompiled from Move bytecode v6
}

