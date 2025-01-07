module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::gateway {
    public entry fun close_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg2: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>, arg3: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::liquidity(&arg3);
        if (v0 > 0) {
            let (_, _, v3, v4) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::remove_liquidity<T0, T1>(arg1, arg2, &mut arg3, v0, arg0);
            0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T0>(v3, arg4, arg5);
            0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T1>(v4, arg4, arg5);
        };
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::close_position(arg3, arg5);
    }

    public entry fun create_pool<T0, T1>(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: address, arg3: address, arg4: u32, arg5: u64, arg6: u64, arg7: u128, arg8: &mut 0x2::tx_context::TxContext) {
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun flash_swap<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, 0x2::tx_context::sender(arg10));
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg5) {
            assert!(v7 >= arg7, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::slippage_exceeds());
        } else {
            assert!(v6 <= arg7, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::slippage_exceeds());
        };
        let (v8, v9) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg10)))
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg10));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg10));
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::repay_flash_swap<T0, T1>(arg0, arg1, v8, v9, v3);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_coin<T0>(arg2, arg9);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_coin<T1>(arg3, arg9);
    }

    public entry fun provide_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg2: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>, arg3: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u128, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, v3) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::add_liquidity<T0, T1>(arg1, arg2, arg3, 0x2::coin::into_balance<T0>(arg4), 0x2::coin::into_balance<T1>(arg5), arg6, arg0);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T0>(v2, arg7, arg8);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T1>(v3, arg7, arg8);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg2: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>, arg3: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::position::Position, arg4: u128, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2, v3) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::remove_liquidity<T0, T1>(arg1, arg2, arg3, arg4, arg0);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T0>(v2, arg5, arg6);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T1>(v3, arg5, arg6);
    }

    public fun route_swap<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg5 && arg6) {
            let v0 = if (arg4) {
                0x2::coin::value<T0>(&arg2)
            } else {
                0x2::coin::value<T1>(&arg3)
            };
            arg7 = v0;
        };
        let (v1, v2, v3) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg7, arg9, 0x2::tx_context::sender(arg10));
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::swap_pay_amount<T0, T1>(&v4);
        let v8 = if (arg4) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        if (arg5) {
            assert!(v8 >= arg8, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::slippage_exceeds());
            assert!(v7 == arg7, 1);
        } else {
            assert!(v7 <= arg8, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::slippage_exceeds());
            assert!(v8 == arg7, 1);
        };
        let (v9, v10) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v7, arg10)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v7, arg10)))
        };
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v6, arg10));
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v5, arg10));
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::repay_flash_swap<T0, T1>(arg0, arg1, v9, v10, v4);
        (arg2, arg3)
    }

    public entry fun swap_assets<T0, T1>(arg0: &0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::config::GlobalConfig, arg1: &mut 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: address, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::pool::swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg4, arg5, arg6, arg7, arg8, arg10);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T0>(v0, arg9, arg10);
        0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::utils::transfer_balance<T1>(v1, arg9, arg10);
    }

    // decompiled from Move bytecode v6
}

