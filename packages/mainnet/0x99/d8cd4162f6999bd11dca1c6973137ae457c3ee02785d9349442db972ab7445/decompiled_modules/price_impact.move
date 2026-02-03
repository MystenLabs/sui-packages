module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::price_impact {
    struct PriceImpactConfig has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        base_spread_rate: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        max_dynamic_spread_rate: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        max_total_spread_rate: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate,
        impact_exponent: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        max_oi_long: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        max_oi_short: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        reference_size: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
    }

    struct PriceImpactConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun apply_price_impact(arg0: &0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPriceConfig, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg3: bool, arg4: bool) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::AggPrice {
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::is_zero(&arg2)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(arg0, arg1)
        };
        let v0 = arg3 && arg4 || !arg3 && !arg4;
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(arg1, arg2);
        let v2 = if (v0) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg1, v1)
        } else if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v1, &arg1)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero()
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(arg1, v1)
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price::from_price(arg0, v2)
    }

    public fun base_spread_rate(arg0: &PriceImpactConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        arg0.base_spread_rate
    }

    public fun compute_average_spread_rate(arg0: &PriceImpactConfig, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        if (!arg0.enabled) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::is_zero(&arg4)) {
            return arg0.base_spread_rate
        };
        let v0 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::is_zero(&arg5)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero()
        } else if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&arg3, &arg5)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(arg3, arg5)
        };
        let v1 = v0;
        let v2 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&arg1, &arg4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(arg1, arg4)
        };
        let v3 = v2;
        let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg1, arg2);
        let v5 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v4, &arg4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(v4, arg4)
        };
        let v6 = v5;
        let v7 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &v3)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero()
        } else {
            let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(v3, v1);
            let v9 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one();
            if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v8, &v9)) {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
            } else {
                v8
            }
        };
        let v10 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &v6)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero()
        } else {
            let v11 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(v6, v1);
            let v12 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one();
            if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v11, &v12)) {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
            } else {
                v11
            }
        };
        let v13 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::add(arg0.base_spread_rate, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(compute_size_factor(arg2, arg0.reference_size), compute_integral_average(arg0.max_dynamic_spread_rate, v7, v10, arg0.impact_exponent))));
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::gt(&v13, &arg0.max_total_spread_rate)) {
            arg0.max_total_spread_rate
        } else {
            v13
        }
    }

    fun compute_integral_average(arg0: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::eq(&arg1, &arg2)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::pow_frac(arg1, arg3), arg0))
        };
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg3, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one());
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::pow_frac(arg2, v0);
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::pow_frac(arg1, v0);
        let v3 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v1, &v2)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(v1, v2)
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(v2, v1)
        };
        let v4 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&arg2, &arg1)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(arg2, arg1)
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(arg1, arg2)
        };
        let v5 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul(v0, v4);
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::is_zero(&v5)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(v3, v5), arg0))
    }

    fun compute_size_factor(arg0: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::is_zero(&arg1)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
        };
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(arg0, arg1);
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one();
        let v2 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v0, &v1)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
        } else {
            v0
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one(), v2)
    }

    public fun compute_spread_rate(arg0: &PriceImpactConfig, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg2: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg3: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        if (!arg0.enabled) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::is_zero(&arg4)) {
            return arg0.base_spread_rate
        };
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(arg1, arg2);
        let v1 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v0, &arg4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(v0, arg4)
        };
        let v2 = v1;
        let v3 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::is_zero(&arg5)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero()
        } else if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&arg3, &arg5)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(arg3, arg5)
        };
        let v4 = v3;
        let v5 = if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::ge(&v4, &v2)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::zero()
        } else {
            let v6 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(v2, v4);
            let v7 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one();
            if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v6, &v7)) {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::one()
            } else {
                v6
            }
        };
        let v8 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::add(arg0.base_spread_rate, 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::to_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_rate(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::pow_frac(v5, arg0.impact_exponent), arg0.max_dynamic_spread_rate)));
        if (0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::gt(&v8, &arg0.max_total_spread_rate)) {
            arg0.max_total_spread_rate
        } else {
            v8
        }
    }

    public fun impact_exponent(arg0: &PriceImpactConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        arg0.impact_exponent
    }

    public fun is_enabled(arg0: &PriceImpactConfig) : bool {
        arg0.enabled
    }

    public fun max_dynamic_spread_rate(arg0: &PriceImpactConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        arg0.max_dynamic_spread_rate
    }

    public fun max_oi_long(arg0: &PriceImpactConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        arg0.max_oi_long
    }

    public fun max_oi_short(arg0: &PriceImpactConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        arg0.max_oi_short
    }

    public fun max_total_spread_rate(arg0: &PriceImpactConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        arg0.max_total_spread_rate
    }

    public fun new_config_key<T0>() : PriceImpactConfigKey<T0> {
        PriceImpactConfigKey<T0>{dummy_field: false}
    }

    public fun new_price_impact_config(arg0: &mut 0x2::tx_context::TxContext, arg1: bool, arg2: u128, arg3: u128, arg4: u128, arg5: u256, arg6: u256, arg7: u256, arg8: u256) : PriceImpactConfig {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg2);
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg4);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::ge(&v1, &v0), 602);
        assert!(arg4 <= 100000000000000000, 604);
        assert!(arg5 >= 1000000000000000000 && arg5 <= 3000000000000000000, 603);
        PriceImpactConfig{
            id                      : 0x2::object::new(arg0),
            enabled                 : arg1,
            base_spread_rate        : v0,
            max_dynamic_spread_rate : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg3),
            max_total_spread_rate   : v1,
            impact_exponent         : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg5),
            max_oi_long             : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg6),
            max_oi_short            : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg7),
            reference_size          : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg8),
        }
    }

    public fun reference_size(arg0: &PriceImpactConfig) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        arg0.reference_size
    }

    public(friend) fun set_enabled(arg0: &mut PriceImpactConfig, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun update_config(arg0: &mut PriceImpactConfig, arg1: u128, arg2: u128, arg3: u128, arg4: u256, arg5: u256, arg6: u256, arg7: u256) {
        let v0 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg1);
        let v1 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg3);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::ge(&v1, &v0), 602);
        assert!(arg3 <= 100000000000000000, 604);
        assert!(arg4 >= 1000000000000000000 && arg4 <= 3000000000000000000, 603);
        arg0.base_spread_rate = v0;
        arg0.max_dynamic_spread_rate = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw(arg2);
        arg0.max_total_spread_rate = v1;
        arg0.impact_exponent = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg4);
        arg0.max_oi_long = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg5);
        arg0.max_oi_short = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg6);
        arg0.reference_size = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_raw(arg7);
    }

    // decompiled from Move bytecode v6
}

