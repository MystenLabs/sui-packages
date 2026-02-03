module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::position {
    struct PositionConfig has copy, drop, store {
        max_leverage: u64,
        min_holding_duration: u64,
        max_reserved_multiplier: u64,
        min_collateral_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        open_fee_bps: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        decrease_fee_bps: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        liquidation_threshold: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        liquidation_bonus: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
    }

    struct PositionInstantExitFeeConfig has copy, drop, store {
        instant_exit_tier_1_duration_threshold: u64,
        instant_exit_tier_1_fee_bps: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        instant_exit_tier_1_fee_enabled: bool,
        instant_exit_tier_2_duration_threshold: u64,
        instant_exit_tier_2_fee_bps: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        instant_exit_tier_2_fee_enabled: bool,
        instant_exit_tier_3_duration_threshold: u64,
        instant_exit_tier_3_fee_bps: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        instant_exit_tier_3_fee_enabled: bool,
    }

    struct Position<phantom T0> has store {
        closed: bool,
        config: PositionConfig,
        open_timestamp: u64,
        position_amount: u64,
        position_size: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        reserving_fee_amount: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        funding_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal,
        last_reserving_rate: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        last_funding_rate: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate,
        reserved: 0x2::balance::Balance<T0>,
        collateral: 0x2::balance::Balance<T0>,
    }

    struct OpenPositionResult<phantom T0> {
        position: Position<T0>,
        open_fee: 0x2::balance::Balance<T0>,
        open_fee_amount: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct DecreasePositionResult<phantom T0> {
        closed: bool,
        has_profit: bool,
        settled_amount: u64,
        decreased_reserved_amount: u64,
        decrease_size: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        reserving_fee_amount: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        decrease_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        reserving_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        funding_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal,
        to_vault: 0x2::balance::Balance<T0>,
        to_trader: 0x2::balance::Balance<T0>,
    }

    struct DecreasePositionResultV2<phantom T0> {
        closed: bool,
        has_profit: bool,
        settled_amount: u64,
        decreased_reserved_amount: u64,
        decrease_size: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        reserving_fee_amount: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        decrease_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        reserving_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        funding_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal,
        instant_exit_fee_value: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        instant_exit_fee_tier: u8,
        to_vault: 0x2::balance::Balance<T0>,
        to_trader: 0x2::balance::Balance<T0>,
    }

    fun calculate_instant_exit_fee(arg0: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg1: u64, arg2: &PositionInstantExitFeeConfig, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal) : (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, u8) {
        if (!0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::is_positive(&arg3)) {
            return (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(), 0)
        };
        if (arg2.instant_exit_tier_1_fee_enabled && arg1 <= arg2.instant_exit_tier_1_duration_threshold) {
            return (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg0, arg2.instant_exit_tier_1_fee_bps), 1)
        };
        if (arg2.instant_exit_tier_2_fee_enabled && arg1 <= arg2.instant_exit_tier_2_duration_threshold) {
            return (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg0, arg2.instant_exit_tier_2_fee_bps), 2)
        };
        if (arg2.instant_exit_tier_3_fee_enabled && arg1 <= arg2.instant_exit_tier_3_duration_threshold) {
            return (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg0, arg2.instant_exit_tier_3_fee_bps), 3)
        };
        (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(), 0)
    }

    public fun check_holding_duration<T0>(arg0: &Position<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal, arg2: u64) : bool {
        !0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::is_positive(arg1) || arg0.open_timestamp + arg0.config.min_holding_duration <= arg2
    }

    public fun check_leverage(arg0: &PositionConfig, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: u64, arg3: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice) : bool {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(arg1, arg0.max_leverage);
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg3, arg2);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &v1)
    }

    public fun check_liquidation(arg0: &PositionConfig, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal) : bool {
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::is_positive(arg2)) {
            false
        } else {
            let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg1, arg0.liquidation_threshold);
            let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::value(arg2);
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::le(&v1, &v2)
        }
    }

    public(friend) fun clone_position_instant_exit_fee_config(arg0: &PositionInstantExitFeeConfig) : PositionInstantExitFeeConfig {
        PositionInstantExitFeeConfig{
            instant_exit_tier_1_duration_threshold : arg0.instant_exit_tier_1_duration_threshold,
            instant_exit_tier_1_fee_bps            : arg0.instant_exit_tier_1_fee_bps,
            instant_exit_tier_1_fee_enabled        : arg0.instant_exit_tier_1_fee_enabled,
            instant_exit_tier_2_duration_threshold : arg0.instant_exit_tier_2_duration_threshold,
            instant_exit_tier_2_fee_bps            : arg0.instant_exit_tier_2_fee_bps,
            instant_exit_tier_2_fee_enabled        : arg0.instant_exit_tier_2_fee_enabled,
            instant_exit_tier_3_duration_threshold : arg0.instant_exit_tier_3_duration_threshold,
            instant_exit_tier_3_fee_bps            : arg0.instant_exit_tier_3_fee_bps,
            instant_exit_tier_3_fee_enabled        : arg0.instant_exit_tier_3_fee_enabled,
        }
    }

    public fun closed<T0>(arg0: &Position<T0>) : bool {
        arg0.closed
    }

    public fun collateral_amount<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun compute_delta_size<T0>(arg0: &Position<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: bool) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, arg0.position_amount);
        let (v1, v2) = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v0, &arg0.position_size)) {
            (arg2, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(v0, arg0.position_size))
        } else {
            (!arg2, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(arg0.position_size, v0))
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::from_decimal(v1, v2)
    }

    public fun compute_funding_fee_value<T0>(arg0: &Position<T0>, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::sub(arg1, arg0.last_funding_rate);
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::add(arg0.funding_fee_value, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::from_decimal(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::is_positive(&v0), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg0.position_size, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::value(&v0))))
    }

    public fun compute_reserving_fee_amount<T0>(arg0: &Position<T0>, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg0.reserving_fee_amount, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0x2::balance::value<T0>(&arg0.reserved)), 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::sub(arg1, arg0.last_reserving_rate)))
    }

    public fun config_decrease_fee_bps(arg0: &PositionConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        arg0.decrease_fee_bps
    }

    public fun config_liquidation_bonus(arg0: &PositionConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        arg0.liquidation_bonus
    }

    public fun config_liquidation_threshold(arg0: &PositionConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        arg0.liquidation_threshold
    }

    public fun config_max_leverage(arg0: &PositionConfig) : u64 {
        arg0.max_leverage
    }

    public fun config_max_reserved_multiplier(arg0: &PositionConfig) : u64 {
        arg0.max_reserved_multiplier
    }

    public fun config_min_collateral_value(arg0: &PositionConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        arg0.min_collateral_value
    }

    public fun config_min_holding_duration(arg0: &PositionConfig) : u64 {
        arg0.min_holding_duration
    }

    public fun config_open_fee_bps(arg0: &PositionConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        arg0.open_fee_bps
    }

    public(friend) fun decrease_position<T0>(arg0: &mut Position<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: bool, arg5: u64, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate, arg8: u64) : (u64, 0x1::option::Option<DecreasePositionResult<T0>>) {
        abort 0
    }

    public(friend) fun decrease_position_v1<T0>(arg0: &mut Position<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: bool, arg5: u64, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate, arg8: u64) : DecreasePositionResult<T0> {
        abort 0
    }

    public(friend) fun decrease_position_v2<T0>(arg0: &mut Position<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: bool, arg5: u64, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate, arg8: &PositionInstantExitFeeConfig, arg9: u64) : DecreasePositionResultV2<T0> {
        assert!(!arg0.closed, 1);
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg1);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg3), 15);
        assert!(arg5 > 0 && arg5 <= arg0.position_amount, 6);
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_div_by_64(arg0.position_size, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(arg5), arg0.position_amount);
        let v2 = compute_delta_size<T0>(arg0, arg2, arg4);
        let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::mul_with_u64(v2, arg5), arg0.position_amount);
        let v4 = v2;
        v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::sub(v4, v3);
        assert!(check_holding_duration<T0>(arg0, &v3, arg9), 10);
        let v5 = compute_reserving_fee_amount<T0>(arg0, arg6);
        let v6 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ceil_u64(v5));
        let v7 = compute_funding_fee_value<T0>(arg0, arg7);
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(v1, arg0.config.decrease_fee_bps);
        let (v9, v10) = calculate_instant_exit_fee(v1, arg9 - arg0.open_timestamp, arg8, v3);
        let v11 = v3;
        v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::sub(v11, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::add_with_decimal(v7, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(v8, v6), v9)));
        let v12 = arg5 == arg0.position_amount;
        let v13 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::is_positive(&v3);
        let v14 = if (v13) {
            let v15 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::floor_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::value_to_coins(arg1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::value(&v3)));
            let v16 = v15;
            if (v15 >= 0x2::balance::value<T0>(&arg0.reserved)) {
                v12 = true;
                v16 = 0x2::balance::value<T0>(&arg0.reserved);
            };
            v16
        } else {
            let v17 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ceil_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::value_to_coins(arg1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::value(&v3)));
            let v18 = v17;
            if (v17 >= 0x2::balance::value<T0>(&arg0.collateral)) {
                v12 = true;
                v18 = 0x2::balance::value<T0>(&arg0.collateral);
            };
            v18
        };
        let v19 = if (v12) {
            0x2::balance::value<T0>(&arg0.reserved)
        } else if (v13) {
            v14
        } else {
            0
        };
        let v20 = arg0.position_amount - arg5;
        if (!v12) {
            let v21 = if (v13) {
                0x2::balance::value<T0>(&arg0.collateral)
            } else {
                0x2::balance::value<T0>(&arg0.collateral) - v14
            };
            let v22 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, v21);
            assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v22, &arg0.config.min_collateral_value), 9);
            assert!(check_leverage(&arg0.config, v22, v20, arg2), 11);
            assert!(!check_liquidation(&arg0.config, v22, &v2), 12);
        };
        arg0.closed = v12;
        arg0.position_amount = v20;
        arg0.position_size = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(arg0.position_size, v1);
        arg0.reserving_fee_amount = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero();
        arg0.funding_fee_value = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::zero();
        arg0.last_funding_rate = arg7;
        arg0.last_reserving_rate = arg6;
        let (v23, v24) = if (v13) {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T0>(&mut arg0.reserved, v14))
        } else {
            (0x2::balance::split<T0>(&mut arg0.collateral, v14), 0x2::balance::zero<T0>())
        };
        let v25 = v24;
        let v26 = v23;
        if (v12) {
            0x2::balance::join<T0>(&mut v26, 0x2::balance::withdraw_all<T0>(&mut arg0.reserved));
            0x2::balance::join<T0>(&mut v25, 0x2::balance::withdraw_all<T0>(&mut arg0.collateral));
        };
        DecreasePositionResultV2<T0>{
            closed                    : v12,
            has_profit                : v13,
            settled_amount            : v14,
            decreased_reserved_amount : v19,
            decrease_size             : v1,
            reserving_fee_amount      : v5,
            decrease_fee_value        : v8,
            reserving_fee_value       : v6,
            funding_fee_value         : v7,
            instant_exit_fee_value    : v9,
            instant_exit_fee_tier     : v10,
            to_vault                  : v26,
            to_trader                 : v25,
        }
    }

    public(friend) fun decrease_reserved_from_position<T0>(arg0: &mut Position<T0>, arg1: u64, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate) : 0x2::balance::Balance<T0> {
        assert!(!arg0.closed, 1);
        assert!(arg1 < 0x2::balance::value<T0>(&arg0.reserved), 8);
        arg0.reserving_fee_amount = compute_reserving_fee_amount<T0>(arg0, arg2);
        arg0.last_reserving_rate = arg2;
        0x2::balance::split<T0>(&mut arg0.reserved, arg1)
    }

    public(friend) fun default_position_instant_exit_fee_config() : PositionInstantExitFeeConfig {
        PositionInstantExitFeeConfig{
            instant_exit_tier_1_duration_threshold : 0,
            instant_exit_tier_1_fee_bps            : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero(),
            instant_exit_tier_1_fee_enabled        : false,
            instant_exit_tier_2_duration_threshold : 0,
            instant_exit_tier_2_fee_bps            : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero(),
            instant_exit_tier_2_fee_enabled        : false,
            instant_exit_tier_3_duration_threshold : 0,
            instant_exit_tier_3_fee_bps            : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero(),
            instant_exit_tier_3_fee_enabled        : false,
        }
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
        assert!(v0, 2);
        0x2::balance::destroy_zero<T0>(v9);
        0x2::balance::destroy_zero<T0>(v10);
    }

    public(friend) fun liquidate_position<T0>(arg0: &mut Position<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg3: bool, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate) : (u64, u64, u64, u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(!arg0.closed, 1);
        let v0 = compute_delta_size<T0>(arg0, arg2, arg3);
        let v1 = compute_reserving_fee_amount<T0>(arg0, arg4);
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ceil_u64(v1));
        let v3 = compute_funding_fee_value<T0>(arg0, arg5);
        let v4 = v0;
        v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::sub(v4, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::add_with_decimal(v3, v2));
        assert!(check_liquidation(&arg0.config, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, 0x2::balance::value<T0>(&arg0.collateral)), &v0), 13);
        let v5 = 0x2::balance::value<T0>(&arg0.collateral);
        arg0.closed = true;
        arg0.position_amount = 0;
        arg0.position_size = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero();
        arg0.reserving_fee_amount = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero();
        arg0.funding_fee_value = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::zero();
        arg0.last_funding_rate = arg5;
        arg0.last_reserving_rate = arg4;
        let v6 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::floor_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v5), arg0.config.liquidation_bonus));
        let v7 = 0x2::balance::withdraw_all<T0>(&mut arg0.reserved);
        0x2::balance::join<T0>(&mut v7, 0x2::balance::withdraw_all<T0>(&mut arg0.collateral));
        (v6, v5, arg0.position_amount, 0x2::balance::value<T0>(&arg0.reserved), arg0.position_size, v1, v2, v3, v7, 0x2::balance::split<T0>(&mut arg0.collateral, v6))
    }

    public(friend) fun new_position_config(arg0: u64, arg1: u64, arg2: u64, arg3: u256, arg4: u128, arg5: u128, arg6: u128, arg7: u128) : PositionConfig {
        assert!(arg6 < 1000000000000000000, 16);
        assert!(arg7 < 1000000000000000000, 17);
        PositionConfig{
            max_leverage            : arg0,
            min_holding_duration    : arg1,
            max_reserved_multiplier : arg2,
            min_collateral_value    : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg3),
            open_fee_bps            : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg4),
            decrease_fee_bps        : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg5),
            liquidation_threshold   : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg6),
            liquidation_bonus       : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg7),
        }
    }

    public(friend) fun new_position_instant_exit_fee_config(arg0: u64, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg2: bool, arg3: u64, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg5: bool, arg6: u64, arg7: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg8: bool) : PositionInstantExitFeeConfig {
        PositionInstantExitFeeConfig{
            instant_exit_tier_1_duration_threshold : arg0,
            instant_exit_tier_1_fee_bps            : arg1,
            instant_exit_tier_1_fee_enabled        : arg2,
            instant_exit_tier_2_duration_threshold : arg3,
            instant_exit_tier_2_fee_bps            : arg4,
            instant_exit_tier_2_fee_enabled        : arg5,
            instant_exit_tier_3_duration_threshold : arg6,
            instant_exit_tier_3_fee_bps            : arg7,
            instant_exit_tier_3_fee_enabled        : arg8,
        }
    }

    public(friend) fun open_position<T0>(arg0: &PositionConfig, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T0>, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg6: u64, arg7: u64, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate, arg10: u64) : (u64, 0x1::option::Option<OpenPositionResult<T0>>) {
        abort 0
    }

    public(friend) fun open_position_v1<T0>(arg0: &PositionConfig, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg3: &mut 0x2::balance::Balance<T0>, arg4: &mut 0x2::balance::Balance<T0>, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg6: u64, arg7: u64, arg8: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate, arg10: u64) : OpenPositionResult<T0> {
        assert!(0x2::balance::value<T0>(arg4) > 0, 3);
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::price_of(arg1);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg5), 15);
        assert!(arg6 > 0, 5);
        assert!(0x2::balance::value<T0>(arg4) * arg0.max_reserved_multiplier >= arg7, 14);
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg2, arg6);
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::value_to_coins(arg1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(v1, arg0.open_fee_bps));
        let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ceil_u64(v2);
        assert!(v3 <= 0x2::balance::value<T0>(arg4), 7);
        let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, 0x2::balance::value<T0>(arg4) - v3);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v4, &arg0.min_collateral_value), 9);
        assert!(check_leverage(arg0, v4, arg6, arg2), 11);
        let v5 = Position<T0>{
            closed               : false,
            config               : *arg0,
            open_timestamp       : arg10,
            position_amount      : arg6,
            position_size        : v1,
            reserving_fee_amount : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero(),
            funding_fee_value    : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::zero(),
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
        assert!(!arg0.closed, 1);
        assert!(0x2::balance::value<T0>(&arg1) > 0, 3);
        0x2::balance::join<T0>(&mut arg0.collateral, arg1);
    }

    public fun position_amount<T0>(arg0: &Position<T0>) : u64 {
        arg0.position_amount
    }

    public fun position_config<T0>(arg0: &Position<T0>) : &PositionConfig {
        &arg0.config
    }

    public fun position_size<T0>(arg0: &Position<T0>) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        arg0.position_size
    }

    public(friend) fun redeem_from_position<T0>(arg0: &mut Position<T0>, arg1: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg2: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice, arg3: bool, arg4: u64, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::srate::SRate, arg7: u64) : 0x2::balance::Balance<T0> {
        assert!(!arg0.closed, 1);
        assert!(arg4 > 0 && arg4 < 0x2::balance::value<T0>(&arg0.collateral), 4);
        let v0 = compute_delta_size<T0>(arg0, arg2, arg3);
        assert!(check_holding_duration<T0>(arg0, &v0, arg7), 10);
        let v1 = compute_reserving_fee_amount<T0>(arg0, arg5);
        let v2 = compute_funding_fee_value<T0>(arg0, arg6);
        let v3 = v0;
        v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::sub(v3, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::add_with_decimal(v2, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ceil_u64(v1))));
        arg0.reserving_fee_amount = v1;
        arg0.funding_fee_value = v2;
        arg0.last_reserving_rate = arg5;
        arg0.last_funding_rate = arg6;
        assert!(0x2::balance::value<T0>(&arg0.collateral) * arg0.config.max_reserved_multiplier >= 0x2::balance::value<T0>(&arg0.reserved), 14);
        let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::coins_to_value(arg1, 0x2::balance::value<T0>(&arg0.collateral));
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v4, &arg0.config.min_collateral_value), 9);
        assert!(check_leverage(&arg0.config, v4, arg0.position_amount, arg2), 11);
        assert!(!check_liquidation(&arg0.config, v4, &v0), 12);
        0x2::balance::split<T0>(&mut arg0.collateral, arg4)
    }

    public fun reserved_amount<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserved)
    }

    public(friend) fun set_position_instant_exit_fee_config(arg0: &mut PositionInstantExitFeeConfig, arg1: u64, arg2: bool, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg4: u64, arg5: bool, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg7: u64, arg8: bool, arg9: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate) : PositionInstantExitFeeConfig {
        arg0.instant_exit_tier_1_duration_threshold = arg1;
        arg0.instant_exit_tier_1_fee_bps = arg3;
        arg0.instant_exit_tier_1_fee_enabled = arg2;
        arg0.instant_exit_tier_2_duration_threshold = arg4;
        arg0.instant_exit_tier_2_fee_bps = arg6;
        arg0.instant_exit_tier_2_fee_enabled = arg5;
        arg0.instant_exit_tier_3_duration_threshold = arg7;
        arg0.instant_exit_tier_3_fee_bps = arg9;
        arg0.instant_exit_tier_3_fee_enabled = arg8;
        *arg0
    }

    public(friend) fun unwrap_decrease_position_result<T0>(arg0: DecreasePositionResult<T0>) : (bool, bool, u64, u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        abort 0
    }

    public(friend) fun unwrap_decrease_position_result_v2<T0>(arg0: DecreasePositionResultV2<T0>) : (bool, bool, u64, u64, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::sdecimal::SDecimal, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, u8, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        let DecreasePositionResultV2 {
            closed                    : v0,
            has_profit                : v1,
            settled_amount            : v2,
            decreased_reserved_amount : v3,
            decrease_size             : v4,
            reserving_fee_amount      : v5,
            decrease_fee_value        : v6,
            reserving_fee_value       : v7,
            funding_fee_value         : v8,
            instant_exit_fee_value    : v9,
            instant_exit_fee_tier     : v10,
            to_vault                  : v11,
            to_trader                 : v12,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    public(friend) fun unwrap_open_position_result<T0>(arg0: OpenPositionResult<T0>) : (Position<T0>, 0x2::balance::Balance<T0>, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) {
        let OpenPositionResult {
            position        : v0,
            open_fee        : v1,
            open_fee_amount : v2,
        } = arg0;
        (v0, v1, v2)
    }

    // decompiled from Move bytecode v6
}

