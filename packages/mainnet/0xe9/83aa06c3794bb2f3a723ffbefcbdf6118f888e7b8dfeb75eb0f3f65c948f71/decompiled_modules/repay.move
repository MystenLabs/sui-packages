module 0xe983aa06c3794bb2f3a723ffbefcbdf6118f888e7b8dfeb75eb0f3f65c948f71::repay {
    struct RepaymentPlan has copy, drop, store {
        repay_from_mm_balance: u64,
        deposit_base_amount: u64,
        deposit_quote_amount: u64,
        swap_amount: u64,
        swap_fee: u64,
        swap_output_amount: u64,
        swap_base_to_quote: bool,
        remaining_deficit: u64,
        has_swap_error_min_size: bool,
        has_swap_error_liquidity: bool,
    }

    public(friend) fun calculate_fee_by_rate(arg0: u64, arg1: u64) : u64 {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(arg0, arg1)
    }

    public(friend) fun calculate_initial_deficit(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (bool, u64, u64, u64) {
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

    public(friend) fun calculate_principal_from_available(arg0: u64, arg1: u64) : u64 {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::div(arg0, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::constants::float_scaling() + arg1)
    }

    public(friend) fun calculate_total_fee_rate(arg0: u64, arg1: u64) : u64 {
        0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::math::mul(arg0, 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::constants::fee_penalty_multiplier()), 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::constants::float_scaling() + arg1)
    }

    public(friend) fun check_swap_feasibility<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u8 {
        let (v0, _, v2, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_level2_ticks_from_mid<T0, T1>(arg0, 1, arg3);
        let v4 = v2;
        let v5 = v0;
        if (arg1) {
            if (0x1::vector::is_empty<u64>(&v4)) {
                return 2
            };
        } else if (0x1::vector::is_empty<u64>(&v5)) {
            return 2
        };
        let (_, _, v8) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::pool_book_params<T0, T1>(arg0);
        if (arg1) {
            if (arg2 < v8) {
                return 1
            };
        } else {
            let (_, v10, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_quote_quantity_out<T0, T1>(arg0, v8, arg3);
            if (arg2 < v10) {
                return 1
            };
        };
        0
    }

    public(friend) fun get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        if (arg1) {
            let (v2, v3, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_base_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_quote_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v6, v5)
        }
    }

    public(friend) fun get_opposite_asset_required_for_repayment<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (arg1) {
            let (_, v2, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_quote_quantity_in<T0, T1>(arg0, arg2, true, arg3);
            v2
        } else {
            let (v4, _, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_base_quantity_in<T0, T1>(arg0, arg2, true, arg3);
            v4
        }
    }

    public fun get_repayment_plan<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: bool, arg10: u64, arg11: &0x2::clock::Clock) : RepaymentPlan {
        assert!(arg3 == 0 || arg4 == 0, 2);
        if (arg3 == 0 && arg4 == 0) {
            return zero_repayment_plan()
        };
        let (v0, v1, v2, v3) = calculate_initial_deficit(arg1, arg2, arg3, arg4);
        if (v2 == 0) {
            return RepaymentPlan{
                repay_from_mm_balance    : v3,
                deposit_base_amount      : 0,
                deposit_quote_amount     : 0,
                swap_amount              : 0,
                swap_fee                 : 0,
                swap_output_amount       : 0,
                swap_base_to_quote       : !v0,
                remaining_deficit        : 0,
                has_swap_error_min_size  : false,
                has_swap_error_liquidity : false,
            }
        };
        let (v4, v5, v6, v7, v8) = if (arg9) {
            plan_mm_swap<T0, T1>(arg0, v0, v2, v1, arg10, arg11)
        } else {
            (0, 0, v2, false, false)
        };
        let (v9, v10, v11, v12, v13, v14, v15) = plan_wallet_actions<T0, T1>(arg0, v0, v6, arg5, arg6, arg7, arg8, arg9, v4, v2 - v6, arg10, arg11);
        let v16 = if (v0) {
            v9
        } else {
            v10
        };
        let v17 = if (v0) {
            v10
        } else {
            v9
        };
        let v18 = v4 + v11;
        let v19 = if (v18 > 0) {
            v2 - v9 - v13
        } else {
            0
        };
        let v20 = v18 == 0;
        let v21 = v20 && (v8 || v15);
        let v22 = v20 && (v7 || v14);
        RepaymentPlan{
            repay_from_mm_balance    : v3,
            deposit_base_amount      : v16,
            deposit_quote_amount     : v17,
            swap_amount              : v18,
            swap_fee                 : v5 + v12,
            swap_output_amount       : v19,
            swap_base_to_quote       : !v0,
            remaining_deficit        : v13,
            has_swap_error_min_size  : v22,
            has_swap_error_liquidity : v21,
        }
    }

    public(friend) fun plan_mm_swap<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64, u64, bool, bool) {
        plan_swap_internal<T0, T1>(arg0, arg1, arg2, arg3, 0, 0, arg4, arg5)
    }

    public(friend) fun plan_swap_internal<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : (u64, u64, u64, bool, bool) {
        if (arg2 == 0 || arg3 == 0) {
            return (0, 0, arg2, false, false)
        };
        let (v0, _, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = calculate_total_fee_rate(v0, arg6);
        let v4 = check_swap_feasibility<T0, T1>(arg0, arg1, arg2, arg7);
        if (v4 != 0) {
            return (0, 0, arg2, v4 == 1, v4 == 2)
        };
        let v5 = get_opposite_asset_required_for_repayment<T0, T1>(arg0, arg1, arg5 + arg2, arg7);
        if (v5 > 0) {
            assert!(v5 > arg4, 3);
            let v6 = v5 - arg4;
            let v7 = calculate_fee_by_rate(v6, v3);
            if (arg3 >= v6 + v7) {
                return (v6, v7, 0, false, false)
            };
        };
        let v8 = calculate_principal_from_available(arg3, v3);
        let v9 = v8;
        if (!arg1) {
            let (_, v11, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::pool_book_params<T0, T1>(arg0);
            v9 = v8 - v8 % v11;
        };
        if (v9 == 0) {
            return (0, 0, arg2, true, false)
        };
        let v13 = arg4 + v9;
        let (v14, v15) = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, arg1, v13, arg7);
        assert!(v13 >= v15, 1);
        let v16 = v13 - v15;
        assert!(v16 >= arg4, 4);
        let v17 = v16 - arg4;
        if (v17 == 0) {
            return (0, 0, arg2, false, true)
        };
        let v18 = calculate_fee_by_rate(v17, v3);
        assert!(v17 + v18 <= arg3, 0);
        assert!(v14 >= arg5, 5);
        let v19 = v14 - arg5;
        let v20 = if (arg2 > v19) {
            arg2 - v19
        } else {
            0
        };
        (v17, v18, v20, false, false)
    }

    public(friend) fun plan_wallet_actions<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) : (u64, u64, u64, u64, u64, bool, bool) {
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

    public(friend) fun plan_wallet_swap<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : (u64, u64, u64, bool, bool) {
        plan_swap_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    fun zero_repayment_plan() : RepaymentPlan {
        RepaymentPlan{
            repay_from_mm_balance    : 0,
            deposit_base_amount      : 0,
            deposit_quote_amount     : 0,
            swap_amount              : 0,
            swap_fee                 : 0,
            swap_output_amount       : 0,
            swap_base_to_quote       : false,
            remaining_deficit        : 0,
            has_swap_error_min_size  : false,
            has_swap_error_liquidity : false,
        }
    }

    // decompiled from Move bytecode v6
}

