module 0xb1cb86d43a4f6caf200877c00158ffd818d26efb5c3768c24b87dbff535cf13b::amount {
    struct ArbState has copy, drop {
        swap_amount: u64,
        price_diff: u128,
        a2b: bool,
    }

    fun calculate_price_diff<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: bool) : u128 {
        let v0 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, arg3, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
        let v1 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_sqrt_price(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, !arg3, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v0));
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v2);
        if (v1 > v3) {
            v1 - v3
        } else {
            v3 - v1
        }
    }

    fun calculate_price_diff_reverse<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: bool) : u128 {
        let v0 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, arg3, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true), arg2);
        let v1 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_sqrt_price(&v0);
        let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, arg3, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v0));
        let v3 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v2), true);
        if (v1 > v3) {
            v1 - v3
        } else {
            v3 - v1
        }
    }

    public fun get_a2b(arg0: &ArbState) : bool {
        arg0.a2b
    }

    public fun get_price_diff(arg0: &ArbState) : u128 {
        arg0.price_diff
    }

    public fun get_swap_amount(arg0: &ArbState) : u64 {
        arg0.swap_amount
    }

    fun kriya_swap<T0, T1>(arg0: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: bool, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::flash_swap<T0, T1>(arg0, arg1, true, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let (v6, v7) = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::swap_receipt_debts(&v3);
        let v8 = if (arg1) {
            v6
        } else {
            v7
        };
        if (arg1) {
        };
        0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v5, arg8));
        0x2::coin::join<T1>(arg3, 0x2::coin::from_balance<T1>(v4, arg8));
        let (v9, v10) = if (arg1) {
            assert!(0x2::coin::value<T0>(arg2) >= v8, 0xb1cb86d43a4f6caf200877c00158ffd818d26efb5c3768c24b87dbff535cf13b::error::insufficient_balance_x());
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v8, arg8)), 0x2::balance::zero<T1>())
        } else {
            assert!(0x2::coin::value<T1>(arg3) >= v8, 0xb1cb86d43a4f6caf200877c00158ffd818d26efb5c3768c24b87dbff535cf13b::error::insufficient_balance_y());
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v8, arg8)))
        };
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::repay_flash_swap<T0, T1>(arg0, v3, v9, v10, arg7, arg8);
    }

    public fun swap_optimal_arb_amount<T0, T1>(arg0: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2) = if (0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::sqrt_price<T0, T1>(arg0) > v0) {
            let v3 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, v0, 18446744073709551615);
            (true, 18446744073709551615 - 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_specified(&v3))
        } else {
            let v4 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, v0, 18446744073709551615);
            (false, 18446744073709551615 - 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_specified(&v4))
        };
        let v5 = 0;
        let v6 = v2;
        let v7 = 0;
        let v8 = 0;
        while (v5 <= v6 && v8 < arg2) {
            let v9 = calculate_price_diff<T0, T1>(arg0, arg1, v5, v1);
            let v10 = calculate_price_diff<T0, T1>(arg0, arg1, v6, v1);
            let v11 = (v5 + v6) / 2;
            let v12 = if (v9 < v10) {
                v6 = v11;
                v7 = v5;
                v9
            } else {
                v5 = v11;
                v7 = v2;
                v10
            };
            if (v12 < arg3) {
                break
            };
            v8 = v8 + 1;
        };
        let v13 = if (v1) {
            (429504816 as u128)
        } else {
            (79226673515401279992447579055 as u128)
        };
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg1, v1, false, v7, v13, arg6);
        let v17 = v16;
        let v18 = 0x2::coin::from_balance<T0>(v14, arg7);
        let v19 = 0x2::coin::from_balance<T1>(v15, arg7);
        let v20 = if (v1) {
            4295048017
        } else {
            79226673515401279992447579050
        };
        let v21 = &mut v18;
        let v22 = &mut v19;
        kriya_swap<T0, T1>(arg0, v1, v21, v22, v7, v20, arg6, arg5, arg7);
        let (v23, v24) = if (v1) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v18, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v17), arg7)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v19, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v17), arg7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg1, v23, v24, v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v18, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v19, 0x2::tx_context::sender(arg7));
    }

    public fun swap_optimal_arb_amount_reverse<T0, T1>(arg0: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: u128, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true);
        let (v1, v2) = if (0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::sqrt_price<T0, T1>(arg0) > v0) {
            let v3 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, v0, 18446744073709551615);
            (true, 18446744073709551615 - 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_specified(&v3))
        } else {
            let v4 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, v0, 18446744073709551615);
            (false, 18446744073709551615 - 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_specified(&v4))
        };
        let v5 = 0;
        let v6 = v2;
        let v7 = 0;
        let v8 = 0;
        while (v5 <= v6 && v8 < arg2) {
            let v9 = calculate_price_diff_reverse<T0, T1>(arg0, arg1, v5, v1);
            let v10 = calculate_price_diff_reverse<T0, T1>(arg0, arg1, v6, v1);
            let v11 = (v5 + v6) / 2;
            let v12 = if (v9 < v10) {
                v6 = v11;
                v7 = v5;
                v9
            } else {
                v5 = v11;
                v7 = v2;
                v10
            };
            if (v12 < arg3) {
                break
            };
            v8 = v8 + 1;
        };
        let v13 = if (v1) {
            429504816
        } else {
            79226673515401279992447579055
        };
        let (v14, v15, v16) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg4, arg1, v1, false, v7, (v13 as u128), arg6);
        let v17 = v16;
        let v18 = 0x2::coin::from_balance<T1>(v14, arg7);
        let v19 = 0x2::coin::from_balance<T0>(v15, arg7);
        let v20 = if (v1) {
            4295048017
        } else {
            79226673515401279992447579050
        };
        let v21 = &mut v19;
        let v22 = &mut v18;
        kriya_swap<T0, T1>(arg0, v1, v21, v22, v7, v20, arg6, arg5, arg7);
        let (v23, v24) = if (v1) {
            (0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v18, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v17), arg7)), 0x2::balance::zero<T0>())
        } else {
            (0x2::balance::zero<T1>(), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut v19, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v17), arg7)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg4, arg1, v23, v24, v17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v18, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v19, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

