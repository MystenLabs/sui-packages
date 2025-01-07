module 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::agg_price {
    struct AggPrice has drop, store {
        price: 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::Decimal,
        precision: u64,
    }

    struct AggPriceConfig has store {
        max_interval: u64,
        max_confidence: u64,
        precision: u64,
        feeder: 0x2::object::ID,
    }

    public fun coins_to_value(arg0: &AggPrice, arg1: u64) : 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::Decimal {
        0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::div_by_u64(0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::mul_with_u64(arg0.price, arg1), arg0.precision)
    }

    public fun from_price(arg0: &AggPriceConfig, arg1: 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::Decimal) : AggPrice {
        AggPrice{
            price     : arg1,
            precision : arg0.precision,
        }
    }

    public(friend) fun new_agg_price_config<T0>(arg0: u64, arg1: u64, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject) : AggPriceConfig {
        AggPriceConfig{
            max_interval   : arg0,
            max_confidence : arg1,
            precision      : 0x2::math::pow(10, 0x2::coin::get_decimals<T0>(arg2)),
            feeder         : 0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg3),
        }
    }

    public fun parse_pyth_feeder(arg0: &AggPriceConfig, arg1: &0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject, arg2: u64) : AggPrice {
        assert!(0x2::object::id<0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price_info::PriceInfoObject>(arg1) == arg0.feeder, 1);
        let v0 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::pyth::get_price_unsafe(arg1);
        assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_timestamp(&v0) + arg0.max_interval >= arg2, 2);
        assert!(0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_conf(&v0) <= arg0.max_confidence, 3);
        let v1 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_price(&v0);
        let v2 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v1);
        assert!(v2 > 0, 4);
        let v3 = 0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::price::get_expo(&v0);
        let v4 = if (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_is_negative(&v3)) {
            0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::div_by_u64(0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::from_u64(v2), 0x2::math::pow(10, (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_negative(&v3) as u8)))
        } else {
            0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::mul_with_u64(0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::from_u64(v2), 0x2::math::pow(10, (0xb53b0f4174108627fbee72e2498b58d6a2714cded53fac537034c220d26302::i64::get_magnitude_if_positive(&v3) as u8)))
        };
        AggPrice{
            price     : v4,
            precision : arg0.precision,
        }
    }

    public fun precision_of(arg0: &AggPrice) : u64 {
        arg0.precision
    }

    public fun price_of(arg0: &AggPrice) : 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::Decimal {
        arg0.price
    }

    public fun value_to_coins(arg0: &AggPrice, arg1: 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::Decimal) : 0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::Decimal {
        0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::div(0xe2fd773a854bad2dc061d5ae4bd06cfc88482cdbbd80224f2a97b27418bef734::decimal::mul_with_u64(arg1, arg0.precision), arg0.price)
    }

    // decompiled from Move bytecode v6
}

