module 0x2e704d8afc1d6d7f154dee337cc14c153f6f9ce1708213e5dc04a32afe0e45f1::router_with_partner {
    public fun swap_ab_bc_with_partner<T0, T1, T2>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T1, T2>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg12);
            let (v3, v4) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v2, true, true, arg7, arg9, false, arg11, arg12);
            let v5 = v4;
            let (v6, v7) = swap_with_partner<T1, T2>(arg0, arg2, arg3, v5, arg5, true, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v7)
        } else {
            let (v9, v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, true, false, arg8, arg10, arg11);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg12);
            let (v14, v15) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v13, true, false, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T1, T2>(&v12), arg9, false, arg11, arg12);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, 0x2::coin::into_balance<T1>(v15), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v10, arg12));
            (v14, arg5)
        }
    }

    public fun swap_ab_cb_with_partner<T0, T1, T2>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg12);
            let (v3, v4) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v2, true, arg6, arg7, arg9, false, arg11, arg12);
            let v5 = v4;
            let (v6, v7) = swap_with_partner<T2, T1>(arg0, arg2, arg3, arg5, v5, false, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v3, v6)
        } else {
            let (v9, v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, false, false, arg8, arg10, arg11);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg12);
            let (v14, v15) = swap_with_partner<T0, T1>(arg0, arg1, arg3, arg4, v13, true, false, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T2, T1>(&v12), arg9, false, arg11, arg12);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v15), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v9, arg12));
            (v14, arg5)
        }
    }

    public fun swap_ba_bc_with_partner<T0, T1, T2>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T1, T0>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T1, T2>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg12);
            let (v3, v4) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v2, arg4, false, arg6, arg7, arg9, false, arg11, arg12);
            let v5 = v3;
            let (v6, v7) = swap_with_partner<T1, T2>(arg0, arg2, arg3, v5, arg5, true, true, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12);
            let v8 = v6;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v7)
        } else {
            let (v9, v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, true, false, arg8, arg10, arg11);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v9, arg12);
            let (v14, v15) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v13, arg4, false, false, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T1, T2>(&v12), arg9, false, arg11, arg12);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T1, T2>(arg0, arg2, arg3, 0x2::coin::into_balance<T1>(v14), 0x2::balance::zero<T2>(), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v10, arg12));
            (v15, arg5)
        }
    }

    public fun swap_ba_cb_with_partner<T0, T1, T2>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T1, T0>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T1>, arg3: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T2>, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T2>) {
        if (arg6) {
            let v2 = 0x2::coin::zero<T1>(arg12);
            let (v3, v4) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v2, arg4, false, true, arg7, arg9, false, arg11, arg12);
            let v5 = v3;
            let (v6, v7) = swap_with_partner<T2, T1>(arg0, arg2, arg3, arg5, v5, false, arg6, 0x2::coin::value<T1>(&v5), arg10, false, arg11, arg12);
            let v8 = v7;
            assert!(0x2::coin::value<T1>(&v8) == 0, 5);
            0x2::coin::destroy_zero<T1>(v8);
            (v4, v6)
        } else {
            let (v9, v10, v11) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, false, false, arg8, arg10, arg11);
            let v12 = v11;
            let v13 = 0x2::coin::from_balance<T1>(v10, arg12);
            let (v14, v15) = swap_with_partner<T1, T0>(arg0, arg1, arg3, v13, arg4, false, false, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T2, T1>(&v12), arg9, false, arg11, arg12);
            0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T2, T1>(arg0, arg2, arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T1>(v14), v12);
            0x2::coin::join<T2>(&mut arg5, 0x2::coin::from_balance<T2>(v9, arg12));
            (v15, arg5)
        }
    }

    public fun swap_with_partner<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg1: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::partner::Partner, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg6 && arg9) {
            let v0 = if (arg5) {
                0x2::coin::value<T0>(&arg3)
            } else {
                0x2::coin::value<T1>(&arg4)
            };
            arg7 = v0;
        };
        let (v1, v2, v3) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, arg5, arg6, arg7, arg8, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::swap_pay_amount<T0, T1>(&v4);
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
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, v7, arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, v7, arg11)))
        };
        0x2::coin::join<T0>(&mut arg3, 0x2::coin::from_balance<T0>(v6, arg11));
        0x2::coin::join<T1>(&mut arg4, 0x2::coin::from_balance<T1>(v5, arg11));
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, arg2, v9, v10, v4);
        (arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

