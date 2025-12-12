module 0x33a5f6662a9252daa864ad3b2244fb7c879d85c27ba6d5dfa843947779ea4c84::repay {
    struct RepaymentPlan has copy, drop, store {
        repay_from_mm_balance: u64,
        deposit_base_amount: u64,
        deposit_quote_amount: u64,
        swap_amount: u64,
        swap_fee: u64,
        swap_base_to_quote: bool,
        remaining_deficit: u64,
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

    public(friend) fun get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let (v0, v1) = if (arg1) {
            let (v2, v3, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_base_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_quote_quantity_out<T0, T1>(arg0, arg2, arg3);
            (v5, v6)
        };
        if (arg1) {
            v0
        } else {
            v1
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
        if (arg3 == 0 && arg4 == 0) {
            return zero_repayment_plan()
        };
        let (v0, v1, v2, v3) = calculate_initial_deficit(arg1, arg2, arg3, arg4);
        if (v2 == 0) {
            return RepaymentPlan{
                repay_from_mm_balance : v3,
                deposit_base_amount   : 0,
                deposit_quote_amount  : 0,
                swap_amount           : 0,
                swap_fee              : 0,
                swap_base_to_quote    : !v0,
                remaining_deficit     : 0,
            }
        };
        let (v4, v5, v6) = if (arg9) {
            plan_deficit_coverage_via_swap<T0, T1>(arg0, v0, v2, v1, arg10, arg11)
        } else {
            (0, 0, v2)
        };
        let (v7, v8, v9, v10, v11) = plan_wallet_actions<T0, T1>(arg0, v0, v6, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v12 = if (v0) {
            v7
        } else {
            v8
        };
        let v13 = if (v0) {
            v8
        } else {
            v7
        };
        RepaymentPlan{
            repay_from_mm_balance : v3,
            deposit_base_amount   : v12,
            deposit_quote_amount  : v13,
            swap_amount           : v4 + v9,
            swap_fee              : v5 + v10,
            swap_base_to_quote    : !v0,
            remaining_deficit     : v11,
        }
    }

    public(friend) fun plan_deficit_coverage_via_swap<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        if (arg2 == 0) {
            return (0, 0, 0)
        };
        let (v0, _, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::pool_trade_params<T0, T1>(arg0);
        let v3 = calculate_total_fee_rate(v0, arg4);
        let v4 = get_opposite_asset_required_for_repayment<T0, T1>(arg0, arg1, arg2, arg5);
        if (v4 > 0) {
            let v5 = calculate_fee_by_rate(v4, v3);
            if (arg3 >= v4 + v5) {
                return (v4, v5, 0)
            };
        };
        let v6 = calculate_principal_from_available(arg3, v3);
        let v7 = v6;
        if (!arg1) {
            let (_, v9, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::pool_book_params<T0, T1>(arg0);
            v7 = v6 - v6 % v9;
        };
        let v11 = calculate_fee_by_rate(v7, v3);
        assert!(v7 + v11 <= arg3, 0);
        let v12 = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, arg1, v7, arg5);
        let v13 = if (arg2 > v12) {
            arg2 - v12
        } else {
            0
        };
        (v7, v11, v13)
    }

    public(friend) fun plan_wallet_actions<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: u64, arg9: &0x2::clock::Clock) : (u64, u64, u64, u64, u64) {
        if (arg2 == 0 || !arg5) {
            return (0, 0, 0, 0, arg2)
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
            return (v1, 0, 0, 0, 0)
        };
        if (!arg6 || !arg7) {
            return (v1, 0, 0, 0, v2)
        };
        let v3 = if (arg1) {
            arg4
        } else {
            arg3
        };
        let (v4, v5, v6) = plan_deficit_coverage_via_swap<T0, T1>(arg0, arg1, v2, v3, arg8, arg9);
        (v1, v4 + v5, v4, v5, v6)
    }

    fun zero_repayment_plan() : RepaymentPlan {
        RepaymentPlan{
            repay_from_mm_balance : 0,
            deposit_base_amount   : 0,
            deposit_quote_amount  : 0,
            swap_amount           : 0,
            swap_fee              : 0,
            swap_base_to_quote    : false,
            remaining_deficit     : 0,
        }
    }

    // decompiled from Move bytecode v6
}

