module 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::price {
    public fun get_price(arg0: &0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::PriceFeed>(v0, arg1), 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::last_updated(v1), 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x5689c2dec9f0434ac283ee9f5fc84f6889a83caedd3507d2ba14b4d1a57117a2::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

