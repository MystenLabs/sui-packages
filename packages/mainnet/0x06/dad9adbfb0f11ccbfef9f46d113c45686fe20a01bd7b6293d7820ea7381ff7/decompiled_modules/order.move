module 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::order {
    struct DeepPlan has copy, drop {
        use_wrapper_deep_reserves: bool,
        from_user_wallet: u64,
        from_deep_reserves: u64,
        deep_reserves_cover_order: bool,
    }

    struct FeePlan has copy, drop {
        coverage_fee_from_wallet: u64,
        coverage_fee_from_balance_manager: u64,
        protocol_fee_from_wallet: u64,
        protocol_fee_from_balance_manager: u64,
        user_covers_wrapper_fee: bool,
    }

    struct InputCoinDepositPlan has copy, drop {
        order_amount: u64,
        from_user_wallet: u64,
        user_has_enough_input_coin: bool,
    }

    fun create_empty_fee_plan(arg0: bool) : FeePlan {
        FeePlan{
            coverage_fee_from_wallet          : 0,
            coverage_fee_from_balance_manager : 0,
            protocol_fee_from_wallet          : 0,
            protocol_fee_from_balance_manager : 0,
            user_covers_wrapper_fee           : arg0,
        }
    }

    public fun create_limit_order<T0, T1, T2, T3>(arg0: &mut 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: u8, arg13: u8, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = prepare_order_execution<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::calculate_deep_required<T0, T1>(arg1, arg9, arg8), 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::calculate_order_amount(arg9, arg8, arg10), arg10, arg15, arg16);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg3, &v0, arg14, arg12, arg13, arg8, arg9, arg10, !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), arg11, arg15, arg16)
    }

    public(friend) fun create_limit_order_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (DeepPlan, FeePlan, InputCoinDepositPlan) {
        let v0 = get_deep_plan(arg0, arg1, arg2, arg5, arg8);
        (v0, get_fee_plan(v0.use_wrapper_deep_reserves, v0.from_deep_reserves, arg0, arg10, arg6, arg3), get_input_coin_deposit_plan(arg9, arg7, arg4))
    }

    public fun create_limit_order_whitelisted<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = prepare_whitelisted_order_execution<T0, T1>(arg1, arg2, arg3, 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::calculate_order_amount(arg5, arg4, arg6), arg6, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, &v0, arg10, arg8, arg9, arg4, arg5, arg6, false, arg7, arg11, arg12)
    }

    public fun create_market_order<T0, T1, T2, T3>(arg0: &mut 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: bool, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let (v0, v1) = 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::calculate_market_order_params<T0, T1>(arg1, arg8, arg9, arg12);
        let v2 = prepare_order_execution<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, arg8, arg9, arg12, arg13);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, arg3, &v2, arg11, arg10, v0, arg9, !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), arg12, arg13)
    }

    public fun create_market_order_whitelisted<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: u8, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let (v0, _) = 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::calculate_market_order_params<T0, T1>(arg0, arg4, arg5, arg8);
        let v2 = prepare_whitelisted_order_execution<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg9);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v2, arg7, arg6, v0, arg5, false, arg8, arg9)
    }

    public fun estimate_order_requirements<T0, T1, T2, T3>(arg0: &0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::Wrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock) : (bool, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        estimate_order_requirements_core(0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::get_deep_reserves_value(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), v0, v1, v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::calculate_deep_required<T0, T1>(arg1, arg7, arg8), 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::get_sui_per_deep<T2, T3>(arg2, arg10))
    }

    public(friend) fun estimate_order_requirements_core(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64) : (bool, u64, u64) {
        let v0 = get_deep_plan(arg1, arg14, arg5, arg8, arg0);
        if (v0.use_wrapper_deep_reserves && !v0.deep_reserves_cover_order) {
            return (false, arg14, 0)
        };
        let (v1, _, _) = 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::fee::estimate_full_order_fee_core(arg1, arg5, arg8, arg14, arg15);
        let v4 = if (validate_pool_params_core(arg11, arg12, arg2, arg3, arg4)) {
            if (has_enough_input_coin_core(arg6, arg7, arg9, arg10, arg11, arg12, v0.use_wrapper_deep_reserves, v1, arg13)) {
                v0.deep_reserves_cover_order
            } else {
                false
            }
        } else {
            false
        };
        (v4, arg14, v1)
    }

    fun execute_deep_plan(arg0: &mut 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &DeepPlan, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3.use_wrapper_deep_reserves) {
            assert!(arg3.deep_reserves_cover_order, 9223377281009844225);
        };
        if (arg3.from_user_wallet > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3.from_user_wallet, arg4), arg4);
        };
        if (arg3.from_deep_reserves > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::split_deep_reserves(arg0, arg3.from_deep_reserves, arg4), arg4);
        };
    }

    fun execute_fee_plan(arg0: &mut 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &FeePlan, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.user_covers_wrapper_fee, 9223377478578470915);
        if (arg3.coverage_fee_from_wallet > 0) {
            0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::join_deep_reserves_coverage_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3.coverage_fee_from_wallet, arg4)));
        };
        if (arg3.coverage_fee_from_balance_manager > 0) {
            0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::join_deep_reserves_coverage_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, arg3.coverage_fee_from_balance_manager, arg4)));
        };
        if (arg3.protocol_fee_from_wallet > 0) {
            0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::join_protocol_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3.protocol_fee_from_wallet, arg4)));
        };
        if (arg3.protocol_fee_from_balance_manager > 0) {
            0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::join_protocol_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, arg3.protocol_fee_from_balance_manager, arg4)));
        };
    }

    fun execute_input_coin_deposit_plan<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &InputCoinDepositPlan, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3.order_amount > 0) {
            assert!(arg3.user_has_enough_input_coin, 9223377689031999493);
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

    public(friend) fun get_fee_plan(arg0: bool, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : FeePlan {
        if (arg2 || !arg0) {
            return zero_fee_plan()
        };
        let (v0, v1, v2) = 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::fee::calculate_full_order_fee(arg3, arg1);
        if (v0 == 0) {
            return zero_fee_plan()
        };
        if (arg4 + arg5 < v0) {
            return insufficient_fee_plan()
        };
        let (v3, v4) = plan_fee_collection(v1, arg4, arg5);
        let (v5, v6) = plan_fee_collection(v2, arg4 - v3, arg5 - v4);
        FeePlan{
            coverage_fee_from_wallet          : v3,
            coverage_fee_from_balance_manager : v4,
            protocol_fee_from_wallet          : v5,
            protocol_fee_from_balance_manager : v6,
            user_covers_wrapper_fee           : true,
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
        arg8 && (arg6 && arg1 + arg3 >= 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::math::mul(arg4, arg5) + arg7 || arg1 + arg3 >= 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::math::mul(arg4, arg5)) || arg6 && arg0 + arg2 >= arg4 + arg7 || arg0 + arg2 >= arg4
    }

    fun insufficient_fee_plan() : FeePlan {
        create_empty_fee_plan(false)
    }

    public(friend) fun plan_fee_collection(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg0 == 0) {
            return (0, 0)
        };
        assert!(arg1 + arg2 >= arg0, 9223376383361810435);
        if (arg2 >= arg0) {
            (0, arg0)
        } else {
            (arg0 - arg2, arg2)
        }
    }

    fun prepare_order_execution<T0, T1, T2, T3>(arg0: &mut 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::Wrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg3) == 0x2::tx_context::sender(arg12), 9223376628175208455);
        let v0 = if (arg10) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3)
        };
        let v1 = if (arg10) {
            0x2::coin::value<T1>(&arg5)
        } else {
            0x2::coin::value<T0>(&arg4)
        };
        let (v2, v3, v4) = create_limit_order_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), arg8, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg3), v0, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg6), 0x2::coin::value<0x2::sui::SUI>(&arg7), v1, 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::get_deep_reserves_value(arg0), arg9, 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::get_sui_per_deep<T2, T3>(arg2, arg11));
        let v5 = v4;
        let v6 = v3;
        let v7 = v2;
        let v8 = &mut arg6;
        execute_deep_plan(arg0, arg3, v8, &v7, arg12);
        let v9 = &mut arg7;
        execute_fee_plan(arg0, arg3, v9, &v6, arg12);
        let v10 = &mut arg4;
        let v11 = &mut arg5;
        execute_input_coin_deposit_plan<T0, T1>(arg3, v10, v11, &v5, arg10, arg12);
        0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::transfer_if_nonzero<T0>(arg4, 0x2::tx_context::sender(arg12));
        0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::transfer_if_nonzero<T1>(arg5, 0x2::tx_context::sender(arg12));
        0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, 0x2::tx_context::sender(arg12));
        0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::transfer_if_nonzero<0x2::sui::SUI>(arg7, 0x2::tx_context::sender(arg12));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg12)
    }

    fun prepare_whitelisted_order_execution<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg0) == 0x2::tx_context::sender(arg5), 9223377044787036167);
        let v0 = if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
        };
        let v1 = if (arg4) {
            0x2::coin::value<T1>(&arg2)
        } else {
            0x2::coin::value<T0>(&arg1)
        };
        let v2 = get_input_coin_deposit_plan(arg3, v1, v0);
        let v3 = &mut arg1;
        let v4 = &mut arg2;
        execute_input_coin_deposit_plan<T0, T1>(arg0, v3, v4, &v2, arg4, arg5);
        0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::transfer_if_nonzero<T0>(arg1, 0x2::tx_context::sender(arg5));
        0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::transfer_if_nonzero<T1>(arg2, 0x2::tx_context::sender(arg5));
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg0, arg5)
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

    public fun will_use_wrapper_deep_reserves<T0, T1>(arg0: &0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::Wrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: u64) : (bool, bool) {
        let v0 = get_deep_plan(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::helper::calculate_deep_required<T0, T1>(arg1, arg4, arg5), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), arg3, 0x6dad9adbfb0f11ccbfef9f46d113c45686fe20a01bd7b6293d7820ea7381ff7::wrapper::get_deep_reserves_value(arg0));
        (v0.use_wrapper_deep_reserves, v0.deep_reserves_cover_order)
    }

    fun zero_fee_plan() : FeePlan {
        create_empty_fee_plan(true)
    }

    // decompiled from Move bytecode v6
}

