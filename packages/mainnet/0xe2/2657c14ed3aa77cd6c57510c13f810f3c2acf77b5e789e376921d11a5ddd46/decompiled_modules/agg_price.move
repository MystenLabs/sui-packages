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

    struct RRFeederConfig has copy, drop, store {
        rr_feeder_id: 0x2::object::ID,
        sui_feeder_id: 0x2::object::ID,
        max_rr_confidence: u64,
        max_sui_confidence: u64,
    }

    struct RRPythProConfig has copy, drop, store {
        max_rr_confidence: u64,
        max_sui_confidence: u64,
    }

    struct VaultRr<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun coins_to_value(arg0: &AggPrice, arg1: u64) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal {
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(arg0.price, arg1), arg0.precision)
    }

    public fun compute_confidence_rate(arg0: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        let v0 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::price(arg0);
        if (v0 == 0) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw((0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::conf(arg0) as u128) * 1000000000000000000 / v0)
    }

    fun compute_ema_divergence_rate_from_lazer_feed(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        let v0 = flatten_lazer_option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(arg0));
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        let v1 = flatten_lazer_option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_price(arg0));
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v1)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        let v2 = *0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0);
        let v3 = *0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v1);
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v2) || 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v3)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        let v4 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v2);
        let v5 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v3);
        if (v4 == 0 || v5 == 0) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        let v6 = if (v4 > v5) {
            v4 - v5
        } else {
            v5 - v4
        };
        0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::from_raw((v6 as u128) * 1000000000000000000 / (v5 as u128))
    }

    public fun compute_ema_divergence_rate_from_pyth_pro_update<T0>(arg0: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::OracleRegistry, arg1: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::check_version(arg0);
        if (!0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::has_pyth_pro_config<T0>(arg0)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        let v0 = find_lazer_feed(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds_ref(arg1), 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::pyth_pro_config_feed_id<T0>(0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::get_pyth_pro_config<T0>(arg0)));
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v0)) {
            return 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::zero()
        };
        compute_ema_divergence_rate_from_lazer_feed(0x1::option::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v0))
    }

    public fun compute_ema_divergence_rate_v1(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::rate::Rate {
        abort 0
    }

    fun find_lazer_feed(arg0: &vector<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>, arg1: u32) : 0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(arg0)) {
            let v1 = 0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(arg0, v0);
            if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(v1) == arg1) {
                return 0x1::option::some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(*v1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>()
    }

    fun flatten_lazer_option<T0: copy + drop>(arg0: 0x1::option::Option<0x1::option::Option<T0>>) : 0x1::option::Option<T0> {
        if (0x1::option::is_none<0x1::option::Option<T0>>(&arg0)) {
            return 0x1::option::none<T0>()
        };
        *0x1::option::borrow<0x1::option::Option<T0>>(&arg0)
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

    public(friend) fun new_rr_pyth_pro_config(arg0: u64, arg1: u64) : RRPythProConfig {
        RRPythProConfig{
            max_rr_confidence  : arg0,
            max_sui_confidence : arg1,
        }
    }

    public fun normalized_price_timestamp(arg0: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice) : u64 {
        0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::publish_time(arg0)
    }

    public fun parse_pyth_feeder(arg0: &AggPriceConfig, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: u64) : AggPrice {
        abort 0
    }

    public fun parse_pyth_feeder_v1_1(arg0: &AggPriceConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64) : AggPrice {
        abort 0
    }

    public fun parse_pyth_feeder_with_trading_price_config_v1_1(arg0: &AggPriceConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::Decimal, arg7: bool) : AggPrice {
        abort 0
    }

    public fun parse_rr_from_normalized_prices(arg0: &AggPriceConfig, arg1: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice, arg2: &RRPythProConfig, arg3: &0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::NormalizedPrice) : AggPrice {
        let v0 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::price(arg1);
        assert!(v0 > 0, 4);
        assert!(0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::conf(arg1) <= arg2.max_rr_confidence, 3);
        let v1 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::price(arg3);
        assert!(v1 > 0, 4);
        assert!(0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::conf(arg3) <= arg2.max_sui_confidence, 3);
        let v2 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::expo(arg1);
        let v3 = if (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_is_negative(&v2)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_negative(&v2) as u8)))
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v0), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_positive(&v2) as u8)))
        };
        let v4 = 0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::core::expo(arg3);
        let v5 = if (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_is_negative(&v4)) {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::div_by_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v1), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_negative(&v4) as u8)))
        } else {
            0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul_with_u64(0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::from_u128(v1), 0x1::u64::pow(10, (0x460fe6da5e82b6633a57cbb17bb09e61252d2db836f133f9188b2835f9d2824::zo_i64::get_magnitude_if_positive(&v4) as u8)))
        };
        AggPrice{
            price     : 0xc44d97a4bc4e5a33ca847b72b123172c88a6328196b71414f32c3070233604b2::decimal::mul(v3, v5),
            precision : arg0.precision,
        }
    }

    public fun parse_rr_pyth_feeder_v1_1(arg0: &AggPriceConfig, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &RRFeederConfig, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: u64) : AggPrice {
        abort 0
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

    // decompiled from Move bytecode v7
}

