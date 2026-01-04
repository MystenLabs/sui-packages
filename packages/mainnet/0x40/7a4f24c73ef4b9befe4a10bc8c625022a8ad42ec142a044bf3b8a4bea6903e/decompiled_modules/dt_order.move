module 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::dt_order {
    struct DeepPlan has copy, drop {
        from_user_wallet: u64,
        from_balance_manager: u64,
        from_deep_reserves: u64,
        deep_reserves_cover_order: bool,
    }

    struct CoverageFeePlan has copy, drop {
        from_wallet: u64,
        from_balance_manager: u64,
        user_covers_fee: bool,
    }

    struct ProtocolFeePlan has copy, drop {
        taker_fee_from_wallet: u64,
        taker_fee_from_balance_manager: u64,
        maker_fee_from_wallet: u64,
        maker_fee_from_balance_manager: u64,
        user_covers_fee: bool,
    }

    struct InputCoinDepositPlan has copy, drop {
        from_user_wallet: u64,
        user_has_enough_input_coin: bool,
    }

    struct TakerFeeCharged<phantom T0> has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        order_id: u128,
        client_order_id: u64,
        taker_fee: u64,
    }

    public fun cancel_order_and_settle_fees<T0, T1, T2>(arg0: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: u128, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg2, arg3, &v0, arg4, arg5, arg6);
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::settle_user_fees<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6)
    }

    public(friend) fun charge_protocol_fees<T0, T1>(arg0: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg1: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = if (arg9) {
            0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::deep_fee_type_rates(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::get_pool_fee_config<T0, T1>(arg1, arg2))
        } else {
            0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::input_coin_fee_type_rates(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::get_pool_fee_config<T0, T1>(arg1, arg2))
        };
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg6);
        let v3 = if (v2) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3)
        };
        let v4 = if (v2) {
            0x2::coin::value<T1>(arg5)
        } else {
            0x2::coin::value<T0>(arg4)
        };
        let v5 = get_protocol_fee_plan(arg6, v0, v1, v4, v3, arg7, arg8);
        if (v2) {
            execute_protocol_fee_plan<T1>(arg0, arg3, arg5, arg6, &v5, arg10);
        } else {
            execute_protocol_fee_plan<T0>(arg0, arg3, arg4, arg6, &v5, arg10);
        };
    }

    fun create_empty_coverage_fee_plan(arg0: bool) : CoverageFeePlan {
        CoverageFeePlan{
            from_wallet          : 0,
            from_balance_manager : 0,
            user_covers_fee      : arg0,
        }
    }

    fun create_empty_protocol_fee_plan(arg0: bool) : ProtocolFeePlan {
        ProtocolFeePlan{
            taker_fee_from_wallet          : 0,
            taker_fee_from_balance_manager : 0,
            maker_fee_from_wallet          : 0,
            maker_fee_from_balance_manager : 0,
            user_covers_fee                : arg0,
        }
    }

    public fun create_limit_order<T0, T1, T2, T3>(arg0: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg2: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg3: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: u64, arg14: u64, arg15: bool, arg16: u64, arg17: u8, arg18: u8, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg16 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg18 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_order_amount(arg14, arg13, arg15);
        let v1 = &mut arg9;
        let v2 = &mut arg10;
        let v3 = &mut arg11;
        let v4 = &mut arg12;
        let (v5, v6) = prepare_order_execution<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v1, v2, v3, v4, 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_deep_required<T0, T1>(arg4, arg14, arg13), v0, arg15, arg20, arg21, arg22, arg23, arg24, arg25);
        let v7 = v5;
        let v8 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg4, arg8, &v7, arg19, arg17, arg18, arg13, arg14, arg15, true, arg16, arg24, arg25);
        let v9 = &mut arg9;
        let v10 = &mut arg10;
        charge_protocol_fees<T0, T1>(arg1, arg2, arg4, arg8, v9, v10, &v8, v0, v6, true, arg25);
        (v8, arg9, arg10, arg11, arg12)
    }

    public fun create_limit_order_input_fee<T0, T1>(arg0: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg2: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg3: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: u8, arg13: u8, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg11 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg13 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_order_amount(arg9, arg8, arg10);
        let v1 = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::get_user_discount_rate(arg3, 0x2::tx_context::sender(arg16));
        let v2 = &mut arg6;
        let v3 = &mut arg7;
        let v4 = prepare_input_fee_order_execution<T0, T1>(arg4, arg5, v2, v3, v0, arg10, arg16);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg4, arg5, &v4, arg14, arg12, arg13, arg8, arg9, arg10, false, arg11, arg15, arg16);
        let v6 = &mut arg6;
        let v7 = &mut arg7;
        charge_protocol_fees<T0, T1>(arg1, arg2, arg4, arg5, v6, v7, &v5, v0, v1, false, arg16);
        (v5, arg6, arg7)
    }

    public fun create_limit_order_whitelisted<T0, T1>(arg0: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg2: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg3: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: bool, arg11: u64, arg12: u8, arg13: u8, arg14: u64, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg11 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg13 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_order_amount(arg9, arg8, arg10);
        let v1 = &mut arg6;
        let v2 = &mut arg7;
        let (v3, v4) = prepare_whitelisted_order_execution<T0, T1>(arg2, arg3, arg4, arg5, v1, v2, v0, arg10, arg16);
        let v5 = v3;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg4, arg5, &v5, arg14, arg12, arg13, arg8, arg9, arg10, true, arg11, arg15, arg16);
        let v7 = &mut arg6;
        let v8 = &mut arg7;
        charge_protocol_fees<T0, T1>(arg1, arg2, arg4, arg5, v7, v8, &v6, v0, v4, true, arg16);
        (v6, arg6, arg7)
    }

    public fun create_market_order<T0, T1, T2, T3>(arg0: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg2: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg3: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg9: 0x2::coin::Coin<T0>, arg10: 0x2::coin::Coin<T1>, arg11: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: u64, arg14: bool, arg15: u8, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: &0x2::clock::Clock, arg22: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg15 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, v1) = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_market_order_params<T0, T1>(arg4, arg13, arg14, arg21);
        let v2 = &mut arg9;
        let v3 = &mut arg10;
        let v4 = &mut arg11;
        let v5 = &mut arg12;
        let (v6, v7) = prepare_order_execution<T0, T1, T2, T3>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v2, v3, v4, v5, v1, arg13, arg14, arg17, arg18, arg19, arg20, arg21, arg22);
        let v8 = v6;
        let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg4, arg8, &v8, arg16, arg15, v0, arg14, true, arg21, arg22);
        let v10 = &mut arg9;
        let v11 = &mut arg10;
        charge_protocol_fees<T0, T1>(arg1, arg2, arg4, arg8, v10, v11, &v9, arg13, v7, true, arg22);
        (v9, arg9, arg10, arg11, arg12)
    }

    public fun create_market_order_input_fee<T0, T1>(arg0: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg2: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg3: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: bool, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg10 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, _) = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_market_order_params<T0, T1>(arg4, arg8, arg9, arg12);
        let v2 = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::get_user_discount_rate(arg3, 0x2::tx_context::sender(arg13));
        let v3 = &mut arg6;
        let v4 = &mut arg7;
        let v5 = prepare_input_fee_order_execution<T0, T1>(arg4, arg5, v3, v4, arg8, arg9, arg13);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg4, arg5, &v5, arg11, arg10, v0, arg9, false, arg12, arg13);
        let v7 = &mut arg6;
        let v8 = &mut arg7;
        charge_protocol_fees<T0, T1>(arg1, arg2, arg4, arg5, v7, v8, &v6, arg8, v2, false, arg13);
        (v6, arg6, arg7)
    }

    public fun create_market_order_whitelisted<T0, T1>(arg0: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg2: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg3: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg5: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: bool, arg10: u8, arg11: u64, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg10 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, _) = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_market_order_params<T0, T1>(arg4, arg8, arg9, arg12);
        let v2 = &mut arg6;
        let v3 = &mut arg7;
        let (v4, v5) = prepare_whitelisted_order_execution<T0, T1>(arg2, arg3, arg4, arg5, v2, v3, arg8, arg9, arg13);
        let v6 = v4;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg4, arg5, &v6, arg11, arg10, v0, arg9, true, arg12, arg13);
        let v8 = &mut arg6;
        let v9 = &mut arg7;
        charge_protocol_fees<T0, T1>(arg1, arg2, arg4, arg5, v8, v9, &v7, arg8, v5, true, arg13);
        (v7, arg6, arg7)
    }

    public(friend) fun create_order_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: bool) : (DeepPlan, CoverageFeePlan, InputCoinDepositPlan) {
        let v0 = arg11 && arg12;
        assert!(!v0, 11);
        let v1 = get_deep_plan(arg0, arg1, arg2, arg5, arg8);
        if (arg12 && v1.from_balance_manager > 0) {
            arg4 = arg4 - v1.from_balance_manager;
        };
        let v2 = get_coverage_fee_plan(v1.from_deep_reserves, arg0, arg10, arg6, arg3);
        if (arg11 && v2.from_balance_manager > 0) {
            arg4 = arg4 - v2.from_balance_manager;
        };
        (v1, v2, get_input_coin_deposit_plan(arg9, arg7, arg4))
    }

    public(friend) fun execute_coverage_fee_plan(arg0: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &CoverageFeePlan, arg4: &mut 0x2::tx_context::TxContext) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg3.user_covers_fee, 2);
        if (arg3.from_wallet > 0) {
            0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::join_coverage_fee<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3.from_wallet));
        };
        if (arg3.from_balance_manager > 0) {
            0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::join_coverage_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, arg3.from_balance_manager, arg4)));
        };
    }

    public(friend) fun execute_deep_plan(arg0: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &DeepPlan, arg4: &mut 0x2::tx_context::TxContext) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(arg3.deep_reserves_cover_order, 1);
        if (arg3.from_user_wallet > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3.from_user_wallet, arg4), arg4);
        };
        if (arg3.from_deep_reserves > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::split_deep_reserves(arg0, arg3.from_deep_reserves, arg4), arg4);
        };
    }

    public(friend) fun execute_input_coin_deposit_plan<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &InputCoinDepositPlan, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.user_has_enough_input_coin, 3);
        if (arg3.from_user_wallet > 0) {
            if (arg4) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg0, 0x2::coin::split<T1>(arg2, arg3.from_user_wallet, arg5), arg5);
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::split<T0>(arg1, arg3.from_user_wallet, arg5), arg5);
            };
        };
    }

    public(friend) fun execute_protocol_fee_plan<T0>(arg0: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::FeeManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg4: &ProtocolFeePlan, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.user_covers_fee, 2);
        let v0 = 0x2::balance::zero<T0>();
        if (arg4.taker_fee_from_wallet > 0) {
            0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4.taker_fee_from_wallet));
        };
        if (arg4.taker_fee_from_balance_manager > 0) {
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg4.taker_fee_from_balance_manager, arg5)));
        };
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 > 0) {
            0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::add_to_protocol_unsettled_fees<T0>(arg0, v0, arg5);
            let v2 = TakerFeeCharged<T0>{
                pool_id            : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::pool_id(arg3),
                balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::balance_manager_id(arg3),
                order_id           : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::order_id(arg3),
                client_order_id    : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::client_order_id(arg3),
                taker_fee          : v1,
            };
            0x2::event::emit<TakerFeeCharged<T0>>(v2);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
        let v3 = 0x2::balance::zero<T0>();
        if (arg4.maker_fee_from_wallet > 0) {
            0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4.maker_fee_from_wallet));
        };
        if (arg4.maker_fee_from_balance_manager > 0) {
            0x2::balance::join<T0>(&mut v3, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg4.maker_fee_from_balance_manager, arg5)));
        };
        if (0x2::balance::value<T0>(&v3) > 0) {
            0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee_manager::add_to_user_unsettled_fees<T0>(arg0, v3, arg3, arg5);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
    }

    public(friend) fun get_coverage_fee_plan(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64) : CoverageFeePlan {
        if (arg1 || arg0 == 0) {
            return zero_coverage_fee_plan()
        };
        assert!(arg2 > 0, 9);
        let v0 = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::calculate_deep_reserves_coverage_order_fee(arg2, arg0);
        if (arg3 + arg4 < v0) {
            return insufficient_coverage_fee_plan()
        };
        let (v1, v2) = plan_fee_collection(v0, arg3, arg4);
        CoverageFeePlan{
            from_wallet          : v1,
            from_balance_manager : v2,
            user_covers_fee      : true,
        }
    }

    public(friend) fun get_deep_plan(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : DeepPlan {
        if (arg0) {
            return DeepPlan{
                from_user_wallet          : 0,
                from_balance_manager      : 0,
                from_deep_reserves        : 0,
                deep_reserves_cover_order : true,
            }
        };
        let v0 = arg2 + arg3;
        if (v0 >= arg1) {
            let (v2, v3) = if (arg2 >= arg1) {
                (0, arg1)
            } else {
                (arg1 - arg2, arg2)
            };
            DeepPlan{from_user_wallet: v2, from_balance_manager: v3, from_deep_reserves: 0, deep_reserves_cover_order: true}
        } else {
            let v4 = arg1 - v0;
            if (!(arg4 >= v4)) {
                return DeepPlan{
                    from_user_wallet          : 0,
                    from_balance_manager      : 0,
                    from_deep_reserves        : 0,
                    deep_reserves_cover_order : false,
                }
            };
            DeepPlan{from_user_wallet: arg3, from_balance_manager: arg2, from_deep_reserves: v4, deep_reserves_cover_order: true}
        }
    }

    public(friend) fun get_input_coin_deposit_plan(arg0: u64, arg1: u64, arg2: u64) : InputCoinDepositPlan {
        if (arg2 >= arg0) {
            return InputCoinDepositPlan{
                from_user_wallet           : 0,
                user_has_enough_input_coin : true,
            }
        };
        let v0 = arg0 - arg2;
        if (!(arg1 >= v0)) {
            return InputCoinDepositPlan{
                from_user_wallet           : 0,
                user_has_enough_input_coin : false,
            }
        };
        InputCoinDepositPlan{
            from_user_wallet           : v0,
            user_has_enough_input_coin : true,
        }
    }

    public(friend) fun get_protocol_fee_plan(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : ProtocolFeePlan {
        let (v0, v1) = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_order_taker_maker_ratio(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(arg0));
        let (v2, v3, v4) = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::calculate_protocol_fees(v0, v1, arg1, arg2, arg5, arg6);
        if (v2 == 0) {
            return zero_protocol_fee_plan()
        };
        if (arg3 + arg4 < v2) {
            return insufficient_protocol_fee_plan()
        };
        let (v5, v6) = plan_fee_collection(v3, arg3, arg4);
        let (v7, v8) = plan_fee_collection(v4, arg3 - v5, arg4 - v6);
        ProtocolFeePlan{
            taker_fee_from_wallet          : v5,
            taker_fee_from_balance_manager : v6,
            maker_fee_from_wallet          : v7,
            maker_fee_from_balance_manager : v8,
            user_covers_fee                : true,
        }
    }

    fun insufficient_coverage_fee_plan() : CoverageFeePlan {
        create_empty_coverage_fee_plan(false)
    }

    fun insufficient_protocol_fee_plan() : ProtocolFeePlan {
        create_empty_protocol_fee_plan(false)
    }

    public(friend) fun plan_fee_collection(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        if (arg0 == 0) {
            return (0, 0)
        };
        assert!(arg1 + arg2 >= arg0, 2);
        if (arg2 >= arg0) {
            (0, arg0)
        } else {
            (arg0 - arg2, arg2)
        }
    }

    public(friend) fun prepare_input_fee_order_execution<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg1) == 0x2::tx_context::sender(arg6), 4);
        let v0 = if (arg5) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg1)
        };
        let v1 = if (arg5) {
            0x2::coin::value<T1>(arg3)
        } else {
            0x2::coin::value<T0>(arg2)
        };
        let (v2, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg0);
        let v5 = get_input_coin_deposit_plan(arg4 + 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::calculate_input_coin_deepbook_fee(arg4, v2), v1, v0);
        execute_input_coin_deposit_plan<T0, T1>(arg1, arg2, arg3, &v5, arg5, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6)
    }

    public(friend) fun prepare_order_execution<T0, T1, T2, T3>(arg0: &mut 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::Treasury, arg1: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg2: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg8: &mut 0x2::coin::Coin<T0>, arg9: &mut 0x2::coin::Coin<T1>, arg10: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg11: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, u64) {
        0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::verify_version(arg0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg7) == 0x2::tx_context::sender(arg20), 4);
        let v0 = 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::get_sui_per_deep<T2, T3>(arg5, arg6, arg4, arg19);
        let v1 = if (arg14) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg7)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg7)
        };
        let v2 = if (arg14) {
            0x2::coin::value<T1>(arg9)
        } else {
            0x2::coin::value<T0>(arg8)
        };
        let v3 = arg14 && 0x1::type_name::with_original_ids<T1>() == 0x1::type_name::with_original_ids<0x2::sui::SUI>() || 0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<0x2::sui::SUI>();
        let v4 = arg14 && 0x1::type_name::with_original_ids<T1>() == 0x1::type_name::with_original_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>() || 0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>();
        let (v5, v6, v7) = create_order_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg3), arg12, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg7), v1, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10), 0x2::coin::value<0x2::sui::SUI>(arg11), v2, 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::treasury::deep_reserves(arg0), arg13, v0, v3, v4);
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        validate_fees_against_max(arg12, v10.from_deep_reserves, v0, arg15, arg16, arg17, arg18);
        let v11 = 0x1::u64::min(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::calculate_deep_fee_coverage_discount_rate(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::max_deep_fee_coverage_discount_rate(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::get_pool_fee_config<T0, T1>(arg1, arg3)), v10.from_deep_reserves, arg12) + 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::get_user_discount_rate(arg2, 0x2::tx_context::sender(arg20)), 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::hundred_percent());
        execute_deep_plan(arg0, arg7, arg10, &v10, arg20);
        execute_coverage_fee_plan(arg0, arg7, arg11, &v9, arg20);
        execute_input_coin_deposit_plan<T0, T1>(arg7, arg8, arg9, &v8, arg14, arg20);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg7, arg20), v11)
    }

    public(friend) fun prepare_whitelisted_order_execution<T0, T1>(arg0: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::TradingFeeConfig, arg1: &0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::LoyaltyProgram, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, u64) {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg3) == 0x2::tx_context::sender(arg8), 4);
        let v0 = if (arg7) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3)
        };
        let v1 = if (arg7) {
            0x2::coin::value<T1>(arg5)
        } else {
            0x2::coin::value<T0>(arg4)
        };
        let v2 = 0x1::u64::min(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::max_deep_fee_coverage_discount_rate(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::get_pool_fee_config<T0, T1>(arg0, arg2)) + 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::loyalty::get_user_discount_rate(arg1, 0x2::tx_context::sender(arg8)), 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::hundred_percent());
        let v3 = get_input_coin_deposit_plan(arg6, v1, v0);
        execute_input_coin_deposit_plan<T0, T1>(arg3, arg4, arg5, &v3, arg7, arg8);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg8), v2)
    }

    public(friend) fun validate_fees_against_max(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg4 <= 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::hundred_percent(), 10);
        assert!(arg6 <= 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::hundred_percent(), 10);
        assert!(arg0 <= 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::apply_slippage(arg3, arg4), 5);
        if (arg1 > 0) {
            assert!(0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::fee::calculate_deep_reserves_coverage_order_fee(arg2, arg1) <= 0x407a4f24c73ef4b9befe4a10bc8c625022a8ad42ec142a044bf3b8a4bea6903e::helper::apply_slippage(arg5, arg6), 6);
        };
    }

    fun zero_coverage_fee_plan() : CoverageFeePlan {
        create_empty_coverage_fee_plan(true)
    }

    fun zero_protocol_fee_plan() : ProtocolFeePlan {
        create_empty_protocol_fee_plan(true)
    }

    // decompiled from Move bytecode v6
}

