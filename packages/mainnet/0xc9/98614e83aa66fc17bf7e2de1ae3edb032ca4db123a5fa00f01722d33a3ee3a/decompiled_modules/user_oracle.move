module 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::user_oracle {
    fun check_price(arg0: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::PriceFeedComponent, arg1: u64, arg2: &0x2::clock::Clock) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        let v0 = 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::value(arg0);
        assert!(v0 > 0, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::oracle_error::oracle_zero_price_error());
        assert!(0x2::clock::timestamp_ms(arg2) - 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::update_time(arg0) * 1000 <= arg1, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::oracle_error::oracle_stale_price_error());
        0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::from_quotient(v0, 0x1::u64::pow(10, 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::decimals()))
    }

    public fun get_price(arg0: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        check_price(0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::ema(0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::price(arg0, arg1, arg2)), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun get_price_with_check(arg0: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::BaseToken, arg3: &0x2::clock::Clock, arg4: 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        let v0 = 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::price(arg0, arg1, arg2);
        let v1 = check_price(0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::ema(v0), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v2 = check_price(0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::spot(v0), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::price_delay_tolerance_ms(arg0), arg3);
        let v3 = if (0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::gt(v1, v2)) {
            0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::div(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::sub(v1, v2), v2)
        } else {
            0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::div(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::sub(v2, v1), v2)
        };
        assert!(0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::lt(v3, arg4), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::oracle_error::ema_spot_price_too_different());
        v1
    }

    public fun get_spot_price(arg0: &0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x4bc9fe7e053de46aa9789fdcb1ad031389cf4f710cde859ab40c7e9cc2dee7c3::float::Decimal {
        check_price(0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::price_feed::spot(0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::price(arg0, arg1, arg2)), 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::price_delay_tolerance_ms(arg0), arg3)
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        0x117990857c81164f62e7b620657e8a0349430259c8adbd844371f9b6df297cc9::x_oracle::refresh_usd_price<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

