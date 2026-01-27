module 0x316eb6a84c48708e69b80f75a88633fcde49a85c6cf7dc017c2ebde3ad2e989e::config {
    struct MMConfig has copy, drop, store {
        min_order_size: u64,
        max_order_size: u64,
        max_base_position: u64,
        max_quote_position: u64,
        min_price: u64,
        max_price: u64,
        order_cooldown_ms: u64,
        default_spread_bps: u64,
        target_base_position: u64,
        max_skew_bps: u64,
        min_hedge_profit_bps: u64,
        max_hedge_pct: u64,
        min_hedge_amount: u64,
        significant_qty_multiplier: u64,
        l2_tick_count: u64,
        price_offset_ticks: u64,
        is_arbitrage_enabled: bool,
        arb_cooldown_ms: u64,
        min_arb_profit_bps: u64,
        max_arb_amount: u64,
        arb_slippage_bps: u64,
        enable_deep_payment: bool,
        enable_deep_refill: bool,
        deep_buffer_multiplier: u64,
        min_deep_purchase: u64,
        is_dry_run: bool,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public fun arb_cooldown_ms(arg0: &MMConfig) : u64 {
        arg0.arb_cooldown_ms
    }

    public fun arb_slippage_bps(arg0: &MMConfig) : u64 {
        arg0.arb_slippage_bps
    }

    public fun assert_valid(arg0: &MMConfig) {
        assert!(arg0.max_order_size >= arg0.min_order_size, 1);
        assert!(arg0.max_base_position >= arg0.max_order_size, 2);
        assert!(arg0.max_quote_position > 0, 2);
        assert!(arg0.min_price > 0, 3);
        assert!(arg0.max_price > arg0.min_price, 3);
        assert!(arg0.default_spread_bps <= 10000, 4);
        assert!(arg0.max_skew_bps <= 500, 5);
    }

    public fun deep_buffer_multiplier(arg0: &MMConfig) : u64 {
        arg0.deep_buffer_multiplier
    }

    public fun default() : MMConfig {
        MMConfig{
            min_order_size             : 0,
            max_order_size             : 18446744073709551615,
            max_base_position          : 18446744073709551615,
            max_quote_position         : 18446744073709551615,
            min_price                  : 0,
            max_price                  : 18446744073709551615,
            order_cooldown_ms          : 0,
            default_spread_bps         : 6,
            target_base_position       : 3000000000,
            max_skew_bps               : 3,
            min_hedge_profit_bps       : 3,
            max_hedge_pct              : 5000,
            min_hedge_amount           : 0,
            significant_qty_multiplier : 10,
            l2_tick_count              : 8,
            price_offset_ticks         : 1,
            is_arbitrage_enabled       : false,
            arb_cooldown_ms            : 0,
            min_arb_profit_bps         : 3,
            max_arb_amount             : 100000000000,
            arb_slippage_bps           : 50,
            enable_deep_payment        : false,
            enable_deep_refill         : false,
            deep_buffer_multiplier     : 15,
            min_deep_purchase          : 10000000,
            is_dry_run                 : false,
            extra_fields               : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    public fun default_spread_bps(arg0: &MMConfig) : u64 {
        arg0.default_spread_bps
    }

    public fun effective_spread_bps(arg0: &MMConfig, arg1: u64) : u64 {
        if (arg1 == 0) {
            arg0.default_spread_bps
        } else {
            arg1
        }
    }

    public fun enable_deep_payment(arg0: &MMConfig) : bool {
        arg0.enable_deep_payment
    }

    public fun enable_deep_refill(arg0: &MMConfig) : bool {
        arg0.enable_deep_refill
    }

    public fun is_arbitrage_enabled(arg0: &MMConfig) : bool {
        arg0.is_arbitrage_enabled
    }

    public fun is_dry_run(arg0: &MMConfig) : bool {
        arg0.is_dry_run
    }

    public fun is_hedge_enabled(arg0: &MMConfig) : bool {
        arg0.min_hedge_profit_bps > 0 && arg0.min_hedge_amount > 0
    }

    public fun is_orderbook_analysis_enabled(arg0: &MMConfig) : bool {
        arg0.l2_tick_count > 0 && arg0.significant_qty_multiplier > 0
    }

    public fun is_skew_enabled(arg0: &MMConfig) : bool {
        arg0.target_base_position > 0 && arg0.max_skew_bps > 0
    }

    public fun is_valid(arg0: &MMConfig) : bool {
        if (arg0.max_order_size >= arg0.min_order_size) {
            if (arg0.max_base_position >= arg0.max_order_size) {
                if (arg0.max_quote_position > 0) {
                    if (arg0.min_price > 0) {
                        if (arg0.max_price > arg0.min_price) {
                            if (arg0.default_spread_bps <= 10000) {
                                arg0.max_skew_bps <= 500
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun l2_tick_count(arg0: &MMConfig) : u64 {
        arg0.l2_tick_count
    }

    public fun max_arb_amount(arg0: &MMConfig) : u64 {
        arg0.max_arb_amount
    }

    public fun max_base_position(arg0: &MMConfig) : u64 {
        arg0.max_base_position
    }

    public fun max_hedge_pct(arg0: &MMConfig) : u64 {
        arg0.max_hedge_pct
    }

    public fun max_order_size(arg0: &MMConfig) : u64 {
        arg0.max_order_size
    }

    public fun max_price(arg0: &MMConfig) : u64 {
        arg0.max_price
    }

    public fun max_quote_position(arg0: &MMConfig) : u64 {
        arg0.max_quote_position
    }

    public fun max_skew_bps(arg0: &MMConfig) : u64 {
        arg0.max_skew_bps
    }

    public fun min_arb_profit_bps(arg0: &MMConfig) : u64 {
        arg0.min_arb_profit_bps
    }

    public fun min_deep_purchase(arg0: &MMConfig) : u64 {
        arg0.min_deep_purchase
    }

    public fun min_hedge_amount(arg0: &MMConfig) : u64 {
        arg0.min_hedge_amount
    }

    public fun min_hedge_profit_bps(arg0: &MMConfig) : u64 {
        arg0.min_hedge_profit_bps
    }

    public fun min_order_size(arg0: &MMConfig) : u64 {
        arg0.min_order_size
    }

    public fun min_price(arg0: &MMConfig) : u64 {
        arg0.min_price
    }

    public fun min_significant_qty(arg0: &MMConfig) : u64 {
        let v0 = 18446744073709551615;
        if (arg0.max_order_size > v0 / arg0.significant_qty_multiplier) {
            v0
        } else {
            arg0.significant_qty_multiplier * arg0.max_order_size
        }
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: bool, arg17: u64, arg18: u64, arg19: u64, arg20: u64, arg21: bool, arg22: bool, arg23: u64, arg24: u64, arg25: bool) : MMConfig {
        let v0 = MMConfig{
            min_order_size             : arg0,
            max_order_size             : arg1,
            max_base_position          : arg2,
            max_quote_position         : arg3,
            min_price                  : arg4,
            max_price                  : arg5,
            order_cooldown_ms          : arg6,
            default_spread_bps         : arg7,
            target_base_position       : arg8,
            max_skew_bps               : arg9,
            min_hedge_profit_bps       : arg10,
            max_hedge_pct              : arg11,
            min_hedge_amount           : arg12,
            significant_qty_multiplier : arg13,
            l2_tick_count              : arg14,
            price_offset_ticks         : arg15,
            is_arbitrage_enabled       : arg16,
            arb_cooldown_ms            : arg17,
            min_arb_profit_bps         : arg18,
            max_arb_amount             : arg19,
            arb_slippage_bps           : arg20,
            enable_deep_payment        : arg21,
            enable_deep_refill         : arg22,
            deep_buffer_multiplier     : arg23,
            min_deep_purchase          : arg24,
            is_dry_run                 : arg25,
            extra_fields               : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        assert_valid(&v0);
        v0
    }

    public fun order_cooldown_ms(arg0: &MMConfig) : u64 {
        arg0.order_cooldown_ms
    }

    public fun price_offset_ticks(arg0: &MMConfig) : u64 {
        arg0.price_offset_ticks
    }

    public fun significant_qty_multiplier(arg0: &MMConfig) : u64 {
        arg0.significant_qty_multiplier
    }

    public fun target_base_position(arg0: &MMConfig) : u64 {
        arg0.target_base_position
    }

    public fun with_arb_cooldown_ms(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.arb_cooldown_ms = arg1;
        arg0
    }

    public fun with_arb_slippage_bps(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.arb_slippage_bps = arg1;
        arg0
    }

    public fun with_arbitrage_enabled(arg0: MMConfig, arg1: bool) : MMConfig {
        arg0.is_arbitrage_enabled = arg1;
        arg0
    }

    public fun with_deep_buffer_multiplier(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.deep_buffer_multiplier = arg1;
        arg0
    }

    public fun with_default_spread_bps(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.default_spread_bps = arg1;
        assert_valid(&arg0);
        arg0
    }

    public fun with_dry_run(arg0: MMConfig, arg1: bool) : MMConfig {
        arg0.is_dry_run = arg1;
        arg0
    }

    public fun with_enable_deep_payment(arg0: MMConfig, arg1: bool) : MMConfig {
        arg0.enable_deep_payment = arg1;
        arg0
    }

    public fun with_enable_deep_refill(arg0: MMConfig, arg1: bool) : MMConfig {
        arg0.enable_deep_refill = arg1;
        arg0
    }

    public fun with_l2_tick_count(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.l2_tick_count = arg1;
        arg0
    }

    public fun with_max_arb_amount(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.max_arb_amount = arg1;
        arg0
    }

    public fun with_max_base_position(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.max_base_position = arg1;
        assert_valid(&arg0);
        arg0
    }

    public fun with_max_hedge_pct(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.max_hedge_pct = arg1;
        arg0
    }

    public fun with_max_order_size(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.max_order_size = arg1;
        assert_valid(&arg0);
        arg0
    }

    public fun with_max_skew_bps(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.max_skew_bps = arg1;
        assert_valid(&arg0);
        arg0
    }

    public fun with_min_arb_profit_bps(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.min_arb_profit_bps = arg1;
        arg0
    }

    public fun with_min_deep_purchase(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.min_deep_purchase = arg1;
        arg0
    }

    public fun with_min_hedge_amount(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.min_hedge_amount = arg1;
        arg0
    }

    public fun with_min_hedge_profit_bps(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.min_hedge_profit_bps = arg1;
        arg0
    }

    public fun with_min_order_size(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.min_order_size = arg1;
        assert_valid(&arg0);
        arg0
    }

    public fun with_price_offset_ticks(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.price_offset_ticks = arg1;
        arg0
    }

    public fun with_significant_qty_multiplier(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.significant_qty_multiplier = arg1;
        arg0
    }

    public fun with_target_base_position(arg0: MMConfig, arg1: u64) : MMConfig {
        arg0.target_base_position = arg1;
        assert_valid(&arg0);
        arg0
    }

    // decompiled from Move bytecode v6
}

