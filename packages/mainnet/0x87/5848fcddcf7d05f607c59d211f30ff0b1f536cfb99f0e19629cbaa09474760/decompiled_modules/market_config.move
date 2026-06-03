module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::market_config {
    struct MarketConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        max_leverage_bps: u64,
        min_coll_value: u64,
        trading_fee_bps: u64,
        max_impact_fee_bps: u64,
        allocated_lp_exposure_bps: u64,
        impact_fee_curvature: u64,
        impact_fee_scale: u64,
        maintenance_margin_bps: u64,
        max_long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        max_short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        cooldown_ms: u64,
        order_price_tick: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        basic_funding_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        funding_interval_ms: u64,
        request_checklist: vector<0x1::type_name::TypeName>,
        response_checklist: vector<0x1::type_name::TypeName>,
        position_locker: 0x2::vec_set::VecSet<u64>,
        long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        next_position_id: u64,
        next_order_id: u64,
        last_funding_timestamp: u64,
        cumulative_funding_sign: bool,
        cumulative_funding_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
    }

    public fun add_request_rule<T0, T1: drop>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut MarketConfig<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.request_checklist, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.request_checklist, v0);
        };
    }

    public fun add_response_rule<T0, T1: drop>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut MarketConfig<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.response_checklist, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.response_checklist, v0);
        };
    }

    public(friend) fun adjust_oi<T0>(arg0: &mut MarketConfig<T0>, arg1: bool, arg2: bool, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        if (arg1) {
            if (arg2) {
                arg0.long_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.long_oi, arg3);
            } else {
                let v0 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0.long_oi, arg3)) {
                    0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0.long_oi, arg3)
                } else {
                    0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
                };
                arg0.long_oi = v0;
            };
        } else if (arg2) {
            arg0.short_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::add(arg0.short_oi, arg3);
        } else {
            let v1 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0.short_oi, arg3)) {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0.short_oi, arg3)
            } else {
                0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero()
            };
            arg0.short_oi = v1;
        };
    }

    fun assert_valid_impact_fee_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = if (arg0 > 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::bp_scale()) {
            true
        } else if (arg1 > 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::math::bp_scale()) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v0) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
        };
    }

    public fun calculate_funding_rate(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : (bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero();
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg0, v0) && 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(arg1, v0)) {
            return (true, v0)
        };
        let v1 = if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gt(arg0, arg1)) {
            arg0
        } else {
            arg1
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v1, v0)) {
            return (true, v0)
        };
        if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::gte(arg0, arg1)) {
            (true, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg0, arg1), v1)))
        } else {
            (false, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::div(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::sub(arg1, arg0), v1)))
        }
    }

    public fun calculate_funding_rate_v2(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : (bool, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) {
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

    public(friend) fun increment_next_order_id<T0>(arg0: &mut MarketConfig<T0>) : u64 {
        let v0 = arg0.next_order_id;
        arg0.next_order_id = v0 + 1;
        v0
    }

    public(friend) fun increment_next_position_id<T0>(arg0: &mut MarketConfig<T0>) : u64 {
        let v0 = arg0.next_position_id;
        arg0.next_position_id = v0 + 1;
        v0
    }

    public(friend) fun lock_position<T0>(arg0: &mut MarketConfig<T0>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.position_locker, &arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_position_locked();
        };
        0x2::vec_set::insert<u64>(&mut arg0.position_locker, arg1);
    }

    public fun market_config_allocated_lp_exposure_bps<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.allocated_lp_exposure_bps
    }

    public fun market_config_basic_funding_rate<T0>(arg0: &MarketConfig<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.basic_funding_rate
    }

    public fun market_config_cooldown_ms<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.cooldown_ms
    }

    public fun market_config_cumulative_funding_index<T0>(arg0: &MarketConfig<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double {
        arg0.cumulative_funding_index
    }

    public fun market_config_cumulative_funding_sign<T0>(arg0: &MarketConfig<T0>) : bool {
        arg0.cumulative_funding_sign
    }

    public fun market_config_funding_interval_ms<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.funding_interval_ms
    }

    public fun market_config_impact_fee_curvature<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.impact_fee_curvature
    }

    public fun market_config_impact_fee_scale<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.impact_fee_scale
    }

    public fun market_config_is_active<T0>(arg0: &MarketConfig<T0>) : bool {
        arg0.is_active
    }

    public fun market_config_last_funding_timestamp<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.last_funding_timestamp
    }

    public fun market_config_long_oi<T0>(arg0: &MarketConfig<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.long_oi
    }

    public fun market_config_maintenance_margin_bps<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.maintenance_margin_bps
    }

    public fun market_config_max_impact_fee_bps<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.max_impact_fee_bps
    }

    public fun market_config_max_leverage_bps<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.max_leverage_bps
    }

    public fun market_config_max_long_oi<T0>(arg0: &MarketConfig<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.max_long_oi
    }

    public fun market_config_max_short_oi<T0>(arg0: &MarketConfig<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.max_short_oi
    }

    public fun market_config_min_coll_value<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.min_coll_value
    }

    public fun market_config_next_order_id<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.next_order_id
    }

    public fun market_config_next_position_id<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.next_position_id
    }

    public fun market_config_order_price_tick<T0>(arg0: &MarketConfig<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.order_price_tick
    }

    public fun market_config_short_oi<T0>(arg0: &MarketConfig<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.short_oi
    }

    public fun market_config_trading_fee_bps<T0>(arg0: &MarketConfig<T0>) : u64 {
        arg0.trading_fee_bps
    }

    public(friend) fun new_market_config<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : MarketConfig<T0> {
        if (arg8 == 0) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
        };
        let v0 = 2000;
        let v1 = 1;
        let v2 = 1;
        assert_valid_impact_fee_config(arg2, v0, v1, v2);
        MarketConfig<T0>{
            id                        : 0x2::object::new(arg10),
            is_active                 : true,
            max_leverage_bps          : arg0,
            min_coll_value            : arg1,
            trading_fee_bps           : arg2,
            max_impact_fee_bps        : arg2,
            allocated_lp_exposure_bps : v0,
            impact_fee_curvature      : v1,
            impact_fee_scale          : v2,
            maintenance_margin_bps    : arg3,
            max_long_oi               : arg4,
            max_short_oi              : arg5,
            cooldown_ms               : arg6,
            order_price_tick          : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::one(),
            basic_funding_rate        : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(arg7),
            funding_interval_ms       : arg8,
            request_checklist         : 0x1::vector::empty<0x1::type_name::TypeName>(),
            response_checklist        : 0x1::vector::empty<0x1::type_name::TypeName>(),
            position_locker           : 0x2::vec_set::empty<u64>(),
            long_oi                   : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            short_oi                  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero(),
            next_position_id          : 0,
            next_order_id             : 0,
            last_funding_timestamp    : 0x2::clock::timestamp_ms(arg9) / arg8 * arg8,
            cumulative_funding_sign   : true,
            cumulative_funding_index  : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::zero(),
        }
    }

    public fun remove_request_rule<T0, T1: drop>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut MarketConfig<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &arg1.request_checklist;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v3)) {
                    0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg1.request_checklist, 0x1::option::destroy_some<u64>(v3));
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

    public fun remove_response_rule<T0, T1: drop>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut MarketConfig<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = &arg1.response_checklist;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2) == &v0) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 6 */
                if (0x1::option::is_some<u64>(&v3)) {
                    0x1::vector::swap_remove<0x1::type_name::TypeName>(&mut arg1.response_checklist, 0x1::option::destroy_some<u64>(v3));
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

    public(friend) fun request_checklist<T0>(arg0: &MarketConfig<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.request_checklist
    }

    public(friend) fun response_checklist<T0>(arg0: &MarketConfig<T0>) : &vector<0x1::type_name::TypeName> {
        &arg0.response_checklist
    }

    public fun resume_market<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut MarketConfig<T0>) {
        arg1.is_active = true;
    }

    public fun suspend_market<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut MarketConfig<T0>) {
        arg1.is_active = false;
    }

    public(friend) fun unlock_position<T0>(arg0: &mut MarketConfig<T0>, arg1: u64) {
        if (0x2::vec_set::contains<u64>(&arg0.position_locker, &arg1)) {
            0x2::vec_set::remove<u64>(&mut arg0.position_locker, &arg1);
        };
    }

    public(friend) fun update_funding_rate<T0>(arg0: &mut MarketConfig<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : bool {
        let v0 = market_config_funding_interval_ms<T0>(arg0);
        let v1 = market_config_last_funding_timestamp<T0>(arg0);
        if (arg2 < v1 + v0) {
            return false
        };
        let v2 = (arg2 - v1) / v0;
        if (v2 == 0) {
            return false
        };
        let v3 = market_config_long_oi<T0>(arg0);
        let v4 = market_config_short_oi<T0>(arg0);
        let (v5, v6) = calculate_funding_rate_v2(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(v3, arg3), 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(v4, arg3), market_config_basic_funding_rate<T0>(arg0), arg4);
        let v7 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::mul_u64(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::from_float(v6), v2);
        let v8 = market_config_cumulative_funding_sign<T0>(arg0);
        let v9 = market_config_cumulative_funding_index<T0>(arg0);
        let (v10, v11) = if (v5 == v8) {
            (v5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::add(v9, v7))
        } else if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::gte(v7, v9)) {
            (v5, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v7, v9))
        } else {
            (v8, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::sub(v9, v7))
        };
        let v12 = v1 + v2 * v0;
        update_funding_state<T0>(arg0, v10, v11, v12);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events::emit_funding_rate_updated(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul_u64(v6, v2), v11, v3, v4, v12);
        true
    }

    public(friend) fun update_funding_state<T0>(arg0: &mut MarketConfig<T0>, arg1: bool, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg3: u64) {
        arg0.cumulative_funding_sign = arg1;
        arg0.cumulative_funding_index = arg2;
        arg0.last_funding_timestamp = arg3;
    }

    public fun update_market_config<T0>(arg0: &0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::admin::AdminCap, arg1: &mut MarketConfig<T0>, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u128>, arg11: 0x1::option::Option<u128>, arg12: 0x1::option::Option<u64>, arg13: 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>, arg14: 0x1::option::Option<u64>, arg15: 0x1::option::Option<u64>) {
        if (0x1::option::is_some<u64>(&arg2)) {
            arg1.max_leverage_bps = 0x1::option::destroy_some<u64>(arg2);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            arg1.min_coll_value = 0x1::option::destroy_some<u64>(arg3);
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            arg1.trading_fee_bps = 0x1::option::destroy_some<u64>(arg4);
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            arg1.max_impact_fee_bps = 0x1::option::destroy_some<u64>(arg5);
        };
        if (0x1::option::is_some<u64>(&arg6)) {
            arg1.allocated_lp_exposure_bps = 0x1::option::destroy_some<u64>(arg6);
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            arg1.impact_fee_curvature = 0x1::option::destroy_some<u64>(arg7);
        };
        if (0x1::option::is_some<u64>(&arg8)) {
            arg1.impact_fee_scale = 0x1::option::destroy_some<u64>(arg8);
        };
        assert_valid_impact_fee_config(arg1.max_impact_fee_bps, arg1.allocated_lp_exposure_bps, arg1.impact_fee_curvature, arg1.impact_fee_scale);
        if (0x1::option::is_some<u64>(&arg9)) {
            arg1.maintenance_margin_bps = 0x1::option::destroy_some<u64>(arg9);
        };
        if (0x1::option::is_some<u128>(&arg10)) {
            arg1.max_long_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg10));
        };
        if (0x1::option::is_some<u128>(&arg11)) {
            arg1.max_short_oi = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_scaled_val(0x1::option::destroy_some<u128>(arg11));
        };
        if (0x1::option::is_some<u64>(&arg12)) {
            arg1.cooldown_ms = 0x1::option::destroy_some<u64>(arg12);
        };
        if (0x1::option::is_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(&arg13)) {
            let v0 = 0x1::option::destroy_some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float>(arg13);
            if (0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::eq(v0, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::zero())) {
                0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
            };
            arg1.order_price_tick = v0;
        };
        if (0x1::option::is_some<u64>(&arg14)) {
            arg1.basic_funding_rate = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from_bps(0x1::option::destroy_some<u64>(arg14));
        };
        if (0x1::option::is_some<u64>(&arg15)) {
            let v1 = 0x1::option::destroy_some<u64>(arg15);
            if (v1 == 0) {
                0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_invalid_config();
            };
            arg1.funding_interval_ms = v1;
        };
    }

    // decompiled from Move bytecode v7
}

