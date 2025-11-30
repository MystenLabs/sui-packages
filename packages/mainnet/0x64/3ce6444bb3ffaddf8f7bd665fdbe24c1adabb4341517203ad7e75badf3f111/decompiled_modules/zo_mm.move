module 0x643ce6444bb3ffaddf8f7bd665fdbe24c1adabb4341517203ad7e75badf3f111::zo_mm {
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

    struct TradeExecuted has copy, drop {
        direction: u8,
        quantity: u64,
        db_price: u64,
        zo_price: u64,
        profit: u64,
        timestamp: u64,
    }

    public fun a8b2c4(arg0: &Config) : (u64, u64, bool) {
        (arg0.order_size, arg0.profit_threshold_bps, arg0.enabled)
    }

    public fun b8c3d6<T0, T1, T2, T3>(arg0: &Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG>, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT>, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u256, arg16: u256, arg17: 0x2::coin::Coin<T2>, arg18: 0x2::coin::Coin<T2>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(arg11 > 0, 7);
        assert!(arg13 > 0, 7);
        if (arg10 == 0) {
            xq4m9v2_0x7f<T1, T2>(arg1, arg2, arg11, arg12, arg19, arg20);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T2, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT, T2>(arg19, arg3, arg4, arg5, arg7, arg8, arg9, arg17, arg18, 2, arg13, arg14, arg15, arg16, arg20);
        } else {
            assert!(arg10 == 1, 3);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T2, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG, T2>(arg19, arg3, arg4, arg5, arg6, arg8, arg9, arg17, arg18, 2, arg13, arg14, arg15, arg16, arg20);
            yr5n1w3_0x8e<T1, T2>(arg1, arg2, arg11, arg12, arg19, arg20);
        };
        let v0 = TradeExecuted{
            direction : arg10,
            quantity  : arg11,
            db_price  : arg12,
            zo_price  : 0,
            profit    : 0,
            timestamp : 0x2::clock::timestamp_ms(arg19),
        };
        0x2::event::emit<TradeExecuted>(v0);
    }

    public fun e9f4g7<T0, T1, T2, T3, T4>(arg0: &Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::PositionCap<T2, T3, T4>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: bool, arg10: u64, arg11: u64, arg12: u64, arg13: u256, arg14: u256, arg15: 0x2::coin::Coin<T2>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(arg10 > 0, 7);
        assert!(arg12 > 0, 7);
        if (arg9) {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::decrease_position<T0, T2, T3, T4, T2>(arg16, arg3, arg4, arg5, arg6, arg7, arg8, arg15, 2, true, arg12, arg13, arg14, arg17);
            yr5n1w3_0x8e<T1, T2>(arg1, arg2, arg10, arg11, arg16, arg17);
        } else {
            xq4m9v2_0x7f<T1, T2>(arg1, arg2, arg10, arg11, arg16, arg17);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::decrease_position<T0, T2, T3, T4, T2>(arg16, arg3, arg4, arg5, arg6, arg7, arg8, arg15, 2, true, arg12, arg13, arg14, arg17);
        };
        let v0 = if (arg9) {
            0
        } else {
            1
        };
        let v1 = TradeExecuted{
            direction : v0,
            quantity  : arg10,
            db_price  : arg11,
            zo_price  : 0,
            profit    : 0,
            timestamp : 0x2::clock::timestamp_ms(arg16),
        };
        0x2::event::emit<TradeExecuted>(v1);
    }

    fun h2j5k7<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg2, true, false, arg3, arg4);
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

    fun l3m6n8<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg2, false, false, arg3, arg4);
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

    public fun r5s8t1(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.order_size = arg1;
    }

    public fun s5t9u3<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, arg1, arg2);
    }

    public fun u6v9w2(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.profit_threshold_bps = arg1;
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

