module 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::oracles {
    struct PythPriceAndConfidencePro has copy, drop {
        spot_price: 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>,
        ema_price: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        conf: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal,
        price_identifier_bytes: vector<u8>,
    }

    public fun conf_pro(arg0: &PythPriceAndConfidencePro) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.conf
    }

    public fun ema_price_pro(arg0: &PythPriceAndConfidencePro) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        arg0.ema_price
    }

    public fun get_pyth_price_and_identifier(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : (0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier) {
        abort 100
    }

    public fun get_pyth_price_and_identifier_pro_compatible(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : (0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, vector<u8>) {
        let v0 = get_pyth_price_pro_compatible(arg0, arg1);
        (spot_price_pro(&v0), ema_price_pro(&v0), price_identifier_bytes(&v0))
    }

    public(friend) fun get_pyth_price_for_config(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::ReserveConfig) : PythPriceAndConfidencePro {
        get_pyth_price_with_thresholds(arg0, arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::min_confidence_ratio(arg2), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::max_staleness_seconds(arg2))
    }

    public fun get_pyth_price_pro_compatible(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x2::clock::Clock) : PythPriceAndConfidencePro {
        get_pyth_price_with_thresholds(arg0, arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::default_min_confidence_ratio(), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve_config::default_max_staleness_seconds())
    }

    fun get_pyth_price_with_thresholds(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64) : PythPriceAndConfidencePro {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price_identifier(v1);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_ema_price(v1);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(v1);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v4);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v4);
        if ((v6 as u128) * (arg2 as u128) > (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5) as u128)) {
            return PythPriceAndConfidencePro{
                spot_price             : 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(),
                ema_price              : parse_price_to_decimal_pro_compatible(v3),
                conf                   : scale_by_expo_pro_compatible(v6, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v4)),
                price_identifier_bytes : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2),
            }
        };
        let v7 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (!timestamp_within_tolerance(v7, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v4), arg3) || !timestamp_not_forward_dated(v7, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v3))) {
            return PythPriceAndConfidencePro{
                spot_price             : 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(),
                ema_price              : parse_price_to_decimal_pro_compatible(v3),
                conf                   : scale_by_expo_pro_compatible(v6, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v4)),
                price_identifier_bytes : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2),
            }
        };
        let v8 = parse_price_to_decimal_pro_compatible(v4);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(v8, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0))) {
            return PythPriceAndConfidencePro{
                spot_price             : 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(),
                ema_price              : parse_price_to_decimal_pro_compatible(v3),
                conf                   : scale_by_expo_pro_compatible(v6, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v4)),
                price_identifier_bytes : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2),
            }
        };
        PythPriceAndConfidencePro{
            spot_price             : 0x1::option::some<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal>(v8),
            ema_price              : parse_price_to_decimal_pro_compatible(v3),
            conf                   : scale_by_expo_pro_compatible(v6, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v4)),
            price_identifier_bytes : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2),
        }
    }

    fun parse_price_to_decimal_pro_compatible(arg0: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&arg0);
        scale_by_expo_pro_compatible(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v0), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&arg0))
    }

    public fun price_identifier_bytes(arg0: &PythPriceAndConfidencePro) : vector<u8> {
        arg0.price_identifier_bytes
    }

    fun scale_by_expo_pro_compatible(arg0: u64, arg1: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&arg1)) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg1) as u8))))
        } else {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(0x1::u64::pow(10, (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&arg1) as u8))))
        }
    }

    public fun spot_price_pro(arg0: &PythPriceAndConfidencePro) : 0x1::option::Option<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal> {
        arg0.spot_price
    }

    public(friend) fun timestamp_not_forward_dated(arg0: u64, arg1: u64) : bool {
        arg1 <= arg0 + 60
    }

    public(friend) fun timestamp_within_tolerance(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = arg0 > arg1 && arg0 - arg1 > arg2;
        !v0 && arg1 <= arg0 + 60
    }

    // decompiled from Move bytecode v7
}

