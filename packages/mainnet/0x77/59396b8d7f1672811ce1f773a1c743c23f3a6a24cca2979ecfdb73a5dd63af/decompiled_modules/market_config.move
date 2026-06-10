module 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::market_config {
    struct MarketConfig has store, key {
        id: 0x2::object::UID,
        symbol: 0x1::string::String,
        is_paused: bool,
        max_leverage_bps: u64,
        min_coll_value: u64,
        trading_fee: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_impact_fee: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        allocated_lp_exposure_bps: u64,
        impact_fee_curvature: u64,
        impact_fee_scale: u64,
        maintenance_margin: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        cooldown_ms: u64,
        order_price_tick: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_pre_orders: u64,
        basic_funding_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        funding_interval_ms: u64,
        request_checklist: vector<0x1::type_name::TypeName>,
        position_locker: 0x2::vec_set::VecSet<u64>,
        long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        long_avg_entry_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        short_avg_entry_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        next_position_id: u64,
        next_order_id: u64,
        last_funding_timestamp: u64,
        cumulative_funding_sign: bool,
        cumulative_funding_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
    }

    public fun add_request_rule<T0: drop>(arg0: &mut MarketConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.request_checklist, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.request_checklist, v0);
        };
    }

    fun assert_valid_impact_fee_config(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one())) {
            true
        } else if (arg1 > 0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::math::bp_scale()) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            abort 13906837051971469313
        };
    }

    fun average_price_after_decrease(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0, v0)) {
            return v0
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg2, v0)) {
            return arg1
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg2, arg0)) {
            return v0
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0, arg1), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg2, arg3)), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0, arg2))
    }

    public fun calculate_funding_rate(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : (bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0, v0) && 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg1, v0)) {
            return (true, v0)
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg3, v0)) {
            return (true, v0)
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0, arg1)) {
            (true, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0, arg1)), arg3))
        } else {
            (false, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg1, arg0)), arg3))
        }
    }

    public(friend) fun decrease_oi(arg0: &mut MarketConfig, arg1: bool, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        if (arg1) {
            arg0.long_avg_entry_price = average_price_after_decrease(arg0.long_oi, arg0.long_avg_entry_price, arg2, arg3);
            let v0 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0.long_oi, arg2)) {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0.long_oi, arg2)
            } else {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
            };
            arg0.long_oi = v0;
        } else {
            arg0.short_avg_entry_price = average_price_after_decrease(arg0.short_oi, arg0.short_avg_entry_price, arg2, arg3);
            let v1 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0.short_oi, arg2)) {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0.short_oi, arg2)
            } else {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
            };
            arg0.short_oi = v1;
        };
    }

    public(friend) fun increase_oi(arg0: &mut MarketConfig, arg1: bool, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return
        };
        if (arg1) {
            arg0.long_avg_entry_price = weighted_average_price(arg0.long_oi, arg0.long_avg_entry_price, arg2, arg3);
            arg0.long_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.long_oi, arg2);
        } else {
            arg0.short_avg_entry_price = weighted_average_price(arg0.short_oi, arg0.short_avg_entry_price, arg2, arg3);
            arg0.short_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.short_oi, arg2);
        };
    }

    public(friend) fun increment_next_order_id(arg0: &mut MarketConfig) : u64 {
        let v0 = arg0.next_order_id;
        arg0.next_order_id = v0 + 1;
        v0
    }

    public(friend) fun increment_next_position_id(arg0: &mut MarketConfig) : u64 {
        let v0 = arg0.next_position_id;
        arg0.next_position_id = v0 + 1;
        v0
    }

    public(friend) fun lock_position(arg0: &mut MarketConfig, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.position_locker, &arg1)) {
            abort 13906835518668275715
        };
        0x2::vec_set::insert<u64>(&mut arg0.position_locker, arg1);
    }

    public fun lp_equity_usd(arg0: &MarketConfig, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let (v0, v1) = unrealized_trader_pnl(arg0, arg2);
        if (v0) {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::saturating_sub(arg1, v1)
        } else {
            0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg1, v1)
        }
    }

    public fun market_config_allocated_lp_exposure_bps(arg0: &MarketConfig) : u64 {
        arg0.allocated_lp_exposure_bps
    }

    public fun market_config_basic_funding_rate(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.basic_funding_rate
    }

    public fun market_config_cooldown_ms(arg0: &MarketConfig) : u64 {
        arg0.cooldown_ms
    }

    public fun market_config_cumulative_funding_index(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        arg0.cumulative_funding_index
    }

    public fun market_config_cumulative_funding_sign(arg0: &MarketConfig) : bool {
        arg0.cumulative_funding_sign
    }

    public fun market_config_funding_interval_ms(arg0: &MarketConfig) : u64 {
        arg0.funding_interval_ms
    }

    public fun market_config_impact_fee_curvature(arg0: &MarketConfig) : u64 {
        arg0.impact_fee_curvature
    }

    public fun market_config_impact_fee_scale(arg0: &MarketConfig) : u64 {
        arg0.impact_fee_scale
    }

    public fun market_config_is_paused(arg0: &MarketConfig) : bool {
        arg0.is_paused
    }

    public fun market_config_last_funding_timestamp(arg0: &MarketConfig) : u64 {
        arg0.last_funding_timestamp
    }

    public fun market_config_long_avg_entry_price(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.long_avg_entry_price
    }

    public fun market_config_long_oi(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.long_oi
    }

    public fun market_config_maintenance_margin(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.maintenance_margin
    }

    public fun market_config_max_impact_fee(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.max_impact_fee
    }

    public fun market_config_max_leverage_bps(arg0: &MarketConfig) : u64 {
        arg0.max_leverage_bps
    }

    public fun market_config_max_long_oi(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.max_long_oi
    }

    public fun market_config_max_pre_orders(arg0: &MarketConfig) : u64 {
        arg0.max_pre_orders
    }

    public fun market_config_max_short_oi(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.max_short_oi
    }

    public fun market_config_min_coll_value(arg0: &MarketConfig) : u64 {
        arg0.min_coll_value
    }

    public fun market_config_next_order_id(arg0: &MarketConfig) : u64 {
        arg0.next_order_id
    }

    public fun market_config_next_position_id(arg0: &MarketConfig) : u64 {
        arg0.next_position_id
    }

    public fun market_config_order_price_tick(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.order_price_tick
    }

    public fun market_config_short_avg_entry_price(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.short_avg_entry_price
    }

    public fun market_config_short_oi(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.short_oi
    }

    public fun market_config_symbol(arg0: &MarketConfig) : 0x1::string::String {
        arg0.symbol
    }

    public fun market_config_trading_fee(arg0: &MarketConfig) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.trading_fee
    }

    public(friend) fun new_market_config(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u128, arg4: u128, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg7: u64, arg8: u128, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : MarketConfig {
        if (arg9 == 0) {
            abort 13906834676854554625
        };
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg3);
        let v1 = 2000;
        let v2 = 1;
        let v3 = 1;
        assert_valid_impact_fee_config(v0, v1, v2, v3);
        MarketConfig{
            id                        : 0x2::object::new(arg11),
            symbol                    : arg0,
            is_paused                 : false,
            max_leverage_bps          : arg1,
            min_coll_value            : arg2,
            trading_fee               : v0,
            max_impact_fee            : v0,
            allocated_lp_exposure_bps : v1,
            impact_fee_curvature      : v2,
            impact_fee_scale          : v3,
            maintenance_margin        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg4),
            max_long_oi               : arg5,
            max_short_oi              : arg6,
            cooldown_ms               : arg7,
            order_price_tick          : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one(),
            max_pre_orders            : 2,
            basic_funding_rate        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(arg8),
            funding_interval_ms       : arg9,
            request_checklist         : 0x1::vector::empty<0x1::type_name::TypeName>(),
            position_locker           : 0x2::vec_set::empty<u64>(),
            long_oi                   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            short_oi                  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            long_avg_entry_price      : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            short_avg_entry_price     : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            next_position_id          : 0,
            next_order_id             : 0,
            last_funding_timestamp    : 0x2::clock::timestamp_ms(arg10) / arg9 * arg9,
            cumulative_funding_sign   : true,
            cumulative_funding_index  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero(),
        }
    }

    public fun pause_market(arg0: &mut MarketConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap) {
        arg0.is_paused = true;
    }

    public fun remove_request_rule<T0: drop>(arg0: &mut MarketConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = &arg0.request_checklist;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v3)) {
                    0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg0.request_checklist, 0x1::option::destroy_some<u64>(v3));
                } else {
                    0x1::option::destroy_none<u64>(v3);
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public(friend) fun request_checklist(arg0: &MarketConfig) : &vector<0x1::type_name::TypeName> {
        &arg0.request_checklist
    }

    public(friend) fun unlock_position(arg0: &mut MarketConfig, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.position_locker, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.position_locker, &arg1);
        };
    }

    public fun unpause_market(arg0: &mut MarketConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap) {
        arg0.is_paused = false;
    }

    public fun unrealized_trader_pnl(arg0: &MarketConfig, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : (bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        let v1 = v0;
        let v2 = v0;
        if (!0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0.long_oi, v0) && !0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0.long_avg_entry_price, v0)) {
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg1, arg0.long_avg_entry_price)) {
                v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0.long_oi, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg1, arg0.long_avg_entry_price)));
            } else {
                v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0.long_oi, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0.long_avg_entry_price, arg1)));
            };
        };
        if (!0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0.short_oi, v0) && !0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0.short_avg_entry_price, v0)) {
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0.short_avg_entry_price, arg1)) {
                v1 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0.short_oi, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0.short_avg_entry_price, arg1)));
            } else {
                v2 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(v2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0.short_oi, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg1, arg0.short_avg_entry_price)));
            };
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(v1, v2)) {
            (true, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v1, v2))
        } else {
            (false, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(v2, v1))
        }
    }

    public(friend) fun update_funding_config(arg0: &mut MarketConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: 0x1::option::Option<u128>, arg3: 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u128>(&arg2)) {
            arg0.basic_funding_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg2));
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            let v0 = 0x1::option::destroy_some<u64>(arg3);
            if (v0 == 0) {
                abort 13906835372639256577
            };
            arg0.funding_interval_ms = v0;
        };
    }

    public(friend) fun update_funding_rate(arg0: &mut MarketConfig, arg1: 0x2::object::ID, arg2: u64, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : bool {
        let v0 = market_config_funding_interval_ms(arg0);
        let v1 = market_config_last_funding_timestamp(arg0);
        if (arg2 < v1 + v0) {
            return false
        };
        let v2 = (arg2 - v1) / v0;
        if (v2 == 0) {
            return false
        };
        let v3 = market_config_long_oi(arg0);
        let v4 = market_config_short_oi(arg0);
        let (v5, v6) = calculate_funding_rate(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(v3, arg3), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(v4, arg3), market_config_basic_funding_rate(arg0), arg4);
        let v7 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_float(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(v6, arg3)), v2);
        let v8 = market_config_cumulative_funding_sign(arg0);
        let v9 = market_config_cumulative_funding_index(arg0);
        let (v10, v11) = if (v5 == v8) {
            (v5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(v9, v7))
        } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::gte(v7, v9)) {
            (v5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v7, v9))
        } else {
            (v8, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v9, v7))
        };
        update_funding_state(arg0, v10, v11, v1 + v2 * v0);
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_funding_rate_updated(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v6, v2), v5, v11, v10, v3, v4);
        true
    }

    public(friend) fun update_funding_state(arg0: &mut MarketConfig, arg1: bool, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg3: u64) {
        arg0.cumulative_funding_sign = arg1;
        arg0.cumulative_funding_index = arg2;
        arg0.last_funding_timestamp = arg3;
    }

    public fun update_market_config(arg0: &mut MarketConfig, arg1: &0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::admin::AdminCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u128>, arg5: 0x1::option::Option<u128>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u128>, arg10: 0x1::option::Option<u128>, arg11: 0x1::option::Option<u128>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u128>, arg16: 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u128>(&arg15) || 0x1::option::is_some<u64>(&arg16)) {
            abort 13906834981797232641
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            arg0.max_leverage_bps = 0x1::option::destroy_some<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg0.min_coll_value = 0x1::option::destroy_some<u64>(arg3);
        };
        if (0x1::option::is_some<u128>(&arg4)) {
            arg0.trading_fee = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg4));
        };
        if (0x1::option::is_some<u128>(&arg5)) {
            arg0.max_impact_fee = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg5));
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            arg0.allocated_lp_exposure_bps = 0x1::option::destroy_some<u64>(arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            arg0.impact_fee_curvature = 0x1::option::destroy_some<u64>(arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            arg0.impact_fee_scale = 0x1::option::destroy_some<u64>(arg8);
        };
        assert_valid_impact_fee_config(arg0.max_impact_fee, arg0.allocated_lp_exposure_bps, arg0.impact_fee_curvature, arg0.impact_fee_scale);
        if (0x1::option::is_some<u128>(&arg9)) {
            arg0.maintenance_margin = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg9));
        };
        if (0x1::option::is_some<u128>(&arg10)) {
            arg0.max_long_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg10));
        };
        if (0x1::option::is_some<u128>(&arg11)) {
            arg0.max_short_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg11));
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            arg0.cooldown_ms = 0x1::option::destroy_some<u64>(arg12);
        };
        if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg13)) {
            let v0 = 0x1::option::destroy_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(arg13);
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
                abort 13906835153595924481
            };
            arg0.order_price_tick = v0;
        };
        if (0x1::option::is_some<u64>(&arg14)) {
            arg0.max_pre_orders = 0x1::option::destroy_some<u64>(arg14);
        };
        0x44dad8a2899167fe2806c2c298366c0824180fc382aa66cb8bd034b2e9aef96f::events::emit_market_config_updated(0x2::object::uid_to_inner(&arg0.id), arg0.is_paused, arg0.max_leverage_bps, arg0.min_coll_value, arg0.trading_fee, arg0.max_impact_fee, arg0.allocated_lp_exposure_bps, arg0.impact_fee_curvature, arg0.impact_fee_scale, arg0.maintenance_margin, arg0.max_long_oi, arg0.max_short_oi, arg0.cooldown_ms, arg0.order_price_tick, arg0.max_pre_orders, arg0.basic_funding_rate, arg0.funding_interval_ms, arg0.request_checklist, arg0.position_locker, arg0.long_oi, arg0.short_oi, arg0.long_avg_entry_price, arg0.short_avg_entry_price, arg0.next_position_id, arg0.next_order_id, arg0.last_funding_timestamp, arg0.cumulative_funding_sign, arg0.cumulative_funding_index);
    }

    fun weighted_average_price(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0, arg2);
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
            return arg3
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg0, arg1), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg2, arg3)), v0)
    }

    // decompiled from Move bytecode v7
}

