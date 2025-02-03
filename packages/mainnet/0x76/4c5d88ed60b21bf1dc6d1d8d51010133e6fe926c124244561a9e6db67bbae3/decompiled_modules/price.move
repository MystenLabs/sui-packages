module 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::price {
    public fun get_price(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::last_updated(v1), 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x6c23585e940a989588432509107e98bae06dbca4e333f26d0635d401b3c7c76d::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

