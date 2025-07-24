module 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::order {
    struct DeepPlan has copy, drop {
        from_user_wallet: u64,
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

    public fun cancel_order_and_settle_fees<T0, T1, T2>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg2) == 0x2::tx_context::sender(arg5), 4);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5);
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::unsettled_fees::settle_user_fees<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5)
    }

    public(friend) fun charge_protocol_fees<T0, T1>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        let (v0, v1) = if (arg9) {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::deep_fee_type_rates(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::get_pool_fee_config<T0, T1>(arg1, arg2))
        } else {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::input_coin_fee_type_rates(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::get_pool_fee_config<T0, T1>(arg1, arg2))
        };
        let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::is_bid(arg6);
        let v3 = if (v2) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg3)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg3)
        };
        let v4 = if (v2) {
            0x2::coin::value<T1>(&arg5)
        } else {
            0x2::coin::value<T0>(&arg4)
        };
        let v5 = get_protocol_fee_plan(arg6, v0, v1, v4, v3, arg7, arg8);
        if (v2) {
            let v6 = &mut arg5;
            execute_protocol_fee_plan<T1>(arg0, arg3, v6, arg6, &v5, arg10);
        } else {
            let v7 = &mut arg4;
            execute_protocol_fee_plan<T0>(arg0, arg3, v7, arg6, &v5, arg10);
        };
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::transfer_if_nonzero<T0>(arg4, 0x2::tx_context::sender(arg10));
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::transfer_if_nonzero<T1>(arg5, 0x2::tx_context::sender(arg10));
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

    public fun create_limit_order<T0, T1, T2, T3>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u8, arg17: u8, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: &0x2::clock::Clock, arg24: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg15 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg17 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_order_amount(arg13, arg12, arg14);
        let v1 = &mut arg8;
        let v2 = &mut arg9;
        let (v3, v4) = prepare_order_execution<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v1, v2, arg10, arg11, 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_deep_required<T0, T1>(arg3, arg13, arg12), v0, arg14, arg19, arg20, arg21, arg22, arg23, arg24);
        let v5 = v3;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg7, &v5, arg18, arg16, arg17, arg12, arg13, arg14, true, arg15, arg23, arg24);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg3, arg7, arg8, arg9, &v6, v0, v4, true, arg24);
        v6
    }

    public fun create_limit_order_input_fee<T0, T1>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u8, arg12: u8, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg10 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg12 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_order_amount(arg8, arg7, arg9);
        let v1 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::get_user_discount_rate(arg2, 0x2::tx_context::sender(arg15));
        let v2 = &mut arg5;
        let v3 = &mut arg6;
        let v4 = prepare_input_fee_order_execution<T0, T1>(arg3, arg4, v2, v3, v0, arg9, arg15);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg4, &v4, arg13, arg11, arg12, arg7, arg8, arg9, false, arg10, arg14, arg15);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, &v5, v0, v1, false, arg15);
        v5
    }

    public fun create_limit_order_whitelisted<T0, T1>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: u8, arg12: u8, arg13: u64, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg10 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg12 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_order_amount(arg8, arg7, arg9);
        let v1 = &mut arg5;
        let v2 = &mut arg6;
        let (v3, v4) = prepare_whitelisted_order_execution<T0, T1>(arg1, arg2, arg3, arg4, v1, v2, v0, arg9, arg15);
        let v5 = v3;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg3, arg4, &v5, arg13, arg11, arg12, arg7, arg8, arg9, true, arg10, arg14, arg15);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, &v6, v0, v4, true, arg15);
        v6
    }

    public fun create_market_order<T0, T1, T2, T3>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: u64, arg13: bool, arg14: u8, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg14 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, v1) = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_market_order_params<T0, T1>(arg3, arg12, arg13, arg20);
        let v2 = &mut arg8;
        let v3 = &mut arg9;
        let (v4, v5) = prepare_order_execution<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v2, v3, arg10, arg11, v1, arg12, arg13, arg16, arg17, arg18, arg19, arg20, arg21);
        let v6 = v4;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg3, arg7, &v6, arg15, arg14, v0, arg13, true, arg20, arg21);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg3, arg7, arg8, arg9, &v7, arg12, v5, true, arg21);
        v7
    }

    public fun create_market_order_input_fee<T0, T1>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: bool, arg9: u8, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg9 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, _) = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_market_order_params<T0, T1>(arg3, arg7, arg8, arg11);
        let v2 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::get_user_discount_rate(arg2, 0x2::tx_context::sender(arg12));
        let v3 = &mut arg5;
        let v4 = &mut arg6;
        let v5 = prepare_input_fee_order_execution<T0, T1>(arg3, arg4, v3, v4, arg7, arg8, arg12);
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg3, arg4, &v5, arg10, arg9, v0, arg8, false, arg11, arg12);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, &v6, arg7, v2, false, arg12);
        v6
    }

    public fun create_market_order_whitelisted<T0, T1>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg5: 0x2::coin::Coin<T0>, arg6: 0x2::coin::Coin<T1>, arg7: u64, arg8: bool, arg9: u8, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg9 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, _) = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_market_order_params<T0, T1>(arg3, arg7, arg8, arg11);
        let v2 = &mut arg5;
        let v3 = &mut arg6;
        let (v4, v5) = prepare_whitelisted_order_execution<T0, T1>(arg1, arg2, arg3, arg4, v2, v3, arg7, arg8, arg12);
        let v6 = v4;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg3, arg4, &v6, arg10, arg9, v0, arg8, true, arg11, arg12);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg3, arg4, arg5, arg6, &v7, arg7, v5, true, arg12);
        v7
    }

    public(friend) fun create_order_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (DeepPlan, CoverageFeePlan, InputCoinDepositPlan) {
        let v0 = get_deep_plan(arg0, arg1, arg2, arg5, arg8);
        (v0, get_coverage_fee_plan(v0.from_deep_reserves, arg0, arg10, arg6, arg3), get_input_coin_deposit_plan(arg9, arg7, arg4))
    }

    fun execute_coverage_fee_plan(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &CoverageFeePlan, arg4: &mut 0x2::tx_context::TxContext) {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg3.user_covers_fee, 2);
        if (arg3.from_wallet > 0) {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::join_deep_reserves_coverage_fee<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3.from_wallet));
        };
        if (arg3.from_balance_manager > 0) {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::join_deep_reserves_coverage_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, arg3.from_balance_manager, arg4)));
        };
    }

    fun execute_deep_plan(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &DeepPlan, arg4: &mut 0x2::tx_context::TxContext) {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg3.deep_reserves_cover_order, 1);
        if (arg3.from_user_wallet > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3.from_user_wallet, arg4), arg4);
        };
        if (arg3.from_deep_reserves > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::split_deep_reserves(arg0, arg3.from_deep_reserves, arg4), arg4);
        };
    }

    fun execute_input_coin_deposit_plan<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &InputCoinDepositPlan, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.user_has_enough_input_coin, 3);
        if (arg3.from_user_wallet > 0) {
            if (arg4) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg0, 0x2::coin::split<T1>(arg2, arg3.from_user_wallet, arg5), arg5);
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::split<T0>(arg1, arg3.from_user_wallet, arg5), arg5);
            };
        };
    }

    fun execute_protocol_fee_plan<T0>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg4: &ProtocolFeePlan, arg5: &mut 0x2::tx_context::TxContext) {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(arg4.user_covers_fee, 2);
        if (arg4.taker_fee_from_wallet > 0) {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::join_protocol_fee<T0>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4.taker_fee_from_wallet));
        };
        if (arg4.taker_fee_from_balance_manager > 0) {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::join_protocol_fee<T0>(arg0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg4.taker_fee_from_balance_manager, arg5)));
        };
        let v0 = 0x2::balance::zero<T0>();
        if (arg4.maker_fee_from_wallet > 0) {
            0x2::balance::join<T0>(&mut v0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4.maker_fee_from_wallet));
        };
        if (arg4.maker_fee_from_balance_manager > 0) {
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg4.maker_fee_from_balance_manager, arg5)));
        };
        if (0x2::balance::value<T0>(&v0) > 0) {
            0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::unsettled_fees::add_unsettled_fee<T0>(arg0, v0, arg3);
        } else {
            0x2::balance::destroy_zero<T0>(v0);
        };
    }

    public(friend) fun get_coverage_fee_plan(arg0: u64, arg1: bool, arg2: u64, arg3: u64, arg4: u64) : CoverageFeePlan {
        if (arg1 || arg0 == 0) {
            return zero_coverage_fee_plan()
        };
        assert!(arg2 > 0, 9);
        let v0 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::calculate_deep_reserves_coverage_order_fee(arg2, arg0);
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
            DeepPlan{from_user_wallet: v2, from_deep_reserves: 0, deep_reserves_cover_order: true}
        } else {
            let v3 = arg1 - v0;
            if (!(arg4 >= v3)) {
                return DeepPlan{
                    from_user_wallet          : 0,
                    from_deep_reserves        : 0,
                    deep_reserves_cover_order : false,
                }
            };
            DeepPlan{from_user_wallet: arg3, from_deep_reserves: v3, deep_reserves_cover_order: true}
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
        let (v0, v1) = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_order_taker_maker_ratio(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(arg0));
        let (v2, v3, v4) = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::calculate_protocol_fees(v0, v1, arg1, arg2, arg5, arg6);
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

    fun prepare_input_fee_order_execution<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
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
        let v5 = get_input_coin_deposit_plan(arg4 + 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::calculate_input_coin_deepbook_fee(arg4, v2), v1, v0);
        execute_input_coin_deposit_plan<T0, T1>(arg1, arg2, arg3, &v5, arg5, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6)
    }

    fun prepare_order_execution<T0, T1, T2, T3>(arg0: &mut 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::Wrapper, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg2: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg8: &mut 0x2::coin::Coin<T0>, arg9: &mut 0x2::coin::Coin<T1>, arg10: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, u64) {
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::verify_version(arg0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg7) == 0x2::tx_context::sender(arg20), 4);
        let v0 = 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::get_sui_per_deep<T2, T3>(arg5, arg6, arg4, arg19);
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
        let (v3, v4, v5) = create_order_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg3), arg12, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg7), v1, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg10), 0x2::coin::value<0x2::sui::SUI>(&arg11), v2, 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::wrapper::deep_reserves(arg0), arg13, v0);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        validate_fees_against_max(arg12, v8.from_deep_reserves, v0, arg15, arg16, arg17, arg18);
        let v9 = 0x1::u64::min(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::calculate_deep_fee_coverage_discount_rate(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::max_deep_fee_coverage_discount_rate(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::get_pool_fee_config<T0, T1>(arg1, arg3)), v8.from_deep_reserves, arg12) + 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::get_user_discount_rate(arg2, 0x2::tx_context::sender(arg20)), 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::hundred_percent());
        let v10 = &mut arg10;
        execute_deep_plan(arg0, arg7, v10, &v8, arg20);
        let v11 = &mut arg11;
        execute_coverage_fee_plan(arg0, arg7, v11, &v7, arg20);
        execute_input_coin_deposit_plan<T0, T1>(arg7, arg8, arg9, &v6, arg14, arg20);
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg10, 0x2::tx_context::sender(arg20));
        0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::transfer_if_nonzero<0x2::sui::SUI>(arg11, 0x2::tx_context::sender(arg20));
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg7, arg20), v9)
    }

    fun prepare_whitelisted_order_execution<T0, T1>(arg0: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::TradingFeeConfig, arg1: &0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::LoyaltyProgram, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: &mut 0x2::coin::Coin<T0>, arg5: &mut 0x2::coin::Coin<T1>, arg6: u64, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, u64) {
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
        let v2 = 0x1::u64::min(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::max_deep_fee_coverage_discount_rate(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::get_pool_fee_config<T0, T1>(arg0, arg2)) + 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::loyalty::get_user_discount_rate(arg1, 0x2::tx_context::sender(arg8)), 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::hundred_percent());
        let v3 = get_input_coin_deposit_plan(arg6, v1, v0);
        execute_input_coin_deposit_plan<T0, T1>(arg3, arg4, arg5, &v3, arg7, arg8);
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg3, arg8), v2)
    }

    public(friend) fun validate_fees_against_max(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg4 <= 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::hundred_percent(), 10);
        assert!(arg6 <= 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::hundred_percent(), 10);
        assert!(arg0 <= 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::apply_slippage(arg3, arg4), 5);
        if (arg1 > 0) {
            assert!(0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::fee::calculate_deep_reserves_coverage_order_fee(arg2, arg1) <= 0x90fb2cbdb7cc57aec8feffd32b556918cf6f7b1e7eeffcb800630b667d9604e7::helper::apply_slippage(arg5, arg6), 6);
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

