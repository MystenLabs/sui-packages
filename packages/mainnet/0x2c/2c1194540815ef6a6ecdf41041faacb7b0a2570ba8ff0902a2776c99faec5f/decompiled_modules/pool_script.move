module 0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::pool_script {
    fun swap<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg5) {
            assert!(v6 == arg6, 2);
            assert!(v7 >= arg7, 1);
        } else {
            assert!(v7 == arg6, 2);
            assert!(v6 <= arg7, 0);
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg10)))
        };
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg10));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg10));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg10));
    }

    public fun add_liquidity<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg9);
    }

    public fun add_liquidity_by_fix_coin<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7) {
            arg5
        } else {
            arg6
        };
        let v1 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v0, arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, v1, arg3, arg4, arg5, arg6, arg9);
    }

    fun build_init_position_arg<T0, T1>(arg0: u128, arg1: u32, arg2: u32, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(arg3);
        let v1 = 0x2::coin::value<T1>(arg4);
        let v2 = if (arg5) {
            v0
        } else {
            v1
        };
        let (_, v4, v5) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::clmm_math::get_liquidity_by_amount(0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::from_u32(arg1), 0xe31ab475dde2448379d2c24fef23c0a3cb68fd11226984ee7c3a561aadc78ad4::i32::from_u32(arg2), 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::tick_math::get_tick_at_sqrt_price(arg0), arg0, v2, arg5);
        assert!(v4 <= v0, 1);
        assert!(v5 <= v1, 1);
        (0x2::coin::split<T0>(arg3, v4, arg6), 0x2::coin::split<T1>(arg4, v5, arg6))
    }

    public fun close_position<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::liquidity(&arg2);
        if (v0 > 0) {
            let v1 = &mut arg2;
            remove_liquidity<T0, T1>(arg0, arg1, v1, v0, arg3, arg4, arg5, arg6);
        };
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::close_position<T0, T1>(arg0, arg1, arg2);
    }

    public fun close_position_with_return<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut arg2, 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::liquidity(&arg2), arg4);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::collect_fee<T0, T1>(arg0, arg1, &arg2, false);
        if (arg3) {
            0x2::balance::join<T0>(&mut v3, v4);
            0x2::balance::join<T1>(&mut v2, v5);
        } else {
            0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v4, arg5), 0x2::tx_context::sender(arg5));
            0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v5, arg5), 0x2::tx_context::sender(arg5));
        };
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::close_position<T0, T1>(arg0, arg1, arg2);
        (0x2::coin::from_balance<T0>(v3, arg5), 0x2::coin::from_balance<T1>(v2, arg5))
    }

    public fun collect_fee<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v1, arg5));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg5));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg5));
    }

    public fun collect_fee_mut<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::collect_protocol_fee<T0, T1>(arg0, arg1, arg4);
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v0, arg4));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v1, arg4));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg4));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg4));
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(&mut arg4, 0x2::coin::from_balance<T2>(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T2>(arg4, 0x2::tx_context::sender(arg6));
    }

    public fun collect_reward_mut<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public fun create_pool<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut 0x2::coin::Coin<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg3, arg5, arg6, arg7, arg8, arg10, arg12);
        let (v2, v3, v4) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::factory::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v0, v1, arg9, arg10, arg11, arg12);
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::transfer::public_transfer<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(v2, 0x2::tx_context::sender(arg12));
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::initialize_rewarder<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun lock_position<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: u64, arg4: &0x2::clock::Clock) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::lock_position<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun open_position<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun open_position_with_liquidity<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg9, arg11);
        let v1 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v0, arg8, arg10);
        repay_add_liquidity<T0, T1>(arg0, arg1, v1, arg4, arg5, arg6, arg7, arg11);
        0x2::transfer::public_transfer<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun open_position_with_liquidity_by_fix_coin<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg8, arg11);
        let v1 = if (arg9) {
            arg6
        } else {
            arg7
        };
        let v2 = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, v1, arg9, arg10);
        repay_add_liquidity<T0, T1>(arg0, arg1, v2, arg4, arg5, arg6, arg7, arg11);
        0x2::transfer::public_transfer<0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position>(v0, 0x2::tx_context::sender(arg11));
    }

    public fun pause_pool<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::pause<T0, T1>(arg0, arg1, arg2);
    }

    public fun remove_liquidity<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg4, 1);
        assert!(0x2::balance::value<T1>(&v2) >= arg5, 1);
        let (v4, v5) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::collect_fee<T0, T1>(arg0, arg1, arg2, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v3, arg7), 0x2::tx_context::sender(arg7));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v2, arg7), 0x2::tx_context::sender(arg7));
    }

    fun repay_add_liquidity<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::AddLiquidityReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v0 <= arg5, 0);
        assert!(v1 <= arg6, 0);
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v1, arg7)), arg2);
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg7));
        0x2c2c1194540815ef6a6ecdf41041faacb7b0a2570ba8ff0902a2776c99faec5f::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg7));
    }

    public fun set_display<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::set_display<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun swap_a2b<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, arg3, true, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun swap_b2a<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, arg3, false, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun unpause_pool<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::unpause<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_fee_rate<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::update_fee_rate<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_position_url<T0, T1>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::update_position_url<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_rewarder_emission<T0, T1, T2>(arg0: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::config::GlobalConfig, arg1: &mut 0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::Pool<T0, T1>, arg2: &0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x53b77759202d23d14289aa2db758498f5f9d38ecbbdd9302362b836408a6782d::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

