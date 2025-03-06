module 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::order {
    struct DeepPlan has copy, drop {
        use_wrapper_deep_reserves: bool,
        from_user_wallet: u64,
        from_deep_reserves: u64,
        deep_reserves_cover_order: bool,
    }

    struct FeePlan has copy, drop {
        fee_coin_type: u8,
        fee_amount: u64,
        from_user_wallet: u64,
        from_user_balance_manager: u64,
        user_covers_wrapper_fee: bool,
    }

    struct InputCoinDepositPlan has copy, drop {
        order_amount: u64,
        from_user_wallet: u64,
        user_has_enough_input_coin: bool,
    }

    public fun create_limit_order<T0, T1>(arg0: &mut 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::DeepBookV3RouterWrapper, arg1: &0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::whitelisted_pools::WhitelistRegistry, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u8, arg12: u8, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg3) == 0x2::tx_context::sender(arg15), 9223372496416538629);
        assert!(0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::whitelisted_pools::is_pool_whitelisted<T0, T1>(arg1, arg2), 9223372509301571591);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg2);
        let v1 = if (arg9) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3)
        };
        let v2 = if (arg9) {
            0x2::coin::value<T1>(&arg5)
        } else {
            0x2::coin::value<T0>(&arg4)
        };
        let (v3, v4, v5) = create_limit_order_core(v0, 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::calculate_deep_required<T0, T1>(arg2, arg8, arg7), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), v1, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg6), v2, 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::get_deep_reserves_value(arg0), arg8, arg7, arg9, 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::get_fee_bps<T0, T1>(arg2));
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = &mut arg6;
        execute_deep_plan(arg0, arg3, v9, &v8, arg15);
        let v10 = &mut arg4;
        let v11 = &mut arg5;
        execute_fee_plan<T0, T1>(arg0, arg3, v10, v11, &v7, arg15);
        let v12 = &mut arg4;
        let v13 = &mut arg5;
        execute_input_coin_deposit_plan<T0, T1>(arg3, v12, v13, &v6, arg9, arg15);
        0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::transfer_if_nonzero<T0>(arg4, 0x2::tx_context::sender(arg15));
        0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::transfer_if_nonzero<T1>(arg5, 0x2::tx_context::sender(arg15));
        0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, 0x2::tx_context::sender(arg15));
        let v14 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg15);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg3, &v14, arg13, arg11, arg12, arg7, arg8, arg9, !v0, arg10, arg14, arg15)
    }

    public(friend) fun create_limit_order_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: u64) : (DeepPlan, FeePlan, InputCoinDepositPlan) {
        let v0 = get_deep_plan(arg0, arg1, arg2, arg4, arg6);
        let v1 = 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::calculate_order_amount(arg7, arg8, arg9);
        let v2 = get_fee_plan(v0.use_wrapper_deep_reserves, v0.from_deep_reserves, arg1, arg0, arg10, v1, arg9, arg5, arg3);
        (v0, v2, get_input_coin_deposit_plan(v1, arg5 - v2.from_user_wallet, arg3 - v2.from_user_balance_manager))
    }

    public fun estimate_order_requirements<T0, T1>(arg0: &0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::DeepBookV3RouterWrapper, arg1: &0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::whitelisted_pools::WhitelistRegistry, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : (bool, u64, u64) {
        if (!0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::whitelisted_pools::is_pool_whitelisted<T0, T1>(arg1, arg2)) {
            return (false, 0, 0)
        };
        let (v0, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg2);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg2);
        estimate_order_requirements_core(0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::get_deep_reserves_value(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg2), v0, v3, v4, v5, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::calculate_deep_required<T0, T1>(arg2, arg7, arg8))
    }

    public(friend) fun estimate_order_requirements_core(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64) : (bool, u64, u64) {
        let v0 = get_deep_plan(arg1, arg15, arg6, arg9, arg0);
        if (v0.use_wrapper_deep_reserves && !v0.deep_reserves_cover_order) {
            return (false, arg15, 0)
        };
        let v1 = 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::fee::estimate_full_fee_core(arg1, arg6, arg9, arg12, arg13, arg14, arg2, arg15);
        let v2 = if (validate_pool_params_core(arg12, arg13, arg3, arg4, arg5)) {
            if (has_enough_input_coin_core(arg7, arg8, arg10, arg11, arg12, arg13, v0.use_wrapper_deep_reserves, v1, arg14)) {
                v0.deep_reserves_cover_order
            } else {
                false
            }
        } else {
            false
        };
        (v2, arg15, v1)
    }

    fun execute_deep_plan(arg0: &mut 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::DeepBookV3RouterWrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &DeepPlan, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3.use_wrapper_deep_reserves) {
            assert!(arg3.deep_reserves_cover_order, 9223375313914822657);
        };
        if (arg3.from_user_wallet > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3.from_user_wallet, arg4), arg4);
        };
        if (arg3.from_deep_reserves > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::split_deep_reserves(arg0, arg3.from_deep_reserves, arg4), arg4);
        };
    }

    fun execute_fee_plan<T0, T1>(arg0: &mut 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::DeepBookV3RouterWrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: &FeePlan, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg4.fee_amount > 0) {
            assert!(arg4.user_covers_wrapper_fee, 9223375477123710979);
        };
        if (arg4.from_user_wallet > 0) {
            if (arg4.fee_coin_type == 1) {
                0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::join_fee<T0>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, arg4.from_user_wallet, arg5)));
            } else if (arg4.fee_coin_type == 2) {
                0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::join_fee<T1>(arg0, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, arg4.from_user_wallet, arg5)));
            };
        };
        if (arg4.from_user_balance_manager > 0) {
            if (arg4.fee_coin_type == 1) {
                0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::join_fee<T0>(arg0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg4.from_user_balance_manager, arg5)));
            } else if (arg4.fee_coin_type == 2) {
                0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::join_fee<T1>(arg0, 0x2::coin::into_balance<T1>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T1>(arg1, arg4.from_user_balance_manager, arg5)));
            };
        };
    }

    fun execute_input_coin_deposit_plan<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &InputCoinDepositPlan, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3.order_amount > 0) {
            assert!(arg3.user_has_enough_input_coin, 9223375713346912259);
        };
        if (arg3.from_user_wallet > 0) {
            if (arg4) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg0, 0x2::coin::split<T1>(arg2, arg3.from_user_wallet, arg5), arg5);
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::split<T0>(arg1, arg3.from_user_wallet, arg5), arg5);
            };
        };
    }

    public(friend) fun get_deep_plan(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : DeepPlan {
        if (arg0) {
            return DeepPlan{
                use_wrapper_deep_reserves : false,
                from_user_wallet          : 0,
                from_deep_reserves        : 0,
                deep_reserves_cover_order : true,
            }
        };
        let v0 = arg2 + arg3;
        if (v0 >= arg1) {
            let v2 = if (arg2 >= arg1) {
                0
            } else {
                arg1 - arg2
            };
            DeepPlan{use_wrapper_deep_reserves: false, from_user_wallet: v2, from_deep_reserves: 0, deep_reserves_cover_order: true}
        } else {
            let v3 = arg1 - v0;
            if (!(arg4 >= v3)) {
                return DeepPlan{
                    use_wrapper_deep_reserves : true,
                    from_user_wallet          : 0,
                    from_deep_reserves        : 0,
                    deep_reserves_cover_order : false,
                }
            };
            DeepPlan{use_wrapper_deep_reserves: true, from_user_wallet: arg3, from_deep_reserves: v3, deep_reserves_cover_order: true}
        }
    }

    public(friend) fun get_fee_plan(arg0: bool, arg1: u64, arg2: u64, arg3: bool, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u64) : FeePlan {
        if (arg3 || !arg0) {
            return FeePlan{
                fee_coin_type             : 0,
                fee_amount                : 0,
                from_user_wallet          : 0,
                from_user_balance_manager : 0,
                user_covers_wrapper_fee   : true,
            }
        };
        let v0 = 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::fee::calculate_full_fee(arg5, arg4, arg1, arg2);
        if (v0 == 0) {
            let v1 = if (arg6) {
                2
            } else {
                1
            };
            return FeePlan{
                fee_coin_type             : v1,
                fee_amount                : 0,
                from_user_wallet          : 0,
                from_user_balance_manager : 0,
                user_covers_wrapper_fee   : true,
            }
        };
        let v2 = arg7 + arg8 >= v0;
        if (!v2) {
            let v3 = if (arg6) {
                2
            } else {
                1
            };
            return FeePlan{
                fee_coin_type             : v3,
                fee_amount                : v0,
                from_user_wallet          : 0,
                from_user_balance_manager : 0,
                user_covers_wrapper_fee   : false,
            }
        };
        let v4 = if (arg7 >= v0) {
            v0
        } else {
            arg7
        };
        let v5 = if (v4 < v0) {
            v0 - v4
        } else {
            0
        };
        let v6 = if (arg6) {
            2
        } else {
            1
        };
        FeePlan{
            fee_coin_type             : v6,
            fee_amount                : v0,
            from_user_wallet          : v4,
            from_user_balance_manager : v5,
            user_covers_wrapper_fee   : v2,
        }
    }

    public(friend) fun get_input_coin_deposit_plan(arg0: u64, arg1: u64, arg2: u64) : InputCoinDepositPlan {
        if (arg2 >= arg0) {
            return InputCoinDepositPlan{
                order_amount               : arg0,
                from_user_wallet           : 0,
                user_has_enough_input_coin : true,
            }
        };
        let v0 = arg0 - arg2;
        if (!(arg1 >= v0)) {
            return InputCoinDepositPlan{
                order_amount               : arg0,
                from_user_wallet           : 0,
                user_has_enough_input_coin : false,
            }
        };
        InputCoinDepositPlan{
            order_amount               : arg0,
            from_user_wallet           : v0,
            user_has_enough_input_coin : true,
        }
    }

    public fun has_enough_input_coin<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: bool) : bool {
        has_enough_input_coin_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun has_enough_input_coin_core(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: bool) : bool {
        arg8 && (arg6 && arg1 + arg3 >= 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::math::mul(arg4, arg5) + arg7 || arg1 + arg3 >= 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::math::mul(arg4, arg5)) || arg6 && arg0 + arg2 >= arg4 + arg7 || arg0 + arg2 >= arg4
    }

    public fun validate_pool_params<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: u64) : bool {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg0);
        validate_pool_params_core(arg1, arg2, v0, v1, v2)
    }

    public(friend) fun validate_pool_params_core(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (arg0 >= arg4) {
            if (arg0 % arg3 == 0) {
                arg1 % arg2 == 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun will_use_wrapper_deep_reserves<T0, T1>(arg0: &0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::DeepBookV3RouterWrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: u64) : (bool, bool) {
        let v0 = get_deep_plan(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::helper::calculate_deep_required<T0, T1>(arg1, arg4, arg5), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), arg3, 0x66029aed9e8aed79ffd543e831cd5755772c59ffe141943679b2caa861cfdc02::wrapper::get_deep_reserves_value(arg0));
        (v0.use_wrapper_deep_reserves, v0.deep_reserves_cover_order)
    }

    // decompiled from Move bytecode v6
}

