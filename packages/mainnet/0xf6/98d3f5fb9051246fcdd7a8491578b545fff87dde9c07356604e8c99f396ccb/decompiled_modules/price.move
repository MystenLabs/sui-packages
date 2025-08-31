module 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price {
    public fun get_price(arg0: &0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price_feed::PriceFeed>(v0, arg1), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price_feed::last_updated(v1), 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0xf698d3f5fb9051246fcdd7a8491578b545fff87dde9c07356604e8c99f396ccb::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

