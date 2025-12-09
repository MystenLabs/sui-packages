module 0xd48465df9b193c920a5f858e55c587f93af44c13a0a5b16ce6ff5d7915292bf6::repay {
    struct RepaymentPlan has copy, drop, store {
        deposit_base_amount: u64,
        deposit_quote_amount: u64,
        swap_amount: u64,
        swap_base_to_quote: bool,
        remaining_deficit: u64,
    }

    public(friend) fun calculate_initial_deficit<T0, T1>(arg0: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::MarginManager<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg2: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg3: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg4: &0x2::clock::Clock) : (bool, u64, u64) {
        let v0 = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::margin_pool_id<T0, T1>(arg0);
        let (v1, v2) = if (0x1::option::is_some<0x2::object::ID>(&v0)) {
            if (0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::has_base_debt<T0, T1>(arg0)) {
                0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::calculate_debts<T0, T1, T0>(arg0, arg2, arg4)
            } else {
                0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::calculate_debts<T0, T1, T1>(arg0, arg3, arg4)
            }
        } else {
            (0, 0)
        };
        let (v3, v4) = 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::calculate_assets<T0, T1>(arg0, arg1);
        let v5 = v1 > 0;
        let v6 = if (v5) {
            v1
        } else {
            v2
        };
        let v7 = if (v5) {
            v3
        } else {
            v4
        };
        let v8 = if (v5) {
            v4
        } else {
            v3
        };
        let v9 = if (v6 > v7) {
            v6 - v7
        } else {
            0
        };
        (v5, v8, v9)
    }

    public(friend) fun get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let (v0, v1) = if (arg1) {
            let (v2, v3, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg2, arg3);
            (v2, v3)
        } else {
            let (v5, v6, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg2, arg3);
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
            let (v1, v2, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_quote_quantity_in<T0, T1>(arg0, arg2, false, arg3);
            let _ = v1;
            v2
        } else {
            let (v5, v6, _) = 0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::get_base_quantity_in<T0, T1>(arg0, arg2, false, arg3);
            let _ = v6;
            v5
        }
    }

    public fun get_repayment_plan<T0, T1>(arg0: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::MarginManager<T0, T1>, arg1: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg2: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg3: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock) : RepaymentPlan {
        let (v0, v1, v2) = calculate_initial_deficit<T0, T1>(arg0, arg1, arg2, arg3, arg9);
        if (v2 == 0) {
            return zero_repayment_plan(!v0)
        };
        let (v3, v4) = if (arg8) {
            plan_deficit_coverage_via_swap<T0, T1>(arg1, v0, v2, v1, arg9)
        } else {
            (0, v2)
        };
        let (v5, v6, v7, v8) = plan_wallet_actions<T0, T1>(arg1, v0, v4, arg4, arg5, arg6, arg7, arg8, arg9);
        let v9 = if (v0) {
            v5
        } else {
            v6
        };
        let v10 = if (v0) {
            v6
        } else {
            v5
        };
        RepaymentPlan{
            deposit_base_amount  : v9,
            deposit_quote_amount : v10,
            swap_amount          : v3 + v7,
            swap_base_to_quote   : !v0,
            remaining_deficit    : v8,
        }
    }

    public(friend) fun plan_deficit_coverage_via_swap<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : (u64, u64) {
        if (arg2 == 0) {
            return (0, 0)
        };
        let v0 = get_opposite_asset_required_for_repayment<T0, T1>(arg0, arg1, arg2, arg4);
        if (v0 == 0) {
            return (0, arg2)
        };
        if (arg3 >= v0) {
            (v0, 0)
        } else {
            let v3 = get_debt_covered_by_opposite_asset_swap<T0, T1>(arg0, arg1, arg3, arg4);
            let v4 = if (arg2 > v3) {
                arg2 - v3
            } else {
                0
            };
            (arg3, v4)
        }
    }

    public(friend) fun plan_wallet_actions<T0, T1>(arg0: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: bool, arg8: &0x2::clock::Clock) : (u64, u64, u64, u64) {
        if (arg2 == 0 || !arg5) {
            return (0, 0, 0, arg2)
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
            return (v1, 0, 0, 0)
        };
        if (!arg6 || !arg7) {
            return (v1, 0, 0, v2)
        };
        let v3 = if (arg1) {
            arg4
        } else {
            arg3
        };
        let (v4, v5) = plan_deficit_coverage_via_swap<T0, T1>(arg0, arg1, v2, v3, arg8);
        (v1, v4, v4, v5)
    }

    fun zero_repayment_plan(arg0: bool) : RepaymentPlan {
        RepaymentPlan{
            deposit_base_amount  : 0,
            deposit_quote_amount : 0,
            swap_amount          : 0,
            swap_base_to_quote   : arg0,
            remaining_deficit    : 0,
        }
    }

    // decompiled from Move bytecode v6
}

