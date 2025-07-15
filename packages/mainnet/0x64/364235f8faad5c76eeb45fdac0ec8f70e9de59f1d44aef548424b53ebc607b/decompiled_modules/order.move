module 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::order {
    struct DeepPlan has copy, drop {
        use_wrapper_deep_reserves: bool,
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
        order_amount: u64,
        from_user_wallet: u64,
        user_has_enough_input_coin: bool,
    }

    public fun cancel_order_and_settle_fees<T0, T1, T2>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg2) == 0x2::tx_context::sender(arg5), 4);
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::cancel_order<T0, T1>(arg1, arg2, &v0, arg3, arg4, arg5);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::settle_user_fees<T0, T1, T2>(arg0, arg1, arg2, arg3, arg5)
    }

    public(friend) fun charge_protocol_fees<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        let (v0, v1) = if (arg9) {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::deep_fee_type_rates(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::get_pool_fee_config<T0, T1>(arg1, arg2))
        } else {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::input_coin_fee_type_rates(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::get_pool_fee_config<T0, T1>(arg1, arg2))
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
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::transfer_if_nonzero<T0>(arg4, 0x2::tx_context::sender(arg10));
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::transfer_if_nonzero<T1>(arg5, 0x2::tx_context::sender(arg10));
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

    public fun create_limit_order<T0, T1, T2, T3>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u8, arg16: u8, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: u64, arg22: &0x2::clock::Clock, arg23: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg14 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg16 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_order_amount(arg12, arg11, arg13);
        let v1 = &mut arg7;
        let v2 = &mut arg8;
        let (v3, v4) = prepare_order_execution<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v1, v2, arg9, arg10, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_deep_required<T0, T1>(arg2, arg12, arg11), v0, arg13, arg18, arg19, arg20, arg21, arg22, arg23);
        let v5 = v3;
        let v6 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg6, &v5, arg17, arg15, arg16, arg11, arg12, arg13, true, arg14, arg22, arg23);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, &v6, v0, v4, true, arg23);
        v6
    }

    public fun create_limit_order_input_fee<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg9 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg11 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_order_amount(arg7, arg6, arg8);
        let v1 = &mut arg4;
        let v2 = &mut arg5;
        let v3 = prepare_input_fee_order_execution<T0, T1>(arg2, arg3, v1, v2, v0, arg8, arg14);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg3, &v3, arg12, arg10, arg11, arg6, arg7, arg8, false, arg9, arg13, arg14);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v4, v0, 0, false, arg14);
        v4
    }

    public fun create_limit_order_whitelisted<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg9 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_u64(), 7);
        assert!(arg11 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let v0 = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_order_amount(arg7, arg6, arg8);
        let v1 = &mut arg4;
        let v2 = &mut arg5;
        let v3 = prepare_whitelisted_order_execution<T0, T1>(arg3, v1, v2, v0, arg8, arg14);
        let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg2, arg3, &v3, arg12, arg10, arg11, arg6, arg7, arg8, true, arg9, arg13, arg14);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v4, v0, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::max_deep_fee_discount_rate(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::get_pool_fee_config<T0, T1>(arg1, arg2)), true, arg14);
        v4
    }

    public fun create_market_order<T0, T1, T2, T3>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg7: 0x2::coin::Coin<T0>, arg8: 0x2::coin::Coin<T1>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: bool, arg13: u8, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: u64, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg13 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, v1) = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_market_order_params<T0, T1>(arg2, arg11, arg12, arg19);
        let v2 = &mut arg7;
        let v3 = &mut arg8;
        let (v4, v5) = prepare_order_execution<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v2, v3, arg9, arg10, v1, arg11, arg12, arg15, arg16, arg17, arg18, arg19, arg20);
        let v6 = v4;
        let v7 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg2, arg6, &v6, arg14, arg13, v0, arg12, true, arg19, arg20);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg2, arg6, arg7, arg8, &v7, arg11, v5, true, arg20);
        v7
    }

    public fun create_market_order_input_fee<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: bool, arg8: u8, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg8 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, _) = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_market_order_params<T0, T1>(arg2, arg6, arg7, arg10);
        let v2 = &mut arg4;
        let v3 = &mut arg5;
        let v4 = prepare_input_fee_order_execution<T0, T1>(arg2, arg3, v2, v3, arg6, arg7, arg11);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg2, arg3, &v4, arg9, arg8, v0, arg7, false, arg10, arg11);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v5, arg6, 0, false, arg11);
        v5
    }

    public fun create_market_order_whitelisted<T0, T1>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::coin::Coin<T1>, arg6: u64, arg7: bool, arg8: u8, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg8 == 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), 8);
        let (v0, _) = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_market_order_params<T0, T1>(arg2, arg6, arg7, arg10);
        let v2 = &mut arg4;
        let v3 = &mut arg5;
        let v4 = prepare_whitelisted_order_execution<T0, T1>(arg3, v2, v3, arg6, arg7, arg11);
        let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg2, arg3, &v4, arg9, arg8, v0, arg7, true, arg10, arg11);
        charge_protocol_fees<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, &v5, arg6, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::max_deep_fee_discount_rate(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::get_pool_fee_config<T0, T1>(arg1, arg2)), true, arg11);
        v5
    }

    public(friend) fun create_order_core(arg0: bool, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (DeepPlan, CoverageFeePlan, InputCoinDepositPlan) {
        let v0 = get_deep_plan(arg0, arg1, arg2, arg5, arg8);
        (v0, get_coverage_fee_plan(v0.use_wrapper_deep_reserves, v0.from_deep_reserves, arg0, arg10, arg6, arg3), get_input_coin_deposit_plan(arg9, arg7, arg4))
    }

    fun execute_coverage_fee_plan(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &CoverageFeePlan, arg4: &mut 0x2::tx_context::TxContext) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg3.user_covers_fee, 2);
        if (arg3.from_wallet > 0) {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_deep_reserves_coverage_fee<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg3.from_wallet));
        };
        if (arg3.from_balance_manager > 0) {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_deep_reserves_coverage_fee<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<0x2::sui::SUI>(arg1, arg3.from_balance_manager, arg4)));
        };
    }

    fun execute_deep_plan(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: &DeepPlan, arg4: &mut 0x2::tx_context::TxContext) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        if (arg3.use_wrapper_deep_reserves) {
            assert!(arg3.deep_reserves_cover_order, 1);
        };
        if (arg3.from_user_wallet > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x2::coin::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2, arg3.from_user_wallet, arg4), arg4);
        };
        if (arg3.from_deep_reserves > 0) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::split_deep_reserves(arg0, arg3.from_deep_reserves, arg4), arg4);
        };
    }

    fun execute_input_coin_deposit_plan<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &InputCoinDepositPlan, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3.order_amount > 0) {
            assert!(arg3.user_has_enough_input_coin, 3);
        };
        if (arg3.from_user_wallet > 0) {
            if (arg4) {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T1>(arg0, 0x2::coin::split<T1>(arg2, arg3.from_user_wallet, arg5), arg5);
            } else {
                0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, 0x2::coin::split<T0>(arg1, arg3.from_user_wallet, arg5), arg5);
            };
        };
    }

    fun execute_protocol_fee_plan<T0>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg4: &ProtocolFeePlan, arg5: &mut 0x2::tx_context::TxContext) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(arg4.user_covers_fee, 2);
        if (arg4.taker_fee_from_wallet > 0) {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_protocol_fee<T0>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4.taker_fee_from_wallet));
        };
        if (arg4.taker_fee_from_balance_manager > 0) {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::join_protocol_fee<T0>(arg0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg4.taker_fee_from_balance_manager, arg5)));
        };
        if (arg4.maker_fee_from_wallet > 0) {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::add_unsettled_fee<T0>(arg0, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg4.maker_fee_from_wallet), arg3);
        };
        if (arg4.maker_fee_from_balance_manager > 0) {
            0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::add_unsettled_fee<T0>(arg0, 0x2::coin::into_balance<T0>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg4.maker_fee_from_balance_manager, arg5)), arg3);
        };
    }

    public(friend) fun get_coverage_fee_plan(arg0: bool, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : CoverageFeePlan {
        if (arg2 || !arg0) {
            return zero_coverage_fee_plan()
        };
        let v0 = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::calculate_deep_reserves_coverage_order_fee(arg3, arg1);
        if (v0 == 0) {
            return zero_coverage_fee_plan()
        };
        if (arg4 + arg5 < v0) {
            return insufficient_coverage_fee_plan()
        };
        let (v1, v2) = plan_fee_collection(v0, arg4, arg5);
        CoverageFeePlan{
            from_wallet          : v1,
            from_balance_manager : v2,
            user_covers_fee      : true,
        }
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

    public(friend) fun get_protocol_fee_plan(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : ProtocolFeePlan {
        let (v0, v1) = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_order_taker_maker_ratio(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::original_quantity(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::executed_quantity(arg0), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::status(arg0));
        let (v2, v3, v4) = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::calculate_protocol_fees(v0, v1, arg1, arg2, arg5, arg6);
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
        let v5 = get_input_coin_deposit_plan(arg4 + 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::calculate_input_coin_deepbook_fee(arg4, v2), v1, v0);
        execute_input_coin_deposit_plan<T0, T1>(arg1, arg2, arg3, &v5, arg5, arg6);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg6)
    }

    fun prepare_order_execution<T0, T1, T2, T3>(arg0: &mut 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::Wrapper, arg1: &0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::TradingFeeConfig, arg2: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T2, T3>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg7: &mut 0x2::coin::Coin<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: u64, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) : (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof, u64) {
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::verify_version(arg0);
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg6) == 0x2::tx_context::sender(arg19), 4);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::validate_slippage(arg15);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::validate_slippage(arg17);
        let v0 = 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::get_sui_per_deep<T2, T3>(arg4, arg5, arg3, arg18);
        let v1 = if (arg13) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg6)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg6)
        };
        let v2 = if (arg13) {
            0x2::coin::value<T1>(arg8)
        } else {
            0x2::coin::value<T0>(arg7)
        };
        let (v3, v4, v5) = create_order_core(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg2), arg11, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg6), v1, 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg9), 0x2::coin::value<0x2::sui::SUI>(&arg10), v2, 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::wrapper::deep_reserves(arg0), arg12, v0);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        validate_fees_against_max(arg11, v8.from_deep_reserves, v0, arg14, arg15, arg16, arg17);
        let v9 = &mut arg9;
        execute_deep_plan(arg0, arg6, v9, &v8, arg19);
        let v10 = &mut arg10;
        execute_coverage_fee_plan(arg0, arg6, v10, &v7, arg19);
        execute_input_coin_deposit_plan<T0, T1>(arg6, arg7, arg8, &v6, arg13, arg19);
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::transfer_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg9, 0x2::tx_context::sender(arg19));
        0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::transfer_if_nonzero<0x2::sui::SUI>(arg10, 0x2::tx_context::sender(arg19));
        (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg6, arg19), 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::calculate_discount_rate(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::max_deep_fee_discount_rate(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::get_pool_fee_config<T0, T1>(arg1, arg2)), v8.from_deep_reserves, arg11))
    }

    fun prepare_whitelisted_order_execution<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::owner(arg0) == 0x2::tx_context::sender(arg5), 4);
        let v0 = if (arg4) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T1>(arg0)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(arg0)
        };
        let v1 = if (arg4) {
            0x2::coin::value<T1>(arg2)
        } else {
            0x2::coin::value<T0>(arg1)
        };
        let v2 = get_input_coin_deposit_plan(arg3, v1, v0);
        execute_input_coin_deposit_plan<T0, T1>(arg0, arg1, arg2, &v2, arg4, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg0, arg5)
    }

    public(friend) fun validate_fees_against_max(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg0 <= 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::apply_slippage(arg3, arg4), 5);
        if (arg1 > 0) {
            assert!(0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::fee::calculate_deep_reserves_coverage_order_fee(arg2, arg1) <= 0x64364235f8faad5c76eeb45fdac0ec8f70e9de59f1d44aef548424b53ebc607b::helper::apply_slippage(arg5, arg6), 6);
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

