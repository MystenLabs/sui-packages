module 0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::pool_script {
    fun swap<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::swap_pay_amount<T0, T1>(&v3);
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
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg10));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg10));
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg10));
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T1>(arg3, 0x2::tx_context::sender(arg10));
    }

    public fun add_liquidity<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg7, arg8);
        repay_add_liquidity<T0, T1>(arg0, arg1, v0, arg3, arg4, arg5, arg6, arg9);
    }

    public fun add_liquidity_by_fix_coin<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg7) {
            arg5
        } else {
            arg6
        };
        let v1 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, arg2, v0, arg7, arg8);
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
        let (_, v4, v5) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::clmm_math::get_liquidity_by_amount(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg2), 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::tick_math::get_tick_at_sqrt_price(arg0), arg0, v2, arg5);
        assert!(v4 <= v0, 1);
        assert!(v5 <= v1, 1);
        (0x2::coin::split<T0>(arg3, v4, arg6), 0x2::coin::split<T1>(arg4, v5, arg6))
    }

    public fun close_position<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::liquidity(&arg2);
        if (v0 > 0) {
            let v1 = &mut arg2;
            remove_liquidity<T0, T1>(arg0, arg1, v1, v0, arg3, arg4, arg5, arg6);
        };
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::close_position<T0, T1>(arg0, arg1, arg2);
    }

    public fun close_position_with_return<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::remove_liquidity<T0, T1>(arg0, arg1, &mut arg2, 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::liquidity(&arg2), arg4);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_fee<T0, T1>(arg0, arg1, &arg2, false);
        if (arg3) {
            0x2::balance::join<T0>(&mut v3, v4);
            0x2::balance::join<T1>(&mut v2, v5);
        } else {
            0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v4, arg5), 0x2::tx_context::sender(arg5));
            0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v5, arg5), 0x2::tx_context::sender(arg5));
        };
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::close_position<T0, T1>(arg0, arg1, arg2);
        (0x2::coin::from_balance<T0>(v3, arg5), 0x2::coin::from_balance<T1>(v2, arg5))
    }

    public fun collect_fee<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v1, arg5));
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg5));
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg5));
    }

    public fun collect_fee_mut<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_protocol_fee<T0, T1>(arg0, arg1, arg2);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::rewarder::RewarderGlobalVault, arg4: 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(&mut arg4, 0x2::coin::from_balance<T2>(0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T2>(arg4, 0x2::tx_context::sender(arg6));
    }

    public fun collect_reward_mut<T0, T1, T2>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public fun create_pool<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::factory::Pools, arg2: u32, arg3: u128, arg4: 0x1::string::String, arg5: u32, arg6: u32, arg7: &mut 0x2::coin::Coin<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: bool, arg10: u8, arg11: bool, arg12: u8, arg13: bool, arg14: bool, arg15: u64, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg3, arg5, arg6, arg7, arg8, arg9, arg17);
        let (v2, v3, v4) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::factory::create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg4, v0, v1, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
        0x2::coin::destroy_zero<T0>(v3);
        0x2::coin::destroy_zero<T1>(v4);
        0x2::transfer::public_transfer<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(v2, 0x2::tx_context::sender(arg17));
    }

    public fun initialize_rewarder<T0, T1, T2>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::initialize_rewarder<T0, T1, T2>(arg0, arg1, arg2);
    }

    public fun lock_position<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: u64, arg4: &0x2::clock::Clock) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::lock_position<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun open_position<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::open_position<T0, T1>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    public fun open_position_with_liquidity<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::open_position<T0, T1>(arg0, arg1, arg6, arg7, arg10);
        let v1 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::add_liquidity<T0, T1>(arg0, arg1, &mut v0, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg1, v1, arg2, arg3, arg4, arg5, arg10);
        0x2::transfer::public_transfer<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun open_position_with_liquidity_by_fix_coin<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::open_position<T0, T1>(arg0, arg1, arg6, arg7, arg10);
        let v1 = if (arg8) {
            arg4
        } else {
            arg5
        };
        let v2 = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::add_liquidity_fix_coin<T0, T1>(arg0, arg1, &mut v0, v1, arg8, arg9);
        repay_add_liquidity<T0, T1>(arg0, arg1, v2, arg2, arg3, arg4, arg5, arg10);
        0x2::transfer::public_transfer<0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun pause_pool<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::pause<T0, T1>(arg0, arg1, arg2);
    }

    public fun remove_liquidity<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::position::Position, arg3: u128, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg6);
        let v2 = v1;
        let v3 = v0;
        assert!(0x2::balance::value<T0>(&v3) >= arg4, 1);
        assert!(0x2::balance::value<T1>(&v2) >= arg5, 1);
        let (v4, v5) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::collect_fee<T0, T1>(arg0, arg1, arg2, false);
        0x2::balance::join<T0>(&mut v3, v4);
        0x2::balance::join<T1>(&mut v2, v5);
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T0>(0x2::coin::from_balance<T0>(v3, arg7), 0x2::tx_context::sender(arg7));
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T1>(0x2::coin::from_balance<T1>(v2, arg7), 0x2::tx_context::sender(arg7));
    }

    fun repay_add_liquidity<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::AddLiquidityReceipt<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::add_liquidity_pay_amount<T0, T1>(&arg2);
        assert!(v0 <= arg5, 0);
        assert!(v1 <= arg6, 0);
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::repay_add_liquidity<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v0, arg7)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v1, arg7)), arg2);
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T0>(arg3, 0x2::tx_context::sender(arg7));
        0x6bd476b85cfd4703e2cd39dbe91f3efdf9134e0cf5cca48620bf4b67204c33b0::utils::send_coin<T1>(arg4, 0x2::tx_context::sender(arg7));
    }

    public fun set_display<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &0x2::package::Publisher, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::set_display<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun swap_a2b<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, arg3, true, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun swap_b2a<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        swap<T0, T1>(arg0, arg1, arg2, arg3, false, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun unpause_pool<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::unpause<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_fee_rate<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::update_fee_rate<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_position_url<T0, T1>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::update_position_url<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun update_rewarder_emission<T0, T1, T2>(arg0: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::config::GlobalConfig, arg1: &mut 0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::Pool<T0, T1>, arg2: &0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::rewarder::RewarderGlobalVault, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xde469e3fc61037aef6394bc9e61b6785e0541f2f4f82dc06ca339fc9266602c5::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

