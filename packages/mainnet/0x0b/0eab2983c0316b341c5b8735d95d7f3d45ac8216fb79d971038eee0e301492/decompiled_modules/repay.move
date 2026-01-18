module 0xb0eab2983c0316b341c5b8735d95d7f3d45ac8216fb79d971038eee0e301492::repay {
    struct RepaymentPlan has copy, drop, store {
        repay_from_mm_balance: u64,
        deposit_base_amount: u64,
        deposit_quote_amount: u64,
        swap_amount: u64,
        swap_fee: u64,
        swap_output_amount: u64,
        swap_amount_with_slippage: u64,
        swap_fee_with_slippage: u64,
        swap_output_amount_with_slippage: u64,
        swap_base_to_quote: bool,
        remaining_deficit: u64,
        has_swap_error_min_size: bool,
        has_swap_error_liquidity: bool,
    }

    public(friend) fun apply_swap_slippage<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        if (arg2 == 0 || arg7 == 0) {
            return (arg2, arg3, arg4, 0)
        };
        validate_prior_swap<T0, T1>(arg0, arg1, arg2, arg4, arg10);
        let v0 = arg5 + arg6;
        if (v0 == 0) {
            return (arg2, arg3, arg4, 0)
        };
        let (v1, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v4 = calculate_total_fee_rate(v1, arg9);
        let v5 = arg2 + calculate_max_available_amount_for_swap(v0, v4);
        let (_, v7) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, arg1, v5, arg10);
        let v8 = v5 - v7;
        if (v8 == arg2) {
            return (arg2, arg3, arg4, 0)
        };
        let v9 = v8 - arg2;
        let v10 = if (arg8) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg2, arg7)
        } else {
            arg7
        };
        let v11 = arg2 + v10;
        let (_, v13) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, arg1, v11, arg10);
        let v14 = v11 - v13;
        if (v14 == arg2) {
            return (arg2, arg3, arg4, 0)
        };
        let v15 = v14 - arg2;
        let v16 = if (v9 < v15) {
            v9
        } else {
            v15
        };
        let v17 = calculate_fee_by_rate(v16, v4);
        let v18 = v16 + v17;
        let v19 = if (arg5 >= v18) {
            v18
        } else {
            arg5
        };
        let v20 = arg2 + v16;
        let (v21, _) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, arg1, v20, arg10);
        (v20, arg3 + v17, v21, v18 - v19)
    }

    public(friend) fun calculate_fee_by_rate(arg0: u64, arg1: u64) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg0, arg1)
    }

    public(friend) fun calculate_initial_deficit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (bool, u64, u64, u64) {
        assert!(arg2 == 0 || arg3 == 0, 2);
        let v0 = arg2 > 0;
        let v1 = if (v0) {
            arg2
        } else {
            arg3
        };
        let v2 = if (v0) {
            arg0
        } else {
            arg1
        };
        let v3 = if (v0) {
            arg1
        } else {
            arg0
        };
        let v4 = if (v1 > v2) {
            v1 - v2
        } else {
            0
        };
        let v5 = if (v2 >= v1) {
            v1
        } else {
            v2
        };
        (v0, v3, v4, v5)
    }

    public(friend) fun calculate_max_available_amount_for_swap(arg0: u64, arg1: u64) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + arg1)
    }

    public(friend) fun calculate_total_fee_rate(arg0: u64, arg1: u64) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + arg1)
    }

    public(friend) fun check_swap_feasibility<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u8 {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        if (arg1) {
            let v3 = get_opposite_asset_required_for_repayment<T0, T1>(arg0, true, v2 + v1 + arg4, arg6);
            if (v3 == 0) {
                return 2
            };
            let v4 = v3 - arg3;
            if (arg2 < v4 + calculate_fee_by_rate(v4, arg5)) {
                return 1
            };
        } else {
            if (arg2 < v2 + calculate_fee_by_rate(v2, arg5)) {
                return 1
            };
            let (_, v6) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, false, v2 + arg3, arg6);
            if (v6 > 0) {
                return 2
            };
        };
        0
    }

    public(friend) fun get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        if (arg1) {
            let (v2, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v6, v5)
        }
    }

    public(friend) fun get_opposite_asset_required_for_repayment<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg1) {
            let (_, v2, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_in<T0, T1>(arg0, arg2, true, arg3);
            v2
        } else {
            let (v4, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_in<T0, T1>(arg0, arg2, true, arg3);
            v4
        }
    }

    public fun get_repayment_plan<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: bool, arg12: u64, arg13: &0x2::clock::Clock) : RepaymentPlan {
        assert!(arg3 == 0 || arg4 == 0, 2);
        if (arg3 == 0 && arg4 == 0) {
            return zero_repayment_plan()
        };
        let (v0, v1, v2, v3) = calculate_initial_deficit(arg1, arg2, arg3, arg4);
        if (v2 == 0) {
            return RepaymentPlan{
                repay_from_mm_balance            : v3,
                deposit_base_amount              : 0,
                deposit_quote_amount             : 0,
                swap_amount                      : 0,
                swap_fee                         : 0,
                swap_output_amount               : 0,
                swap_amount_with_slippage        : 0,
                swap_fee_with_slippage           : 0,
                swap_output_amount_with_slippage : 0,
                swap_base_to_quote               : !v0,
                remaining_deficit                : 0,
                has_swap_error_min_size          : false,
                has_swap_error_liquidity         : false,
            }
        };
        let (v4, v5, v6, v7, v8) = if (arg9) {
            plan_mm_swap<T0, T1>(arg0, v0, v2, v1, arg12, arg13)
        } else {
            (0, 0, v2, false, false)
        };
        let (v9, v10, v11, v12, v13, v14, v15) = plan_wallet_actions<T0, T1>(arg0, v0, v6, arg5, arg6, arg7, arg8, arg9, v4, v2 - v6, arg12, arg13);
        let v16 = if (v0) {
            v9
        } else {
            v10
        };
        let v17 = v16;
        let v18 = if (v0) {
            v10
        } else {
            v9
        };
        let v19 = v18;
        let v20 = v4 + v11;
        let v21 = v5 + v12;
        let v22 = if (v20 > 0) {
            let (v23, _) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, v0, v20, arg13);
            v23
        } else {
            0
        };
        let v25 = v20 == 0;
        let v26 = v25 && (v8 || v15);
        let v27 = v25 && (v7 || v14);
        let v28 = if (v1 > v4 + v5) {
            v1 - v4 - v5
        } else {
            0
        };
        let v29 = if (arg8 && arg9) {
            let v30 = if (v0) {
                arg6
            } else {
                arg5
            };
            if (v30 > v11 + v12) {
                v30 - v11 - v12
            } else {
                0
            }
        } else {
            0
        };
        let (v31, v32, v33, v34) = apply_swap_slippage<T0, T1>(arg0, v0, v20, v21, v22, v28, v29, arg10, arg11, arg12, arg13);
        if (v0) {
            v19 = v18 + v34;
        } else {
            v17 = v16 + v34;
        };
        RepaymentPlan{
            repay_from_mm_balance            : v3,
            deposit_base_amount              : v17,
            deposit_quote_amount             : v19,
            swap_amount                      : v20,
            swap_fee                         : v21,
            swap_output_amount               : v22,
            swap_amount_with_slippage        : v31,
            swap_fee_with_slippage           : v32,
            swap_output_amount_with_slippage : v33,
            swap_base_to_quote               : !v0,
            remaining_deficit                : v13,
            has_swap_error_min_size          : v27,
            has_swap_error_liquidity         : v26,
        }
    }

    public(friend) fun plan_mm_swap<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64, u64, bool, bool) {
        if (arg1) {
            plan_swap_base_debt<T0, T1>(arg0, arg2, arg3, 0, 0, arg4, arg5)
        } else {
            plan_swap_quote_debt<T0, T1>(arg0, arg2, arg3, 0, 0, arg4, arg5)
        }
    }

    public(friend) fun plan_swap_base_debt<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, u64, bool, bool) {
        if (arg1 == 0 || arg2 == 0) {
            return (0, 0, arg1, false, false)
        };
        validate_prior_swap<T0, T1>(arg0, true, arg3, arg4, arg6);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = calculate_total_fee_rate(v0, arg5);
        let v4 = check_swap_feasibility<T0, T1>(arg0, true, arg2, arg3, arg4, v3, arg6);
        if (v4 != 0) {
            return (0, 0, arg1, v4 == 1, v4 == 2)
        };
        let (_, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v8 = v7 + v6;
        let v9 = if (arg1 < v8) {
            v8
        } else {
            arg1
        };
        let v10 = get_opposite_asset_required_for_repayment<T0, T1>(arg0, true, v9 + arg4, arg6);
        if (v10 > 0) {
            let v11 = v10 - arg3;
            let v12 = calculate_fee_by_rate(v11, v3);
            if (arg2 >= v11 + v12) {
                return (v11, v12, 0, false, false)
            };
        };
        assert!(arg1 > v8, 4);
        let v13 = arg3 + calculate_max_available_amount_for_swap(arg2, v3);
        let (v14, v15) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, true, v13, arg6);
        let v16 = v13 - v15 - arg3;
        let v17 = calculate_fee_by_rate(v16, v3);
        assert!(v16 + v17 <= arg2, 0);
        let v18 = v14 - arg4;
        assert!(v18 < arg1, 5);
        (v16, v17, arg1 - v18, false, false)
    }

    public(friend) fun plan_swap_quote_debt<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : (u64, u64, u64, bool, bool) {
        if (arg1 == 0 || arg2 == 0) {
            return (0, 0, arg1, false, false)
        };
        validate_prior_swap<T0, T1>(arg0, false, arg3, arg4, arg6);
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = calculate_total_fee_rate(v0, arg5);
        let v4 = check_swap_feasibility<T0, T1>(arg0, false, arg2, arg3, arg4, v3, arg6);
        if (v4 != 0) {
            return (0, 0, arg1, v4 == 1, v4 == 2)
        };
        let (_, _, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let (v8, _) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, false, v7 + arg3, arg6);
        if (v8 - arg4 >= arg1) {
            return (v7, calculate_fee_by_rate(v7, v3), 0, false, false)
        };
        let v10 = get_opposite_asset_required_for_repayment<T0, T1>(arg0, false, arg1 + arg4, arg6);
        if (v10 > 0) {
            let v11 = v10 - arg3;
            let v12 = calculate_fee_by_rate(v11, v3);
            if (arg2 >= v11 + v12) {
                return (v11, v12, 0, false, false)
            };
        };
        let v13 = calculate_max_available_amount_for_swap(arg2, v3);
        let (_, v15, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        let v17 = arg3 + v13 - v13 % v15;
        let (v18, v19) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, false, v17, arg6);
        let v20 = v17 - v19 - arg3;
        let v21 = calculate_fee_by_rate(v20, v3);
        assert!(v20 + v21 <= arg2, 0);
        let v22 = v18 - arg4;
        assert!(v22 < arg1, 5);
        (v20, v21, arg1 - v22, false, false)
    }

    public(friend) fun plan_wallet_actions<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, bool, bool) {
        if (arg2 == 0 || !arg5) {
            return (0, 0, 0, 0, arg2, false, false)
        };
        let v0 = if (arg1) {
            arg3
        } else {
            arg4
        };
        let (v1, v2) = if (v0 >= arg2) {
            (arg2, 0)
        } else {
            (v0, arg2 - v0)
        };
        if (v2 == 0) {
            return (v1, 0, 0, 0, 0, false, false)
        };
        if (!arg6 || !arg7) {
            return (v1, 0, 0, 0, v2, false, false)
        };
        let v3 = if (arg1) {
            arg4
        } else {
            arg3
        };
        let (v4, v5, v6, v7, v8) = plan_wallet_swap<T0, T1>(arg0, arg1, v2, v3, arg8, arg9, arg10, arg11);
        (v1, v4 + v5, v4, v5, v6, v7, v8)
    }

    public(friend) fun plan_wallet_swap<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : (u64, u64, u64, bool, bool) {
        if (arg1) {
            plan_swap_base_debt<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
        } else {
            plan_swap_quote_debt<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7)
        }
    }

    public(friend) fun swap_status_liquidity_error() : u8 {
        2
    }

    public(friend) fun swap_status_min_size_error() : u8 {
        1
    }

    public(friend) fun swap_status_success() : u8 {
        0
    }

    public(friend) fun validate_prior_swap<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        if (arg2 == 0 && arg3 == 0) {
            return
        };
        let (v0, v1) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, arg1, arg2, arg4);
        assert!(v0 == arg3, 3);
        assert!(v1 == 0, 1);
    }

    fun zero_repayment_plan() : RepaymentPlan {
        RepaymentPlan{
            repay_from_mm_balance            : 0,
            deposit_base_amount              : 0,
            deposit_quote_amount             : 0,
            swap_amount                      : 0,
            swap_fee                         : 0,
            swap_output_amount               : 0,
            swap_amount_with_slippage        : 0,
            swap_fee_with_slippage           : 0,
            swap_output_amount_with_slippage : 0,
            swap_base_to_quote               : false,
            remaining_deficit                : 0,
            has_swap_error_min_size          : false,
            has_swap_error_liquidity         : false,
        }
    }

    // decompiled from Move bytecode v6
}

