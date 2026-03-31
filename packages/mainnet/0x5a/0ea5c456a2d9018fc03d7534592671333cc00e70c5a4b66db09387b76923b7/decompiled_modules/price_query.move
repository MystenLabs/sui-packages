module 0x5a0ea5c456a2d9018fc03d7534592671333cc00e70c5a4b66db09387b76923b7::price_query {
    public fun get_price_u64<T0>(arg0: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::last_updated(v2), 1);
        0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

