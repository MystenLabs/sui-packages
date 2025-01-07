module 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::gateway {
    public entry fun close_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::position::Position, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::position::liquidity(&arg3);
        let (v1, v2) = if (v0 > 0) {
            let (_, _, v5, v6) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v0, arg0);
            (v5, v6)
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        let v7 = v2;
        let v8 = v1;
        let (_, _, v11, v12) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::collect_fee<T0, T1>(arg0, arg1, arg2, &mut arg3);
        0x2::balance::join<T0>(&mut v8, v11);
        0x2::balance::join<T1>(&mut v7, v12);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::close_position_v2<T0, T1>(arg0, arg1, arg2, arg3);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(v8, arg4, arg5);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T1>(v7, arg4, arg5);
    }

    public entry fun collect_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let (_, _, v3, v4) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::collect_fee<T0, T1>(arg0, arg1, arg2, arg3);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(v3, v0, arg4);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T1>(v4, v0, arg4);
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::position::Position, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3);
        assert!(0x2::balance::value<T2>(&v0) > 0, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::can_not_claim_zero_reward());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T2>(v0, 0x2::tx_context::sender(arg4), arg4);
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: u8, arg8: vector<u8>, arg9: u32, arg10: u64, arg11: u128, arg12: &mut 0x2::tx_context::TxContext) {
        abort 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::depricated()
    }

    public entry fun create_pool_v2<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: u8, arg9: vector<u8>, arg10: u32, arg11: u64, arg12: u128, arg13: 0x2::coin::Coin<T2>, arg14: &mut 0x2::tx_context::TxContext) {
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::create_pool<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, 0x2::coin::into_balance<T2>(arg13), arg14);
    }

    public entry fun flash_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg5) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg6) {
            assert!(v7 >= arg8, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::slippage_exceeds());
        } else {
            assert!(v6 <= arg8, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::slippage_exceeds());
        };
        let (v8, v9) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v6, arg10)))
        };
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v4, arg10));
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::repay_flash_swap<T0, T1>(arg1, arg2, v8, v9, v3);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_coin<T0>(arg3, 0x2::tx_context::sender(arg10));
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_coin<T1>(arg4, 0x2::tx_context::sender(arg10));
    }

    public entry fun provide_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2, v3, v4) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg8);
        assert!(v1 >= arg6 && v2 >= arg7, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::slippage_exceeds());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(v3, v0, arg9);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T1>(v4, v0, arg9);
    }

    public entry fun provide_liquidity_with_fixed_amount<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let (v1, v2, v3, v4) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg9);
        assert!(v1 <= arg7 && v2 <= arg8, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::slippage_exceeds());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(v3, v0, arg10);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T1>(v4, v0, arg10);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::position::Position, arg4: u128, arg5: u64, arg6: u64, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::remove_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg0);
        assert!(v0 >= arg5 && v1 >= arg6, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::slippage_exceeds());
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(v2, arg7, arg8);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T1>(v3, arg7, arg8);
    }

    public fun route_swap<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg6 && arg7) {
            let v0 = if (arg5) {
                0x2::coin::value<T0>(&arg3)
            } else {
                0x2::coin::value<T1>(&arg4)
            };
            arg8 = v0;
        };
        let (v1, v2, v3) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg8, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::swap_pay_amount<T0, T1>(&v4);
        let v8 = if (arg5) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        if (arg6) {
            assert!(v8 >= arg9, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::slippage_exceeds());
            assert!(v7 == arg8, 1);
        } else {
            assert!(v7 <= arg9, 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::errors::slippage_exceeds());
            assert!(v8 == arg8, 1);
        };
        let (v9, v10) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v7, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v7, arg11)))
        };
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v6, arg11));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v5, arg11));
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::repay_flash_swap<T0, T1>(arg1, arg2, v9, v10, v4);
        (arg3, arg4)
    }

    public entry fun swap_assets<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::config::GlobalConfig, arg2: &mut 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::Pool<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::pool::swap<T0, T1>(arg0, arg1, arg2, 0x2::coin::into_balance<T0>(arg3), 0x2::coin::into_balance<T1>(arg4), arg5, arg6, arg7, arg8, arg9);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T0>(v0, 0x2::tx_context::sender(arg10), arg10);
        0x2132f846be6b40cac03f581cebe58464c7b8d8e85e14822a69f15822447d82f0::utils::transfer_balance<T1>(v1, 0x2::tx_context::sender(arg10), arg10);
    }

    // decompiled from Move bytecode v6
}

