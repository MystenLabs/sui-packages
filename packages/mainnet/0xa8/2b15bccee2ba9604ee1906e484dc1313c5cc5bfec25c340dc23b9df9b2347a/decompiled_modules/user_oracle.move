module 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::user_oracle {
    fun check_price(arg0: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal {
        let v0 = 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::value(arg0);
        assert!(v0 > 0, 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::update_time(arg0) * 1000 <= arg1, 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::oracle_error::oracle_stale_price_error());
        0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::from_quotient(v0, 0x1::u64::pow(10, 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::decimals()))
    }

    public fun get_price(arg0: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal {
        0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::ensure_version_matches(arg0);
        check_price(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::ema(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price(arg0, arg1, arg2)), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal) : 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal {
        0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::ema(v0), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::spot(v0), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::gt(v1, v2)) {
            0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::div(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::sub(v1, v2), v2)
        } else {
            0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::div(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::sub(v2, v1), v2)
        };
        assert!(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::le(v3, arg4), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal {
        0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::ensure_version_matches(arg0);
        check_price(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::spot(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price(arg0, arg1, arg2)), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_spot_price_with_check(arg0: &0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal) : 0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::Decimal {
        0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::ema(v0), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::price_feed::spot(v0), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::gt(v1, v2)) {
            0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::div(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::sub(v1, v2), v1)
        } else {
            0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::div(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::sub(v2, v1), v1)
        };
        assert!(0xa8238dcaf33f70aa16f605d4744ffa049607b2a58a6a7fc728beb2ab346ce2af::float::le(v3, arg4), 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::oracle_error::ema_spot_price_too_different());
        v2
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::ensure_version_matches(arg0);
        0xa82b15bccee2ba9604ee1906e484dc1313c5cc5bfec25c340dc23b9df9b2347a::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

