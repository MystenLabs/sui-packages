module 0x9e939cf525f812c24b23eee8c819603938465d179d0f8d9ecbfc352350be04f8::router_with_partner {
    public fun swap_ab_bc_with_partner<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T1, T2>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T2>, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg13: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg7) {
            let v2 = 0x2::coin::zero<T1>(arg15);
            let (v3, v4) = swap_with_partner<T0, T1>(arg0, arg1, arg2, arg4, arg5, v2, true, true, arg8, arg10, false, arg12, arg13, arg14, arg15);
            let v5 = v4;
            let (v6, v7) = swap_with_partner<T1, T2>(arg0, arg1, arg3, arg4, v5, arg6, true, true, 0x2::coin::value<T1>(&v5), arg11, false, arg12, arg13, arg14, arg15);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v7)
        } else {
            let (v9, v10, v11) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap_with_partner<T1, T2>(arg0, arg1, arg3, arg4, true, false, arg9, arg11, arg12, arg13, arg14);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg15);
            let (v14, v15) = swap_with_partner<T0, T1>(arg0, arg1, arg2, arg4, arg5, v13, true, false, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T1, T2>(&v12), arg10, false, arg12, arg13, arg14, arg15);
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap_with_partner<T1, T2>(arg0, arg3, arg4, 0x2::coin::into_balance<T1>(v15), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg6, 0x2::coin::from_balance<T2>(v10, arg15));
            (v14, arg6)
        }
    }

    public fun swap_ab_cb_with_partner<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T2, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T2>, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg13: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg7) {
            let v2 = 0x2::coin::zero<T1>(arg15);
            let (v3, v4) = swap_with_partner<T0, T1>(arg0, arg1, arg2, arg4, arg5, v2, true, arg7, arg8, arg10, false, arg12, arg13, arg14, arg15);
            let v5 = v4;
            let (v6, v7) = swap_with_partner<T2, T1>(arg0, arg1, arg3, arg4, arg6, v5, false, true, 0x2::coin::value<T1>(&v5), arg11, false, arg12, arg13, arg14, arg15);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v6)
        } else {
            let (v9, v10, v11) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap_with_partner<T2, T1>(arg0, arg1, arg3, arg4, false, false, arg9, arg11, arg12, arg13, arg14);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg15);
            let (v14, v15) = swap_with_partner<T0, T1>(arg0, arg1, arg2, arg4, arg5, v13, true, false, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T2, T1>(&v12), arg10, false, arg12, arg13, arg14, arg15);
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg3, arg4, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v15), v12);
            0x2::coin::join<T2>(&mut arg6, 0x2::coin::from_balance<T2>(v9, arg15));
            (v14, arg6)
        }
    }

    public fun swap_ba_bc_with_partner<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T1, T0>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T1, T2>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T2>, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg13: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg7) {
            let v2 = 0x2::coin::zero<T1>(arg15);
            let (v3, v4) = swap_with_partner<T1, T0>(arg0, arg1, arg2, arg4, v2, arg5, false, arg7, arg8, arg10, false, arg12, arg13, arg14, arg15);
            let v5 = v3;
            let (v6, v7) = swap_with_partner<T1, T2>(arg0, arg1, arg3, arg4, v5, arg6, true, true, 0x2::coin::value<T1>(&v5), arg11, false, arg12, arg13, arg14, arg15);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v7)
        } else {
            let (v9, v10, v11) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap_with_partner<T1, T2>(arg0, arg1, arg3, arg4, true, false, arg9, arg11, arg12, arg13, arg14);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg15);
            let (v14, v15) = swap_with_partner<T1, T0>(arg0, arg1, arg2, arg4, v13, arg5, false, false, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T1, T2>(&v12), arg10, false, arg12, arg13, arg14, arg15);
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap_with_partner<T1, T2>(arg0, arg3, arg4, 0x2::coin::into_balance<T1>(v14), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg6, 0x2::coin::from_balance<T2>(v10, arg15));
            (v15, arg6)
        }
    }

    public fun swap_ba_cb_with_partner<T0, T1, T2>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T1, T0>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T2, T1>, arg4: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T2>, arg7: bool, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg13: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg7) {
            let v2 = 0x2::coin::zero<T1>(arg15);
            let (v3, v4) = swap_with_partner<T1, T0>(arg0, arg1, arg2, arg4, v2, arg5, false, true, arg8, arg10, false, arg12, arg13, arg14, arg15);
            let v5 = v3;
            let (v6, v7) = swap_with_partner<T2, T1>(arg0, arg1, arg3, arg4, arg6, v5, false, arg7, 0x2::coin::value<T1>(&v5), arg11, false, arg12, arg13, arg14, arg15);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v6)
        } else {
            let (v9, v10, v11) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap_with_partner<T2, T1>(arg0, arg1, arg3, arg4, false, false, arg9, arg11, arg12, arg13, arg14);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg15);
            let (v14, v15) = swap_with_partner<T1, T0>(arg0, arg1, arg2, arg4, v13, arg5, false, false, 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T2, T1>(&v12), arg10, false, arg12, arg13, arg14, arg15);
            0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg3, arg4, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v14), v12);
            0x2::coin::join<T2>(&mut arg6, 0x2::coin::from_balance<T2>(v9, arg15));
            (v15, arg6)
        }
    }

    public fun swap_with_partner<T0, T1>(arg0: &0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::config::GlobalConfig, arg1: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::rewarder::RewarderGlobalVault, arg2: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::Pool<T0, T1>, arg3: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: bool, arg7: bool, arg8: u64, arg9: u128, arg10: bool, arg11: &mut 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::stats::Stats, arg12: &0x8efc19386b334f035ceaa121b84f331b295b947cd8c601aa37faa36ed0f7466b::price_provider::PriceProvider, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg7 && arg10) {
            let v0 = if (arg6) {
                0x2::coin::value<T0>(&arg4)
            } else {
                0x2::coin::value<T1>(&arg5)
            };
            arg8 = v0;
        };
        let (v1, v2, v3) = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg3, arg6, arg7, arg8, arg9, arg11, arg12, arg13);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::swap_pay_amount<T0, T1>(&v4);
        let v8 = if (arg6) {
            0x2::balance::value<T1>(&v5)
        } else {
            0x2::balance::value<T0>(&v6)
        };
        if (arg7) {
            assert!(v7 == arg8, 1);
        } else {
            assert!(v8 == arg8, 1);
        };
        let (v9, v10) = if (arg6) {
            assert!(0x2::coin::value<T0>(&arg4) >= v7, 4);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v7, arg14)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v7, arg14)))
        };
        0x2::coin::join<T0>(&mut arg4, 0x2::coin::from_balance<T0>(v6, arg14));
        0x2::coin::join<T1>(&mut arg5, 0x2::coin::from_balance<T1>(v5, arg14));
        0x8c9b843944257991e5f813039d9fb70e0358ae2ff28b2bfdf2624dd6d8251bb3::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg2, arg3, v9, v10, v4);
        (arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

