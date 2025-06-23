module 0xe14acefdc888d3e20fc624693b28c4f47ec7d5c7a1c70632cb29b8389e9bd9e6::router_with_partner {
    public fun swap_ab_bc_with_partner<T0, T1, T2>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg1: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T0, T1>, arg2: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T1, T2>, arg3: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::stats::Stats, arg12: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v2, true, true, arg7, arg9, false, arg11, arg12, arg13, arg14);
            let v5 = v4;
            let (v6, v7) = swap_with_partner<T1, T2>(arg0, arg2, arg3, v5, arg5, true, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12, arg13, arg14);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v7)
        } else {
            let (v9, v10, v11) = 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, true, false, arg8, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg14);
            let (v14, v15) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v13, true, false, 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::swap_pay_amount<T1, T2>(&v12), arg9, false, arg11, arg12, arg13, arg14);
            0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::repay_flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, 0x2::coin::into_balance<T1>(v15), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v10, arg14));
            (v14, arg5)
        }
    }

    public fun swap_ab_cb_with_partner<T0, T1, T2>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg1: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T0, T1>, arg2: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T2, T1>, arg3: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::stats::Stats, arg12: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v2, true, arg6, arg7, arg9, false, arg11, arg12, arg13, arg14);
            let v5 = v4;
            let (v6, v7) = swap_with_partner<T2, T1>(arg0, arg2, arg3, arg5, v5, false, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12, arg13, arg14);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v6)
        } else {
            let (v9, v10, v11) = 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, false, false, arg8, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg14);
            let (v14, v15) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v13, true, false, 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::swap_pay_amount<T2, T1>(&v12), arg9, false, arg11, arg12, arg13, arg14);
            0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v15), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v9, arg14));
            (v14, arg5)
        }
    }

    public fun swap_ba_bc_with_partner<T0, T1, T2>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg1: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T1, T0>, arg2: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T1, T2>, arg3: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::stats::Stats, arg12: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v2, arg4, false, arg6, arg7, arg9, false, arg11, arg12, arg13, arg14);
            let v5 = v3;
            let (v6, v7) = swap_with_partner<T1, T2>(arg0, arg2, arg3, v5, arg5, true, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12, arg13, arg14);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v7)
        } else {
            let (v9, v10, v11) = 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, true, false, arg8, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg14);
            let (v14, v15) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v13, arg4, false, false, 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::swap_pay_amount<T1, T2>(&v12), arg9, false, arg11, arg12, arg13, arg14);
            0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::repay_flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, 0x2::coin::into_balance<T1>(v14), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v10, arg14));
            (v15, arg5)
        }
    }

    public fun swap_ba_cb_with_partner<T0, T1, T2>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg1: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T1, T0>, arg2: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T2, T1>, arg3: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::stats::Stats, arg12: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg14);
            let (v3, v4) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v2, arg4, false, true, arg7, arg9, false, arg11, arg12, arg13, arg14);
            let v5 = v3;
            let (v6, v7) = swap_with_partner<T2, T1>(arg0, arg2, arg3, arg5, v5, false, arg6, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12, arg13, arg14);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v6)
        } else {
            let (v9, v10, v11) = 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, false, false, arg8, arg10, arg11, arg12, arg13);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg14);
            let (v14, v15) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v13, arg4, false, false, 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::swap_pay_amount<T2, T1>(&v12), arg9, false, arg11, arg12, arg13, arg14);
            0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v14), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v9, arg14));
            (v15, arg5)
        }
    }

    public fun swap_with_partner<T0, T1>(arg0: &0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::config::GlobalConfig, arg1: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::Pool<T0, T1>, arg2: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u128, arg9: bool, arg10: &mut 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::stats::Stats, arg11: &0x1ac94be8fdc8a3844dbb94cf4d101ed95c08376bfabde9d6ad608f2848c28df2::price_provider::PriceProvider, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg6 && arg9) {
            let v0 = if (arg5) {
                0x2::coin::value<T0>(&arg3)
            } else {
                0x2::coin::value<T1>(&arg4)
            };
            arg7 = v0;
        };
        let (v1, v2, v3) = 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg10, arg11, arg12);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::swap_pay_amount<T0, T1>(&v4);
        let v8 = if (arg5) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        if (arg6) {
            assert!(v7 == arg7, 1);
        } else {
            assert!(v8 == arg7, 1);
        };
        let (v9, v10) = if (arg5) {
            assert!(0x2::coin::value<T0>(&arg3) >= v7, 4);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v7, arg13)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v7, arg13)))
        };
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v6, arg13));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v5, arg13));
        0x6a700cf2c245d51b4d98cc4b5b6b1c57acecdcde5db03ea36d48150108725979::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v9, v10, v4);
        (arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

