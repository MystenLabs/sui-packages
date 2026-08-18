module 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::pyth {
    public(friend) fun from_pyth_price(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v2 = if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v3)
        } else {
            let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4)
        };
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v6 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::new((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0) as u128), v2, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5));
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v6) > 0, 3);
        v6
    }

    fun from_pyth_price_pro_compatible(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(arg0);
        let v2 = if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v0)) {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v0)
        } else {
            0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v0)
        };
        let v3 = 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::new((0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v1) as u128), v2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v0));
        assert!(0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::base(&v3) > 0, 3);
        v3
    }

    public(friend) fun get_prices(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier) : (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::PriceFeed) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price_identifier(v1) == arg4, 2);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_price(v1);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v3) as u128) * 100 <= (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4) as u128) * (arg3 as u128), 0);
        let v5 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v5 > 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3) && v5 - 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3) > arg2) {
            abort 1
        };
        (from_pyth_price(&v3), from_pyth_price(&v2), *v1)
    }

    public(friend) fun get_prices_pro_compatible(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier) : (0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal, 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracle_decimal::OracleDecimal, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::PriceFeed) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price_identifier(v1);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v2) == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&arg4), 2);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_ema_price(v1);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(v1);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v4);
        assert!((0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v4) as u128) * 100 <= (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5) as u128) * (arg3 as u128), 0);
        let v6 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v6 > 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v4) && v6 - 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v4) > arg2) {
            abort 1
        };
        (from_pyth_price_pro_compatible(&v4), from_pyth_price_pro_compatible(&v3), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::new(arg4, to_legacy_price(&v4), to_legacy_price(&v3)))
    }

    fun to_legacy_i64(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64 {
        if (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(arg0)) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(arg0), true)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::new(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(arg0), false)
        }
    }

    fun to_legacy_price(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(arg0);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::new(to_legacy_i64(&v0), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(arg0), to_legacy_i64(&v1), 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(arg0))
    }

    // decompiled from Move bytecode v7
}

