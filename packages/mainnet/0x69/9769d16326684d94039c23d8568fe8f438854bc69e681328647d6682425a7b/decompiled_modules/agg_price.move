module 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::agg_price {
    struct AggPrice has drop, store {
        price: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal,
        precision: u64,
    }

    struct AggPriceConfig has store {
        max_interval: u64,
        max_confidence: u64,
        precision: u64,
        feeder: 0x2::object::ID,
    }

    public fun coins_to_value(arg0: &AggPrice, arg1: u64) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(arg0.price, arg1), arg0.precision)
    }

    public fun from_normalized_price(arg0: &AggPriceConfig, arg1: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice) : AggPrice {
        let v0 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::price(arg1);
        assert!(v0 > 0, 4);
        assert!(0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::conf(arg1) <= arg0.max_confidence, 3);
        let v1 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::expo(arg1);
        let v2 = if (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_is_negative(&v1)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_negative(&v1) as u8)))
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_positive(&v1) as u8)))
        };
        AggPrice{
            price     : v2,
            precision : arg0.precision,
        }
    }

    public fun from_normalized_price_with_trading_price_config(arg0: &AggPriceConfig, arg1: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice, arg2: u64, arg3: bool, arg4: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg5: bool) : AggPrice {
        let v0 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::price(arg1);
        let v1 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::conf(arg1);
        assert!(v0 > 0, 4);
        assert!(v1 <= arg2, 3);
        let v2 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v1), arg4);
        let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v3, &v2), 5);
        let v4 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::expo(arg1);
        let v5 = if (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_is_negative(&v4)) {
            if (arg3) {
                if (arg5) {
                    0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), v2), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_negative(&v4) as u8)))
                } else {
                    0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), v2), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_negative(&v4) as u8)))
                }
            } else {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_negative(&v4) as u8)))
            }
        } else if (arg3) {
            if (arg5) {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), v2), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_positive(&v4) as u8)))
            } else {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), v2), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_positive(&v4) as u8)))
            }
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_positive(&v4) as u8)))
        };
        AggPrice{
            price     : v5,
            precision : arg0.precision,
        }
    }

    public fun from_price(arg0: &AggPriceConfig, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) : AggPrice {
        AggPrice{
            price     : arg1,
            precision : arg0.precision,
        }
    }

    fun get_abs_diff(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            return arg0 - arg1
        };
        arg1 - arg0
    }

    public fun max_confidence_of(arg0: &AggPriceConfig) : u64 {
        arg0.max_confidence
    }

    public fun max_interval_of(arg0: &AggPriceConfig) : u64 {
        arg0.max_interval
    }

    public(friend) fun new_agg_price_config<T0>(arg0: u64, arg1: u64, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : AggPriceConfig {
        abort 0
    }

    public(friend) fun new_agg_price_config_from_currency<T0>(arg0: u64, arg1: u64, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : AggPriceConfig {
        abort 0
    }

    public(friend) fun new_agg_price_config_v1_1<T0>(arg0: u64, arg1: u64, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : AggPriceConfig {
        AggPriceConfig{
            max_interval   : arg0,
            max_confidence : arg1,
            precision      : 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg2)),
            feeder         : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3),
        }
    }

    public(friend) fun new_agg_price_config_v1_1_from_currency<T0>(arg0: u64, arg1: u64, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : AggPriceConfig {
        AggPriceConfig{
            max_interval   : arg0,
            max_confidence : arg1,
            precision      : 0x1::u64::pow(10, 0x2::coin_registry::decimals<T0>(arg2)),
            feeder         : 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg3),
        }
    }

    public fun parse_pyth_feeder(arg0: &AggPriceConfig, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: u64) : AggPrice {
        abort 0
    }

    public fun parse_pyth_feeder_v1_1(arg0: &AggPriceConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64) : AggPrice {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == arg0.feeder, 1);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg1);
        assert!(get_abs_diff(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0), arg2) <= arg0.max_interval, 2);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) <= arg0.max_confidence, 3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        assert!(v2 > 0, 4);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v3)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), 0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3) as u8)))
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), 0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3) as u8)))
        };
        AggPrice{
            price     : v4,
            precision : arg0.precision,
        }
    }

    public fun parse_pyth_feeder_with_trading_price_config_v1_1(arg0: &AggPriceConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg7: bool) : AggPrice {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1) == arg0.feeder, 1);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_unsafe(arg1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0) + arg3 >= arg2, 2);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) <= arg4, 3);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        assert!(v2 > 0, 4);
        let v3 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0)), arg6);
        let v4 = 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2);
        assert!(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::gt(&v4, &v3), 5);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v6 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5)) {
            if (arg5) {
                if (arg7) {
                    0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), v3), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5) as u8)))
                } else {
                    0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), v3), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5) as u8)))
                }
            } else {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5) as u8)))
            }
        } else if (arg5) {
            if (arg7) {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::sub(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), v3), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u8)))
            } else {
                0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::add(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), v3), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u8)))
            }
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u64(v2), 0x1::u64::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5) as u8)))
        };
        AggPrice{
            price     : v6,
            precision : arg0.precision,
        }
    }

    public fun precision_of(arg0: &AggPrice) : u64 {
        arg0.precision
    }

    public fun price_of(arg0: &AggPrice) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        arg0.price
    }

    public(friend) fun update_agg_price_config_feeder(arg0: &mut AggPriceConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        arg0.feeder = 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1);
    }

    public(friend) fun use_price_config(arg0: AggPriceConfig) {
        let AggPriceConfig {
            max_interval   : _,
            max_confidence : _,
            precision      : _,
            feeder         : _,
        } = arg0;
    }

    public fun value_to_coins(arg0: &AggPrice, arg1: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(arg1, arg0.precision), arg0.price)
    }

    // decompiled from Move bytecode v6
}

