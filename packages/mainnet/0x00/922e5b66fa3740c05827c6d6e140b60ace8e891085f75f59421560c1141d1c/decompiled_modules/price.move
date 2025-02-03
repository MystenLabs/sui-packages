module 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::price {
    public fun get_price(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::last_updated(v1), 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x922e5b66fa3740c05827c6d6e140b60ace8e891085f75f59421560c1141d1c::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

