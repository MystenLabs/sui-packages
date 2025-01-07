module 0x163d947d24784089f322d7381c2cb2daae2639eb715d9d91658c755913bad8b0::amount {
    struct ArbState {
        swap_amount: u64,
        profit: u64,
        price_diff: u128,
        a2b: bool,
    }

    public fun calculate_optimal_arb_amount<T0, T1>(arg0: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : ArbState {
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1);
        let (v1, v2) = if (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::sqrt_price<T0, T1>(arg0) > v0) {
            let v3 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, true, true, v0, 18446744073709551615);
            (true, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v3))
        } else {
            let v4 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, false, true, v0, 18446744073709551615);
            (false, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v4))
        };
        let v5 = 0;
        let v6 = 2 * v2;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v5 <= v6 && v9 < 20) {
            let (v11, v12) = calculate_profit_and_price_diff<T0, T1>(arg0, arg1, v5, v1);
            let (v13, v14) = calculate_profit_and_price_diff<T0, T1>(arg0, arg1, v6, v1);
            v6 = (v5 + v6) / 2;
            if (v12 < v14) {
                v7 = v5;
                v10 = v12;
                v8 = v11;
            } else {
                v5 = v6;
                v7 = v6;
                v10 = v14;
                v8 = v13;
            };
            if (v10 < v10 * 1000 / 1000000) {
                break
            };
            v9 = v9 + 1;
        };
        ArbState{
            swap_amount : v7,
            profit      : v8,
            price_diff  : v10,
            a2b         : v1,
        }
    }

    public fun calculate_optimal_arb_amount_reverse<T0, T1>(arg0: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>) : ArbState {
        let v0 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), false);
        let (v1, v2) = if (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::sqrt_price<T0, T1>(arg0) > v0) {
            let v3 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, true, true, v0, 18446744073709551615);
            (true, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v3))
        } else {
            let v4 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, false, true, v0, 18446744073709551615);
            (false, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v4))
        };
        let v5 = 0;
        let v6 = 2 * v2;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 0;
        while (v5 <= v6 && v9 < 20) {
            let (v11, v12) = calculate_profit_and_price_diff_reverse<T0, T1>(arg0, arg1, v5, v1);
            let (v13, v14) = calculate_profit_and_price_diff_reverse<T0, T1>(arg0, arg1, v6, v1);
            v6 = (v5 + v6) / 2;
            if (v12 < v14) {
                v7 = v5;
                v10 = v12;
                v8 = v11;
            } else {
                v5 = v6;
                v7 = v6;
                v10 = v14;
                v8 = v13;
            };
            if (v10 < v10 * 1000 / 1000000) {
                break
            };
            v9 = v9 + 1;
        };
        ArbState{
            swap_amount : v7,
            profit      : v8,
            price_diff  : v10,
            a2b         : v1,
        }
    }

    fun calculate_profit_and_price_diff<T0, T1>(arg0: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: bool) : (u64, u128) {
        if (arg3) {
            let v2 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, true, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
            let v3 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v2);
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, false, true, v3);
            let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v4);
            let v6 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, true, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4));
            let v7 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_sqrt_price(&v6);
            let v8 = if (v7 > v5) {
                v7 - v5
            } else {
                v5 - v7
            };
            (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v6) - v3, v8)
        } else {
            let v9 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, false, true, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), arg2);
            let v10 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v9);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, true, true, v10);
            let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v11);
            let v13 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, false, true, v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v11));
            let v14 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_sqrt_price(&v13);
            let v15 = if (v12 > v14) {
                v12 - v14
            } else {
                v14 - v12
            };
            (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v13) - v10, v15)
        }
    }

    fun calculate_profit_and_price_diff_reverse<T0, T1>(arg0: &0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg2: u64, arg3: bool) : (u64, u128) {
        if (arg3) {
            let v2 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, true, true, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), false), arg2);
            let v3 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v2);
            let v4 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, false, true, v3);
            let v5 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v4), false);
            let v6 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, true, true, v5, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v4));
            let v7 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_sqrt_price(&v6);
            let v8 = if (v7 > v5) {
                v7 - v5
            } else {
                v5 - v7
            };
            (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v6) - v3, v8)
        } else {
            let v9 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, false, true, 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg1), false), arg2);
            let v10 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v9);
            let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T1, T0>(arg1, true, true, v10);
            let v12 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::math_u128::checked_div_round(340282366920938463463374607431768211455, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_after_sqrt_price(&v11), false);
            let v13 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::compute_swap_result<T0, T1>(arg0, false, true, v12, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v11));
            let v14 = 0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_sqrt_price(&v13);
            let v15 = if (v12 > v14) {
                v12 - v14
            } else {
                v14 - v12
            };
            (0xd5c688df869bb0f90b1a77c594f8578291c08dddc695b97ffbf21de9cf5bc59e::trade::get_state_amount_calculated(&v13) - v10, v15)
        }
    }

    public fun get_a2b(arg0: &ArbState) : bool {
        arg0.a2b
    }

    public fun get_price_diff(arg0: &ArbState) : u128 {
        arg0.price_diff
    }

    public fun get_profit(arg0: &ArbState) : u64 {
        arg0.profit
    }

    public fun get_swap_amount(arg0: &ArbState) : u64 {
        arg0.swap_amount
    }

    // decompiled from Move bytecode v6
}

