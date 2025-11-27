module 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::price {
    public fun get_price(arg0: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::PriceFeed>(v0, arg1), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::last_updated(v1), 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xaeae1f6d55b5c254c5e7f4cdc6fb86a9df1651af5905ab3ba289f10bed6ee1b2::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

