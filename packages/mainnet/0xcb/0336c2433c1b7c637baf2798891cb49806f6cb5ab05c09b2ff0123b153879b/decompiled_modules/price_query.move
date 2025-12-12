module 0x6ec504612a4bf9d6715d1dfa59b64ebb2689bf0ad6226a1d998bf75f79330413::price_query {
    public fun get_price_u64<T0>(arg0: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::last_updated(v2), 1);
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

