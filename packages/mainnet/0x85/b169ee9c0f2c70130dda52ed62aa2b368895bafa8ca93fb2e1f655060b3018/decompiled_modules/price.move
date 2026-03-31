module 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::price {
    public fun get_price(arg0: &0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::PriceFeed>(v0, arg1), 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::last_updated(v1), 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

