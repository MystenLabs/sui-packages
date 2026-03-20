module 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::user_oracle {
    fun check_price(arg0: &0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        let v0 = 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::value(arg0);
        assert!(v0 > 0, 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::update_time(arg0) * 1000 <= arg1, 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::oracle_error::oracle_stale_price_error());
        0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::from_quotient(v0, 0x1::u64::pow(10, 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::decimals()))
    }

    public fun get_price(arg0: &0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::ensure_version_matches(arg0);
        check_price(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::ema(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price(arg0, arg1, arg2)), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::ema(v0), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::spot(v0), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::gt(v1, v2)) {
            0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(v1, v2), v2)
        } else {
            0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(v2, v1), v2)
        };
        assert!(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::le(v3, arg4), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::ensure_version_matches(arg0);
        check_price(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::spot(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price(arg0, arg1, arg2)), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_spot_price_with_check(arg0: &0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal) : 0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::Decimal {
        0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::ensure_version_matches(arg0);
        let v0 = 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::ema(v0), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::price_feed::spot(v0), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::gt(v1, v2)) {
            0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(v1, v2), v1)
        } else {
            0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::div(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::sub(v2, v1), v1)
        };
        assert!(0x7d779e7ae65c4d9e296e77a6bc3e80c0d364a98a4314f75acc3f47d676db939a::float::le(v3, arg4), 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::oracle_error::ema_spot_price_too_different());
        v2
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::ensure_version_matches(arg0);
        0xae5df8173703019e2b2d9e5688a08bd28e092ac2dc0bfbad33f390a9b3646be0::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

