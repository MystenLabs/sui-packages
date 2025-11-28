module 0x3ecb3d53c6ee106ae7b38ea21e95c707160b39fe66c1c46f8c64ffa8a995263d::zo_mm {
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

    public fun set_enabled(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.enabled = arg1;
    }

    public fun update_order_size(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.order_size = arg1;
    }

    public fun update_profit_threshold(arg0: &mut Config, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.profit_threshold_bps = arg1;
    }

    // decompiled from Move bytecode v6
}

