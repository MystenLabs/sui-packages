module 0xd908ee1eb4d764cfcedcbb0025d8042fd2b9d65cb1797f1e902c8984d5c924d1::price_query {
    public fun get_price_u64<T0>(arg0: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::last_updated(v2), 1);
        0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

