module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price {
    public fun get_price(arg0: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::PriceFeed>(v0, arg1), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::last_updated(v1), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

