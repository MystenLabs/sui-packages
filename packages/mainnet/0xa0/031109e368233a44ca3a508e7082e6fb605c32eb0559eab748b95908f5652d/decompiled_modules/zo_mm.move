module 0xa0031109e368233a44ca3a508e7082e6fb605c32eb0559eab748b95908f5652d::zo_mm {
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

    struct X7k2m9 has copy, drop, store {
        k7x: u64,
        m3y: u64,
        p5z: u64,
        r2w: u64,
        v8q: u64,
        h4j: bool,
        n9s: u64,
    }

    struct Y3p6r1 has copy, drop {
        d2f: u8,
        k7x: u64,
        m3y: u64,
        p5z: u64,
        r2w: u64,
        v8q: u64,
        h4j: bool,
        n9s: u64,
    }

    fun calculate_arbitrage(arg0: &DeepBookQuote, arg1: &ZOQuote, arg2: &Config) : (bool, u8, u64) {
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&arg1.price), 5);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&arg1.price);
        let v1 = arg1.expo;
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
        };
        let v2 = if (arg0.ask_price > v0) {
            arg0.ask_price - v0
        } else {
            v0 - arg0.ask_price
        };
        assert!(v2 * 10000 / (arg0.ask_price + v0) / 2 <= 500, 5);
        let v3 = if (v0 > arg0.ask_price) {
            (v0 - arg0.ask_price) * 10000 / arg0.ask_price
        } else {
            0
        };
        let v4 = if (arg0.bid_price > v0) {
            (arg0.bid_price - v0) * 10000 / v0
        } else {
            0
        };
        if (v3 >= arg2.profit_threshold_bps && v3 >= v4) {
            if (arg0.ask_quantity >= arg2.order_size) {
                return (true, 0, v3)
            };
        } else if (v4 >= arg2.profit_threshold_bps) {
            if (arg0.bid_quantity >= arg2.order_size) {
                return (true, 1, v4)
            };
        };
        (false, 0, 0)
    }

    public fun calculate_slippage_price(arg0: u256, arg1: bool, arg2: u64) : u256 {
        let v0 = if (arg1) {
            10000 + arg2
        } else {
            10000 - arg2
        };
        arg0 * (v0 as u256) / 10000
    }

    public fun create_config(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Config {
        Config{
            id                   : 0x2::object::new(arg2),
            owner                : 0x2::tx_context::sender(arg2),
            order_size           : arg0,
            profit_threshold_bps : arg1,
            enabled              : true,
        }
    }

    public fun create_db_balance_manager(arg0: &mut 0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0)
    }

    public fun deposit_to_db_bm<T0>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg0, arg1, arg2);
    }

    fun execute_buy_on_deepbook<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg2, true, false, arg3, arg4);
    }

    fun execute_sell_on_deepbook<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(arg1, arg4);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg0, arg1, &v0, 0, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::self_matching_allowed(), arg2, false, false, arg3, arg4);
    }

    public fun get_config(arg0: &Config) : (u64, u64, bool) {
        (arg0.order_size, arg0.profit_threshold_bps, arg0.enabled)
    }

    public fun get_quotes_from_db<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &0x2::clock::Clock) : DeepBookQuote {
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

    public fun get_quotes_from_zo(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : ZOQuote {
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

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun q4r8s2<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : X7k2m9 {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (v1, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg2, arg4);
        let v4 = get_quotes_from_zo(arg1, arg4);
        let v5 = v4.expo;
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5);
        let v7 = if (v6) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5)
        };
        let v8 = if (v6 && v7 > 0) {
            (((v1 as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4.price) as u128) / (pow10(v7) as u128)) as u64)
        } else {
            (((v1 as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4.price) as u128)) as u64)
        };
        let v9 = v8 / 1000;
        let v10 = v9 * arg3 / 10000;
        let v11 = if (v9 > v10) {
            v9 - v10
        } else {
            0
        };
        let (v12, v13) = if (v11 > arg2) {
            (v11 - arg2, true)
        } else {
            (arg2 - v11, false)
        };
        let v14 = Y3p6r1{
            d2f : 0,
            k7x : v1,
            m3y : arg2,
            p5z : v9,
            r2w : v3,
            v8q : v12,
            h4j : v13,
            n9s : v0,
        };
        0x2::event::emit<Y3p6r1>(v14);
        X7k2m9{
            k7x : v1,
            m3y : arg2,
            p5z : v9,
            r2w : v3,
            v8q : v12,
            h4j : v13,
            n9s : v0,
        }
    }

    public fun set_enabled(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.enabled = arg1;
    }

    public fun t5u9v3<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : X7k2m9 {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let (_, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, arg2, arg4);
        let v4 = get_quotes_from_zo(arg1, arg4);
        let v5 = v4.expo;
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5);
        let v7 = if (v6) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5)
        };
        let v8 = if (v6 && v7 > 0) {
            (((arg2 as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4.price) as u128) / (pow10(v7) as u128)) as u64)
        } else {
            (((arg2 as u128) * (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4.price) as u128)) as u64)
        };
        let v9 = v8 / 1000;
        let v10 = v9 + v9 * arg3 / 10000;
        let (v11, v12) = if (v2 > v10) {
            (v2 - v10, true)
        } else {
            (v10 - v2, false)
        };
        let v13 = Y3p6r1{
            d2f : 1,
            k7x : arg2,
            m3y : v2,
            p5z : v9,
            r2w : v3,
            v8q : v11,
            h4j : v12,
            n9s : v0,
        };
        0x2::event::emit<Y3p6r1>(v13);
        X7k2m9{
            k7x : arg2,
            m3y : v2,
            p5z : v9,
            r2w : v3,
            v8q : v11,
            h4j : v12,
            n9s : v0,
        }
    }

    public fun test_lootbox(arg0: &0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0xd2e44dc1311833ddb0427f2141e2935720cf5454cf0ef39141fc80c19e1e6caa::lootbox::create_lootbox_treasury(arg0, arg1);
    }

    public fun test_sudo_nft(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::admin_create_points(arg0, arg1, arg2, arg3);
    }

    public fun test_zo_core(arg0: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPriceConfig, arg1: 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::decimal::Decimal) : 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::AggPrice {
        0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::agg_price::from_price(arg0, arg1)
    }

    public fun trade_paired<T0, T1, T2, T3>(arg0: &Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG>, arg7: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::WrappedPositionConfig<T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT>, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg10: u8, arg11: u64, arg12: u64, arg13: u256, arg14: u256, arg15: 0x2::coin::Coin<T1>, arg16: 0x2::coin::Coin<T1>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(arg11 > 0, 7);
        if (arg10 == 0) {
            execute_buy_on_deepbook<T1, T2>(arg1, arg2, arg11, arg17, arg18);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T1, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::SHORT, T1>(arg17, arg3, arg4, arg5, arg7, arg8, arg9, arg15, arg16, 2, arg11, arg12, arg13, arg14, arg18);
        } else {
            assert!(arg10 == 1, 3);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::open_position<T0, T1, T3, 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::LONG, T1>(arg17, arg3, arg4, arg5, arg6, arg8, arg9, arg15, arg16, 2, arg11, arg12, arg13, arg14, arg18);
            execute_sell_on_deepbook<T1, T2>(arg1, arg2, arg11, arg17, arg18);
        };
        let v0 = TradeExecuted{
            direction : arg10,
            quantity  : arg11,
            db_price  : 0,
            zo_price  : 0,
            profit    : 0,
            timestamp : 0x2::clock::timestamp_ms(arg17),
        };
        0x2::event::emit<TradeExecuted>(v0);
    }

    public fun trade_paired_close_position<T0, T1, T2, T3, T4>(arg0: &Config, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &mut 0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::Market<T0>, arg4: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::PositionCap<T1, T3, T4>, arg5: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::ReservingFeeModel, arg6: &0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::model::FundingFeeModel, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: bool, arg10: u64, arg11: u256, arg12: u256, arg13: 0x2::coin::Coin<T1>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 3);
        assert!(arg10 > 0, 7);
        if (arg9) {
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::decrease_position<T0, T1, T3, T4, T1>(arg14, arg3, arg4, arg5, arg6, arg7, arg8, arg13, 2, true, arg10, arg11, arg12, arg15);
            execute_buy_on_deepbook<T1, T2>(arg1, arg2, arg10, arg14, arg15);
        } else {
            execute_sell_on_deepbook<T1, T2>(arg1, arg2, arg10, arg14, arg15);
            0xf7fade57462e56e2eff1d7adef32e4fd285b21fd81f983f407bb7110ca766cda::market::decrease_position<T0, T1, T3, T4, T1>(arg14, arg3, arg4, arg5, arg6, arg7, arg8, arg13, 2, true, arg10, arg11, arg12, arg15);
        };
        let v0 = if (arg9) {
            0
        } else {
            1
        };
        let v1 = TradeExecuted{
            direction : v0,
            quantity  : arg10,
            db_price  : 0,
            zo_price  : 0,
            profit    : 0,
            timestamp : 0x2::clock::timestamp_ms(arg14),
        };
        0x2::event::emit<TradeExecuted>(v1);
    }

    public fun update_order_size(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.order_size = arg1;
    }

    public fun update_profit_threshold(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.profit_threshold_bps = arg1;
    }

    public fun w6x0y4<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : (X7k2m9, X7k2m9) {
        (q4r8s2<T0, T1>(arg0, arg1, arg2, arg4, arg5), t5u9v3<T0, T1>(arg0, arg1, arg3, arg4, arg5))
    }

    // decompiled from Move bytecode v6
}

