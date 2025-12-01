module 0x86fe97119dc056ad872093bbc1c565be4ab8977d0377883ae498af6f6c7f36c7::zo_mm {
    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
        order_size: u64,
        profit_threshold_bps: u64,
        enabled: bool,
    }

    struct DeepBookQuote has copy, drop, store {
        bid_price: u64,
        bid_quantity: u64,
        ask_price: u64,
        ask_quantity: u64,
        timestamp: u64,
    }

    struct ZOQuote has copy, drop, store {
        price: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64,
        confidence: u64,
        timestamp: u64,
        expo: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64,
    }

    struct ArbitrageOpportunity has copy, drop {
        direction: u8,
        profit_bps: u64,
        db_price: u64,
        zo_price: u64,
        quantity: u64,
        timestamp: u64,
    }

    struct TradeProposal has copy, drop {
        direction: u8,
        quantity: u64,
        db_price: u64,
        zo_price: u64,
        profit: u64,
        timestamp: u64,
    }

    struct ProfitabilityChecked has copy, drop {
        direction: u8,
        db_price: u64,
        zo_price: u64,
        gross_profit_e6: u64,
        total_fees_e6: u64,
        net_profit_e6: u64,
        threshold_e6: u64,
        passed: bool,
    }

    struct TradeResult has copy, drop, store {
        direction: u8,
        db_base_amount: u64,
        db_quote_amount: u64,
        db_execution_price: u64,
        zo_oracle_price: u64,
        zo_amount: u64,
        profit_e6: u64,
        is_profit_positive: bool,
        timestamp: u64,
    }

    public fun a8b2c4(arg0: &Config) : (u64, u64, bool) {
        (arg0.order_size, arg0.profit_threshold_bps, arg0.enabled)
    }

    public fun b8c3d6<T0, T1, T2, T3>(arg0: &Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG>, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT>, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u256, arg16: u256, arg17: 0x2::coin::Coin<T2>, arg18: 0x2::coin::Coin<T2>, arg19: bool, arg20: u64, arg21: u64, arg22: u64, arg23: u64, arg24: &0x2::clock::Clock, arg25: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(arg11 > 0, 7);
        assert!(arg13 > 0, 7);
        if (arg19) {
            q4r8s2(arg12, arg20, arg10, arg21, arg22, arg23);
        };
        let v0 = 0x2::tx_context::sender(arg25);
        if (arg10 == 0) {
            xq4m9v2_0x7f<T1, T2>(arg1, arg2, arg11, arg12, arg24, arg25);
            let v1 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg25);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg1, arg2, &v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg2, arg25), v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T2>(arg2, arg25), v0);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T2, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT, T2>(arg24, arg3, arg4, arg5, arg7, arg8, arg9, arg17, arg18, 2, arg13, arg14, arg15, arg16, arg25);
        } else {
            assert!(arg10 == 1, 3);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T2, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG, T2>(arg24, arg3, arg4, arg5, arg6, arg8, arg9, arg17, arg18, 2, arg13, arg14, arg15, arg16, arg25);
            yr5n1w3_0x8e<T1, T2>(arg1, arg2, arg11, arg12, arg24, arg25);
            let v2 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg2, arg25);
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T1, T2>(arg1, arg2, &v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T2>(arg2, arg25), v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg2, arg25), v0);
        };
        let v3 = TradeProposal{
            direction : arg10,
            quantity  : arg11,
            db_price  : arg12,
            zo_price  : 0,
            profit    : 0,
            timestamp : 0x2::clock::timestamp_ms(arg24),
        };
        0x2::event::emit<TradeProposal>(v3);
    }

    public fun c7d2e8<T0, T1, T2, T3>(arg0: &Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG>, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT>, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: u64, arg13: u256, arg14: 0x2::coin::Coin<T2>, arg15: 0x2::coin::Coin<T2>, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: &0x2::clock::Clock, arg21: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(arg11 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg21);
        let v1 = get_pyth_price_e6(arg9, arg20);
        let (v2, v3) = if (arg10 == 0) {
            let v4 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T2>(arg2, arg21);
            let (v5, v6) = h2j5k7<T1, T2>(arg1, v4, 0, arg20, arg21);
            let v7 = v6;
            let v8 = v5;
            let v9 = 0x2::coin::value<T1>(&v8);
            let v10 = if (v9 > 0) {
                ((((0x2::coin::value<T2>(&v4) - 0x2::coin::value<T2>(&v7)) as u128) * 1000000000 / (v9 as u128)) as u64)
            } else {
                0
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v8, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v7, v0);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T2, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT, T2>(arg20, arg3, arg4, arg5, arg7, arg8, arg9, arg14, arg15, 2, arg11, arg12, arg13, 0, arg21);
            (v9, v10)
        } else {
            assert!(arg10 == 1, 3);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T2, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG, T2>(arg20, arg3, arg4, arg5, arg6, arg8, arg9, arg14, arg15, 2, arg11, arg12, arg13, 115792089237316195423570985008687907853269984665640564039457584007913129639935, arg21);
            let v11 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg2, arg21);
            let (v12, v13) = l3m6n8<T1, T2>(arg1, v11, 0, arg20, arg21);
            let v14 = v13;
            let v15 = v12;
            let v16 = 0x2::coin::value<T1>(&v11) - 0x2::coin::value<T1>(&v15);
            let v17 = if (v16 > 0) {
                (((0x2::coin::value<T2>(&v14) as u128) * 1000000000 / (v16 as u128)) as u64)
            } else {
                0
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v14, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v15, v0);
            (v16, v17)
        };
        let (v18, _) = calculate_profit_from_prices(v3, v1, arg10, arg18, arg19);
        let v20 = TradeProposal{
            direction : arg10,
            quantity  : v2,
            db_price  : v3,
            zo_price  : v1,
            profit    : v18,
            timestamp : 0x2::clock::timestamp_ms(arg20),
        };
        0x2::event::emit<TradeProposal>(v20);
        if (arg16) {
            q4r8s2(v3, v1, arg10, arg18, arg19, arg17);
        };
    }

    fun calculate_profit_from_prices(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64) : (u64, bool) {
        let v0 = arg3 + arg4;
        let (v1, v2) = if (arg2 == 0) {
            if (arg1 > arg0 && arg0 > 0) {
                (((((arg1 - arg0) as u128) * (1000000 as u128) / (arg0 as u128)) as u64), true)
            } else if (arg0 > arg1 && arg0 > 0) {
                (((((arg0 - arg1) as u128) * (1000000 as u128) / (arg0 as u128)) as u64), false)
            } else {
                (0, false)
            }
        } else if (arg0 > arg1 && arg1 > 0) {
            (((((arg0 - arg1) as u128) * (1000000 as u128) / (arg1 as u128)) as u64), true)
        } else if (arg1 > arg0 && arg1 > 0) {
            (((((arg1 - arg0) as u128) * (1000000 as u128) / (arg1 as u128)) as u64), false)
        } else {
            (0, false)
        };
        if (v2 && v1 > v0) {
            (v1 - v0, true)
        } else if (v2) {
            (v0 - v1, false)
        } else {
            (v1 + v0, false)
        }
    }

    public fun e9f4g7<T0, T1, T2, T3, T4>(arg0: &Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::PositionCap<T2, T3, T4>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: 0x2::coin::Coin<T2>, arg14: bool, arg15: u64, arg16: u64, arg17: u64, arg18: &0x2::clock::Clock, arg19: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(arg10 > 0, 7);
        let v0 = 0x2::tx_context::sender(arg19);
        let v1 = get_pyth_price_e6(arg8, arg18);
        let (v2, v3, v4) = if (arg9) {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::decrease_position<T0, T2, T3, T4, T2>(arg18, arg3, arg4, arg5, arg6, arg7, arg8, arg13, 2, true, arg10, arg11, arg12, arg19);
            let v5 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T1>(arg2, arg19);
            let (v6, v7) = l3m6n8<T1, T2>(arg1, v5, 0, arg18, arg19);
            let v8 = v7;
            let v9 = v6;
            let v10 = 0x2::coin::value<T1>(&v5) - 0x2::coin::value<T1>(&v9);
            let v11 = if (v10 > 0) {
                (((0x2::coin::value<T2>(&v8) as u128) * 1000000000 / (v10 as u128)) as u64)
            } else {
                0
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v8, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v9, v0);
            (v10, v11, 1)
        } else {
            let v12 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T2>(arg2, arg19);
            let (v13, v14) = h2j5k7<T1, T2>(arg1, v12, 0, arg18, arg19);
            let v15 = v14;
            let v16 = v13;
            let v17 = 0x2::coin::value<T1>(&v16);
            let v18 = if (v17 > 0) {
                ((((0x2::coin::value<T2>(&v12) - 0x2::coin::value<T2>(&v15)) as u128) * 1000000000 / (v17 as u128)) as u64)
            } else {
                0
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v16, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v15, v0);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::decrease_position<T0, T2, T3, T4, T2>(arg18, arg3, arg4, arg5, arg6, arg7, arg8, arg13, 2, true, arg10, arg11, arg12, arg19);
            (v17, v18, 0)
        };
        let (v19, _) = calculate_profit_from_prices(v3, v1, v4, arg16, arg17);
        let v21 = TradeProposal{
            direction : v4,
            quantity  : v2,
            db_price  : v3,
            zo_price  : v1,
            profit    : v19,
            timestamp : 0x2::clock::timestamp_ms(arg18),
        };
        0x2::event::emit<TradeProposal>(v21);
        if (arg14) {
            q4r8s2(v3, v1, v4, arg16, arg17, arg15);
        };
    }

    fun get_pyth_price_e6(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        assert!(0x2::clock::timestamp_ms(arg1) - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1) * 1000 <= 10000, 4);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3);
        if (v4 <= 6) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) * pow10(6 - v4)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v2) / pow10(v4 - 6)
        }
    }

    fun h2j5k7<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        (v0, v1)
    }

    public fun k3m7n9(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Config {
        Config{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            order_size           : arg0,
            profit_threshold_bps : arg1,
            enabled              : true,
        }
    }

    fun l3m6n8<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg1, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg4), arg2, arg3, arg4);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v2);
        (v0, v1)
    }

    public fun m3n7p1(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64) : (u64, u64, u64, bool) {
        let v0 = arg3 + arg4;
        let (v1, v2) = if (arg2 == 0) {
            if (arg1 > arg0) {
                (((((arg1 - arg0) as u128) * (1000000 as u128) / (arg0 as u128)) as u64), true)
            } else if (arg0 > arg1) {
                (((((arg0 - arg1) as u128) * (1000000 as u128) / (arg0 as u128)) as u64), false)
            } else {
                (0, false)
            }
        } else if (arg0 > arg1) {
            (((((arg0 - arg1) as u128) * (1000000 as u128) / (arg1 as u128)) as u64), true)
        } else if (arg1 > arg0) {
            (((((arg1 - arg0) as u128) * (1000000 as u128) / (arg1 as u128)) as u64), false)
        } else {
            (0, false)
        };
        let (v3, v4) = if (v2 && v1 > v0) {
            (true, v1 - v0)
        } else {
            (false, 0)
        };
        (v1, v0, v4, v3)
    }

    public fun n4p7q9(arg0: u256, arg1: bool, arg2: u64) : u256 {
        let v0 = if (arg1) {
            10000 + arg2
        } else {
            10000 - arg2
        };
        arg0 * (v0 as u256) / 10000
    }

    public fun p4q8r2(arg0: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0)
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun q4r8s2(arg0: u64, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        let (v0, v1, v2, v3) = m3n7p1(arg0, arg1, arg2, arg3, arg4);
        let v4 = v3 && v2 >= arg5;
        let v5 = ProfitabilityChecked{
            direction       : arg2,
            db_price        : arg0,
            zo_price        : arg1,
            gross_profit_e6 : v0,
            total_fees_e6   : v1,
            net_profit_e6   : v2,
            threshold_e6    : arg5,
            passed          : v4,
        };
        0x2::event::emit<ProfitabilityChecked>(v5);
        assert!(v4, 2);
    }

    public fun r5s8t1(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.order_size = arg1;
    }

    public fun s5t9u3<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, arg1, arg2);
    }

    public fun t6u2v4<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg1, &v0);
    }

    public fun u6v9w2(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.profit_threshold_bps = arg1;
    }

    public fun u7v3w5<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(arg0, arg1)
    }

    public fun v6w1x4<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock) : DeepBookQuote {
        let (v0, v1) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), true, arg3);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_range<T0, T1>(arg0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), false, arg3);
        let v6 = v5;
        let v7 = v4;
        let (v8, v9) = if (0x1::vector::length<u64>(&v3) > 0) {
            let v10 = 0x1::vector::length<u64>(&v3) - 1;
            (*0x1::vector::borrow<u64>(&v3, v10), *0x1::vector::borrow<u64>(&v2, v10))
        } else {
            (0, 0)
        };
        let (v11, v12) = if (0x1::vector::length<u64>(&v7) > 0) {
            (*0x1::vector::borrow<u64>(&v7, 0), *0x1::vector::borrow<u64>(&v6, 0))
        } else {
            (0, 0)
        };
        DeepBookQuote{
            bid_price    : v8,
            bid_quantity : v9,
            ask_price    : v11,
            ask_quantity : v12,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        }
    }

    public fun w8x4y6<T0, T1, T2>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg2);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::withdraw_settled_amounts<T0, T1>(arg0, arg1, &v0);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T2>(arg1, arg2)
    }

    public fun x7a9b3(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::admin_create_points(arg0, arg1, arg2, arg3);
    }

    public fun x7y1z3(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.enabled = arg1;
    }

    public fun x8c2d4(arg0: &0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::create_lootbox_treasury(arg0, arg1);
    }

    public fun x9e5f6(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPriceConfig, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::from_price(arg0, arg1)
    }

    fun xq4m9v2_0x7f<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, arg2, true, false, 0x2::clock::timestamp_ms(arg4) + 60000, arg4, arg5);
    }

    public fun y7z2a5(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : ZOQuote {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0));
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v1);
        assert!(0x2::clock::timestamp_ms(arg1) - v2 * 1000 <= 10000, 4);
        ZOQuote{
            price      : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v1),
            confidence : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v1),
            timestamp  : v2,
            expo       : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v1),
        }
    }

    fun yr5n1w3_0x8e<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg5);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_limit_order<T0, T1>(arg0, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::immediate_or_cancel(), 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg3, arg2, false, false, 0x2::clock::timestamp_ms(arg4) + 60000, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

