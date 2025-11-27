module 0x3c9e81100208a4008ccb9e72ddf52f5f16e8945471d6327470cdda54f8a240b::price_query {
    public fun get_price_u64<T0>(arg0: &0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::last_updated(v2), 1);
        0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

