module 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::position {
    struct PositionConfig has copy, drop, store {
        max_leverage: u64,
        min_holding_duration: u64,
        max_reserved_multiplier: u64,
        min_collateral_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        min_order_fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        open_fee_bps: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
        decrease_fee_bps: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
        liquidation_threshold: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
        liquidation_bonus: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
    }

    struct Position<phantom T0> has store {
        closed: bool,
        config: PositionConfig,
        open_timestamp: u64,
        position_amount: u64,
        position_size: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        reserving_fee_amount: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        funding_fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal,
        last_reserving_rate: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate,
        last_funding_rate: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::SRate,
        reserved: 0x2::balance::Balance<T0>,
        collateral: 0x2::balance::Balance<T0>,
    }

    struct OpenPositionResult<phantom T0> {
        position: Position<T0>,
        open_fee: 0x2::balance::Balance<T0>,
        open_fee_amount: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
    }

    struct DecreasePositionResult<phantom T0> {
        closed: bool,
        has_profit: bool,
        settled_amount: u64,
        decreased_reserved_amount: u64,
        decrease_size: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        reserving_fee_amount: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        decrease_fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        reserving_fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal,
        funding_fee_value: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal,
        to_vault: 0x2::balance::Balance<T0>,
        to_trader: 0x2::balance::Balance<T0>,
    }

    public fun check_holding_duration<T0>(arg0: &Position<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal, arg2: u64) : bool {
        !0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::is_positive(arg1) || arg0.open_timestamp + arg0.config.min_holding_duration <= arg2
    }

    public fun check_leverage(arg0: &PositionConfig, arg1: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, arg2: u64, arg3: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice) : bool {
        let v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_with_u64(arg1, arg0.max_leverage);
        let v1 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg3, arg2);
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v0, &v1)
    }

    public fun check_liquidation(arg0: &PositionConfig, arg1: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal) : bool {
        if (0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::is_positive(arg2)) {
            false
        } else {
            let v1 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_with_rate(arg1, arg0.liquidation_threshold);
            let v2 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::value(arg2);
            0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::le(&v1, &v2)
        }
    }

    public fun closed<T0>(arg0: &Position<T0>) : bool {
        arg0.closed
    }

    public fun collateral_amount<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun compute_delta_size<T0>(arg0: &Position<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg2: bool) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal {
        let v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, arg0.position_amount);
        let (v1, v2) = if (0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::gt(&v0, &arg0.position_size)) {
            (arg2, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::sub(v0, arg0.position_size))
        } else {
            (!arg2, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::sub(arg0.position_size, v0))
        };
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::from_decimal(v1, v2)
    }

    public fun compute_funding_fee_value<T0>(arg0: &Position<T0>, arg1: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::SRate) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal {
        let v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::sub(arg1, arg0.last_funding_rate);
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::add(arg0.funding_fee_value, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::from_decimal(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::is_positive(&v0), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_with_rate(arg0.position_size, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::value(&v0))))
    }

    public fun compute_reserving_fee_amount<T0>(arg0: &Position<T0>, arg1: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal {
        0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::add(arg0.reserving_fee_amount, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_with_rate(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_u64(0x2::balance::value<T0>(&arg0.reserved)), 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::sub(arg1, arg0.last_reserving_rate)))
    }

    public fun config_decrease_fee_bps(arg0: &PositionConfig) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate {
        arg0.decrease_fee_bps
    }

    public fun config_liquidation_bonus(arg0: &PositionConfig) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate {
        arg0.liquidation_bonus
    }

    public fun config_liquidation_threshold(arg0: &PositionConfig) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate {
        arg0.liquidation_threshold
    }

    public fun config_max_leverage(arg0: &PositionConfig) : u64 {
        arg0.max_leverage
    }

    public fun config_max_reserved_multiplier(arg0: &PositionConfig) : u64 {
        arg0.max_reserved_multiplier
    }

    public fun config_min_collateral_value(arg0: &PositionConfig) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal {
        arg0.min_collateral_value
    }

    public fun config_min_holding_duration(arg0: &PositionConfig) : u64 {
        arg0.min_holding_duration
    }

    public fun config_min_order_fee_value(arg0: &PositionConfig) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal {
        arg0.min_order_fee_value
    }

    public fun config_open_fee_bps(arg0: &PositionConfig) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate {
        arg0.open_fee_bps
    }

    public(friend) fun decrease_position<T0>(arg0: &mut Position<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg3: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, arg4: bool, arg5: u64, arg6: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate, arg7: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::SRate, arg8: u64) : DecreasePositionResult<T0> {
        assert!(!arg0.closed, 401);
        let v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(arg1);
        assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v0, &arg3), 415);
        assert!(arg5 > 0 && arg5 <= arg0.position_amount, 406);
        let v1 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_div_by_64(arg0.position_size, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_u64(arg5), arg0.position_amount);
        let v2 = compute_delta_size<T0>(arg0, arg2, arg4);
        let v3 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::div_by_u64(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::mul_with_u64(v2, arg5), arg0.position_amount);
        let v4 = v2;
        v2 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::sub(v4, v3);
        assert!(check_holding_duration<T0>(arg0, &v2, arg8), 410);
        let v5 = compute_reserving_fee_amount<T0>(arg0, arg6);
        let v6 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ceil_u64(v5));
        let v7 = compute_funding_fee_value<T0>(arg0, arg7);
        let v8 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_with_rate(v1, arg0.config.decrease_fee_bps);
        let v9 = v3;
        v3 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::sub(v9, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::add_with_decimal(v7, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::add(v8, v6)));
        let v10 = arg5 == arg0.position_amount;
        let v11 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::is_positive(&v3);
        let v12 = if (v11) {
            let v13 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::floor_u64(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::value_to_coins(arg1, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::value(&v3)));
            let v14 = v13;
            if (v13 >= 0x2::balance::value<T0>(&arg0.reserved)) {
                v10 = true;
                v14 = 0x2::balance::value<T0>(&arg0.reserved);
            };
            v14
        } else {
            let v15 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ceil_u64(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::value_to_coins(arg1, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::value(&v3)));
            let v16 = v15;
            if (v15 >= 0x2::balance::value<T0>(&arg0.collateral)) {
                v10 = true;
                v16 = 0x2::balance::value<T0>(&arg0.collateral);
            };
            v16
        };
        let v17 = if (v10) {
            0x2::balance::value<T0>(&arg0.reserved)
        } else if (v11) {
            v12
        } else {
            0
        };
        let v18 = arg0.position_amount - arg5;
        if (!v10) {
            let v19 = if (v11) {
                0x2::balance::value<T0>(&arg0.collateral)
            } else {
                0x2::balance::value<T0>(&arg0.collateral) - v12
            };
            let v20 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, v19);
            assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v20, &arg0.config.min_collateral_value), 409);
            assert!(check_leverage(&arg0.config, v20, v18, arg2), 411);
            assert!(!check_liquidation(&arg0.config, v20, &v2), 412);
        };
        arg0.closed = v10;
        arg0.position_amount = v18;
        arg0.position_size = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::sub(arg0.position_size, v1);
        arg0.reserving_fee_amount = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero();
        arg0.funding_fee_value = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::zero();
        arg0.last_funding_rate = arg7;
        arg0.last_reserving_rate = arg6;
        let (v21, v22) = if (v11) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T0>(&mut arg0.reserved, v12))
        } else {
            (0x2::balance::split<T0>(&mut arg0.collateral, v12), 0x2::balance::zero<T0>())
        };
        let v23 = v22;
        let v24 = v21;
        if (v10) {
            0x2::balance::join<T0>(&mut v24, 0x2::balance::withdraw_all<T0>(&mut arg0.reserved));
            0x2::balance::join<T0>(&mut v23, 0x2::balance::withdraw_all<T0>(&mut arg0.collateral));
        };
        DecreasePositionResult<T0>{
            closed                    : v10,
            has_profit                : v11,
            settled_amount            : v12,
            decreased_reserved_amount : v17,
            decrease_size             : v1,
            reserving_fee_amount      : v5,
            decrease_fee_value        : v8,
            reserving_fee_value       : v6,
            funding_fee_value         : v7,
            to_vault                  : v24,
            to_trader                 : v23,
        }
    }

    public(friend) fun decrease_reserved_from_position<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate) : 0x2::balance::Balance<T0> {
        assert!(!arg0.closed, 401);
        assert!(arg1 < 0x2::balance::value<T0>(&arg0.reserved), 408);
        arg0.reserving_fee_amount = compute_reserving_fee_amount<T0>(arg0, arg2);
        arg0.last_reserving_rate = arg2;
        0x2::balance::split<T0>(&mut arg0.reserved, arg1)
    }

    public(friend) fun destroy_position<T0>(arg0: Position<T0>) {
        let Position {
            closed               : v0,
            config               : _,
            open_timestamp       : _,
            position_amount      : _,
            position_size        : _,
            reserving_fee_amount : _,
            funding_fee_value    : _,
            last_reserving_rate  : _,
            last_funding_rate    : _,
            reserved             : v9,
            collateral           : v10,
        } = arg0;
        assert!(v0, 402);
        0x2::balance::destroy_zero<T0>(v9);
        0x2::balance::destroy_zero<T0>(v10);
    }

    public(friend) fun force_settle<T0>(arg0: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::admin::AdminCap, arg1: &mut Position<T0>, arg2: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate, arg3: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::SRate) : (0x2::balance::Balance<T0>, u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal, 0x2::balance::Balance<T0>, u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal) {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.reserved);
        arg1.closed = true;
        arg1.position_amount = 0;
        arg1.position_size = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero();
        arg1.reserving_fee_amount = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero();
        arg1.funding_fee_value = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::zero();
        arg1.last_funding_rate = arg3;
        arg1.last_reserving_rate = arg2;
        (v0, 0x2::balance::value<T0>(&v0), compute_reserving_fee_amount<T0>(arg1, arg2), compute_funding_fee_value<T0>(arg1, arg3), 0x2::balance::withdraw_all<T0>(&mut arg1.collateral), arg1.position_amount, arg1.position_size)
    }

    public(friend) fun liquidate_position<T0>(arg0: &mut Position<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg3: bool, arg4: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate, arg5: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::SRate) : (u64, u64, u64, u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(!arg0.closed, 401);
        let v0 = compute_delta_size<T0>(arg0, arg2, arg3);
        let v1 = compute_reserving_fee_amount<T0>(arg0, arg4);
        let v2 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ceil_u64(v1));
        let v3 = compute_funding_fee_value<T0>(arg0, arg5);
        let v4 = v0;
        v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::sub(v4, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::add_with_decimal(v3, v2));
        assert!(check_liquidation(&arg0.config, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, 0x2::balance::value<T0>(&arg0.collateral)), &v0), 413);
        let v5 = 0x2::balance::value<T0>(&arg0.collateral);
        arg0.closed = true;
        arg0.position_amount = 0;
        arg0.position_size = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero();
        arg0.reserving_fee_amount = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero();
        arg0.funding_fee_value = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::zero();
        arg0.last_funding_rate = arg5;
        arg0.last_reserving_rate = arg4;
        let v6 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::floor_u64(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_with_rate(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_u64(v5), arg0.config.liquidation_bonus));
        let v7 = 0x2::balance::withdraw_all<T0>(&mut arg0.reserved);
        0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(&mut arg0.collateral));
        (v6, v5, arg0.position_amount, 0x2::balance::value<T0>(&arg0.reserved), arg0.position_size, v1, v2, v3, v7, 0x2::balance::split<T0>(&mut arg0.collateral, v6))
    }

    public(friend) fun new_position_config(arg0: u64, arg1: u64, arg2: u64, arg3: u256, arg4: u256, arg5: u128, arg6: u128, arg7: u128, arg8: u128) : PositionConfig {
        PositionConfig{
            max_leverage            : arg0,
            min_holding_duration    : arg1,
            max_reserved_multiplier : arg2,
            min_collateral_value    : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg3),
            min_order_fee_value     : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::from_raw(arg4),
            open_fee_bps            : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_raw(arg5),
            decrease_fee_bps        : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_raw(arg6),
            liquidation_threshold   : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_raw(arg7),
            liquidation_bonus       : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::from_raw(arg8),
        }
    }

    public(friend) fun open_position<T0>(arg0: &PositionConfig, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T0>, arg5: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, arg6: u64, arg7: u64, arg8: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate, arg9: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::SRate, arg10: u64) : OpenPositionResult<T0> {
        assert!(0x2::balance::value<T0>(arg4) > 0, 403);
        let v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::price_of(arg1);
        assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v0, &arg5), 415);
        assert!(arg6 > 0, 405);
        assert!(arg7 <= 0x2::balance::value<T0>(arg4) * arg0.max_reserved_multiplier, 414);
        let v1 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg2, arg6);
        let v2 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::value_to_coins(arg1, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::mul_with_rate(v1, arg0.open_fee_bps));
        let v3 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ceil_u64(v2);
        assert!(0x2::balance::value<T0>(arg4) >= v3, 407);
        let v4 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, 0x2::balance::value<T0>(arg4) - v3);
        assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v4, &arg0.min_collateral_value), 409);
        assert!(check_leverage(arg0, v4, arg6, arg2), 411);
        let v5 = Position<T0>{
            closed               : false,
            config               : *arg0,
            open_timestamp       : arg10,
            position_amount      : arg6,
            position_size        : v1,
            reserving_fee_amount : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::zero(),
            funding_fee_value    : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::zero(),
            last_reserving_rate  : arg8,
            last_funding_rate    : arg9,
            reserved             : 0x2::balance::split<T0>(arg3, arg7),
            collateral           : 0x2::balance::withdraw_all<T0>(arg4),
        };
        OpenPositionResult<T0>{
            position        : v5,
            open_fee        : 0x2::balance::split<T0>(arg4, v3),
            open_fee_amount : v2,
        }
    }

    public fun open_timestamp<T0>(arg0: &Position<T0>) : u64 {
        arg0.open_timestamp
    }

    public(friend) fun pledge_in_position<T0>(arg0: &mut Position<T0>, arg1: 0x2::balance::Balance<T0>) {
        assert!(!arg0.closed, 401);
        assert!(0x2::balance::value<T0>(&arg1) > 0, 403);
        0x2::balance::join<T0>(&mut arg0.collateral, arg1);
    }

    public fun position_amount<T0>(arg0: &Position<T0>) : u64 {
        arg0.position_amount
    }

    public fun position_config<T0>(arg0: &Position<T0>) : &PositionConfig {
        &arg0.config
    }

    public fun position_size<T0>(arg0: &Position<T0>) : 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal {
        arg0.position_size
    }

    public(friend) fun redeem_from_position<T0>(arg0: &mut Position<T0>, arg1: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg2: &0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::AggPrice, arg3: bool, arg4: u64, arg5: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::rate::Rate, arg6: 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::srate::SRate, arg7: u64) : 0x2::balance::Balance<T0> {
        assert!(!arg0.closed, 401);
        assert!(arg4 > 0 && arg4 < 0x2::balance::value<T0>(&arg0.collateral), 404);
        let v0 = compute_delta_size<T0>(arg0, arg2, arg3);
        assert!(check_holding_duration<T0>(arg0, &v0, arg7), 410);
        let v1 = compute_reserving_fee_amount<T0>(arg0, arg5);
        let v2 = compute_funding_fee_value<T0>(arg0, arg6);
        let v3 = v0;
        v0 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::sub(v3, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::add_with_decimal(v2, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ceil_u64(v1))));
        arg0.reserving_fee_amount = v1;
        arg0.funding_fee_value = v2;
        arg0.last_reserving_rate = arg5;
        arg0.last_funding_rate = arg6;
        let v4 = 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::agg_price::coins_to_value(arg1, 0x2::balance::value<T0>(&arg0.collateral));
        assert!(0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::ge(&v4, &arg0.config.min_collateral_value), 409);
        assert!(check_leverage(&arg0.config, v4, arg0.position_amount, arg2), 411);
        assert!(!check_liquidation(&arg0.config, v4, &v0), 412);
        0x2::balance::split<T0>(&mut arg0.collateral, arg4)
    }

    public fun reserved_amount<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserved)
    }

    public(friend) fun unwrap_decrease_position_result<T0>(arg0: DecreasePositionResult<T0>) : (bool, bool, u64, u64, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::sdecimal::SDecimal, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let DecreasePositionResult {
            closed                    : v0,
            has_profit                : v1,
            settled_amount            : v2,
            decreased_reserved_amount : v3,
            decrease_size             : v4,
            reserving_fee_amount      : v5,
            decrease_fee_value        : v6,
            reserving_fee_value       : v7,
            funding_fee_value         : v8,
            to_vault                  : v9,
            to_trader                 : v10,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
    }

    public(friend) fun unwrap_open_position_result<T0>(arg0: OpenPositionResult<T0>) : (Position<T0>, 0x2::balance::Balance<T0>, 0xf5f0c7cf280cb41f2934757ce28c8afdd38966b1156afc8fbbf1e9b2011a3ba7::decimal::Decimal) {
        let OpenPositionResult {
            position        : v0,
            open_fee        : v1,
            open_fee_amount : v2,
        } = arg0;
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

