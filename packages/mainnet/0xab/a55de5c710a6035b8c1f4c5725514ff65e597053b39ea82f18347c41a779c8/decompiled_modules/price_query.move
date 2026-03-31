module 0xaba55de5c710a6035b8c1f4c5725514ff65e597053b39ea82f18347c41a779c8::price_query {
    public fun get_price_u64<T0>(arg0: &0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::last_updated(v2), 1);
        0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

