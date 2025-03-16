module 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::order {
    struct DeepPlan has copy, drop {
        use_wrapper_deep_reserves: bool,
        from_user_wallet: u64,
        from_deep_reserves: u64,
        deep_reserves_cover_order: bool,
    }

    struct FeePlan has copy, drop {
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

    public fun create_limit_order<T0, T1, T2, T3>(arg0: &mut 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: u8, arg13: u8, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg3) == 0x2::tx_context::sender(arg16), 9223372560841048069);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1);
        let v1 = if (arg10) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3)
        };
        let v2 = if (arg10) {
            0x2::coin::value<T1>(&arg5)
        } else {
            0x2::coin::value<T0>(&arg4)
        };
        let (v3, v4, v5) = create_limit_order_core(v0, 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::calculate_deep_required<T0, T1>(arg1, arg9, arg8), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg3), v1, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg6), 0x2::coin::value<0x2::sui::SUI>(&arg7), v2, 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::get_deep_reserves_value(arg0), arg9, arg8, arg10, 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::get_sui_per_deep<T2, T3>(arg2, arg15));
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        let v9 = &mut arg6;
        execute_deep_plan(arg0, arg3, v9, &v8, arg16);
        let v10 = &mut arg7;
        execute_fee_plan(arg0, arg3, v10, &v7, arg16);
        let v11 = &mut arg4;
        let v12 = &mut arg5;
        execute_input_coin_deposit_plan<T0, T1>(arg3, v11, v12, &v6, arg10, arg16);
        0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::transfer_if_nonzero<T0>(arg4, 0x2::tx_context::sender(arg16));
        0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::transfer_if_nonzero<T1>(arg5, 0x2::tx_context::sender(arg16));
        0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6, 0x2::tx_context::sender(arg16));
        0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::transfer_if_nonzero<0x2::sui::SUI>(arg7, 0x2::tx_context::sender(arg16));
        let v13 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg16);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg1, arg3, &v13, arg14, arg12, arg13, arg8, arg9, arg10, !v0, arg11, arg15, arg16)
    }

    public(friend) fun create_limit_order_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: u64) : (DeepPlan, FeePlan, InputCoinDepositPlan) {
        let v0 = get_deep_plan(arg0, arg1, arg2, arg5, arg8);
        (v0, get_fee_plan(v0.use_wrapper_deep_reserves, v0.from_deep_reserves, arg0, arg12, arg6, arg3), get_input_coin_deposit_plan(0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::calculate_order_amount(arg9, arg10, arg11), arg7, arg4))
    }

    public fun create_limit_order_whitelisted<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: u8, arg9: u8, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) == 0x2::tx_context::sender(arg12), 9223373114891829253);
        let v0 = if (arg6) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1)
        };
        let v1 = if (arg6) {
            0x2::coin::value<T1>(&arg3)
        } else {
            0x2::coin::value<T0>(&arg2)
        };
        let v2 = get_input_coin_deposit_plan(0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::calculate_order_amount(arg5, arg4, arg6), v1, v0);
        let v3 = &mut arg2;
        let v4 = &mut arg3;
        execute_input_coin_deposit_plan<T0, T1>(arg1, v3, v4, &v2, arg6, arg12);
        0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::transfer_if_nonzero<T0>(arg2, 0x2::tx_context::sender(arg12));
        0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::transfer_if_nonzero<T1>(arg3, 0x2::tx_context::sender(arg12));
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg12);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, &v5, arg10, arg8, arg9, arg4, arg5, arg6, !0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), arg7, arg11, arg12)
    }

    public fun estimate_order_requirements<T0, T1, T2, T3>(arg0: &0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::Wrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &0x2::clock::Clock) : (bool, u64, u64) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        estimate_order_requirements_core(0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::get_deep_reserves_value(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), v0, v1, v2, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::calculate_deep_required<T0, T1>(arg1, arg7, arg8), 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::get_sui_per_deep<T2, T3>(arg2, arg10))
    }

    public(friend) fun estimate_order_requirements_core(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64) : (bool, u64, u64) {
        let v0 = get_deep_plan(arg1, arg14, arg5, arg8, arg0);
        if (v0.use_wrapper_deep_reserves && !v0.deep_reserves_cover_order) {
            return (false, arg14, 0)
        };
        let (v1, _, _) = 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::fee::estimate_full_order_fee_core(arg1, arg5, arg8, arg14, arg15);
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

    fun execute_deep_plan(arg0: &mut 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &DeepPlan, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3.use_wrapper_deep_reserves) {
            assert!(arg3.deep_reserves_cover_order, 9223375979634753537);
        };
        if (arg3.from_user_wallet > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3.from_user_wallet, arg4), arg4);
        };
        if (arg3.from_deep_reserves > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::split_deep_reserves(arg0, arg3.from_deep_reserves, arg4), arg4);
        };
    }

    fun execute_fee_plan(arg0: &mut 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &FeePlan, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3.fee_amount > 0) {
            assert!(arg3.user_covers_wrapper_fee, 9223376177203380227);
        };
        if (arg3.from_user_wallet > 0) {
            0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::join_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg3.from_user_wallet, arg4)));
        };
        if (arg3.from_user_balance_manager > 0) {
            0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::join_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, arg3.from_user_balance_manager, arg4)));
        };
    }

    fun execute_input_coin_deposit_plan<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &InputCoinDepositPlan, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3.order_amount > 0) {
            assert!(arg3.user_has_enough_input_coin, 9223376353297039363);
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
            return FeePlan{
                fee_amount                : 0,
                from_user_wallet          : 0,
                from_user_balance_manager : 0,
                user_covers_wrapper_fee   : true,
            }
        };
        let (v0, _, _) = 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::fee::calculate_full_order_fee(arg3, arg1);
        if (v0 == 0) {
            return FeePlan{
                fee_amount                : 0,
                from_user_wallet          : 0,
                from_user_balance_manager : 0,
                user_covers_wrapper_fee   : true,
            }
        };
        let v3 = arg4 + arg5 >= v0;
        if (!v3) {
            return FeePlan{
                fee_amount                : v0,
                from_user_wallet          : 0,
                from_user_balance_manager : 0,
                user_covers_wrapper_fee   : false,
            }
        };
        let v4 = if (arg4 >= v0) {
            v0
        } else {
            arg4
        };
        let v5 = if (v4 < v0) {
            v0 - v4
        } else {
            0
        };
        FeePlan{
            fee_amount                : v0,
            from_user_wallet          : v4,
            from_user_balance_manager : v5,
            user_covers_wrapper_fee   : v3,
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
        arg8 && (arg6 && arg1 + arg3 >= 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::math::mul(arg4, arg5) + arg7 || arg1 + arg3 >= 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::math::mul(arg4, arg5)) || arg6 && arg0 + arg2 >= arg4 + arg7 || arg0 + arg2 >= arg4
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

    public fun will_use_wrapper_deep_reserves<T0, T1>(arg0: &0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::Wrapper, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u64, arg4: u64, arg5: u64) : (bool, bool) {
        let v0 = get_deep_plan(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg1), 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::helper::calculate_deep_required<T0, T1>(arg1, arg4, arg5), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2), arg3, 0x71e83f083b87f2e6a6c266e7f9f279550c0a1e5a0d8ce1425fceec674e04a5c::wrapper::get_deep_reserves_value(arg0));
        (v0.use_wrapper_deep_reserves, v0.deep_reserves_cover_order)
    }

    // decompiled from Move bytecode v6
}

