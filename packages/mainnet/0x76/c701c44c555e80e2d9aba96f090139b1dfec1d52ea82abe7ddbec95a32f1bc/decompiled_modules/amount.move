module 0x76c701c44c555e80e2d9aba96f090139b1dfec1d52ea82abe7ddbec95a32f1bc::amount {
    struct ArbState {
        swap_amount: u64,
        price_diff: u128,
        a2b: bool,
    }

    public fun calculate_optimal_arb_amount<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64) : ArbState {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2) = if (0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::sqrt_price<T0, T1>(arg0) > v0) {
            let v3 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, v0, 18446744073709551615);
            (true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v3))
        } else {
            let v4 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, v0, 18446744073709551615);
            (false, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v4))
        };
        let v5 = 0;
        let v6 = 2 * v2;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v5 <= v6 && v8 < arg2) {
            let v10 = calculate_price_diff<T0, T1>(arg0, arg1, v5, v1);
            let v11 = calculate_price_diff<T0, T1>(arg0, arg1, v6, v1);
            v6 = (v5 + v6) / 2;
            if (v10 < v11) {
                v7 = v5;
                v9 = v10;
            } else {
                v5 = v6;
                v7 = v6;
                v9 = v11;
            };
            if (v9 < v9 * 1000 / 1000000) {
                break
            };
            v8 = v8 + 1;
        };
        ArbState{
            swap_amount : v7,
            price_diff  : v9,
            a2b         : v1,
        }
    }

    public fun calculate_optimal_arb_amount_reverse<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64) : u128 {
        let v0 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true);
        let (v1, v2) = if (0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::sqrt_price<T0, T1>(arg0) > v0) {
            let v3 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, v0, 18446744073709551615);
            (true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v3))
        } else {
            let v4 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, v0, 18446744073709551615);
            (false, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v4))
        };
        calculate_price_diff_reverse<T0, T1>(arg0, arg1, v2, v1)
    }

    fun calculate_price_diff<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            let v1 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, false, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v1));
            let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v2);
            let v4 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2));
            let v5 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_sqrt_price(&v4);
            if (v5 > v3) {
                v5 - v3
            } else {
                v3 - v5
            }
        } else {
            let v6 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
            let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v6));
            let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v7);
            let v9 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, v8, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7));
            let v10 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_sqrt_price(&v9);
            if (v8 > v10) {
                v8 - v10
            } else {
                v10 - v8
            }
        }
    }

    fun calculate_price_diff_reverse<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: bool) : u128 {
        if (arg3) {
            let v1 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true), arg2);
            let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, true, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v1));
            let v3 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v2), true);
            let v4 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, true, true, v3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2));
            let v5 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_sqrt_price(&v4);
            if (v5 > v3) {
                v5 - v3
            } else {
                v3 - v5
            }
        } else {
            let v6 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), true), arg2);
            let v7 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, false, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_amount_calculated(&v6));
            let v8 = 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::compute_swap_result<T0, T1>(arg0, false, true, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v7), true), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v7));
            0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::trade::get_state_sqrt_price(&v8)
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

    // decompiled from Move bytecode v6
}

