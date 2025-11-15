module 0x6af6376d92de49c1dbea23c080afd76214ddb60881e46a71e8b2f81a04064f3d::price_query {
    public fun get_price_u64<T0>(arg0: &0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::price_feed::last_updated(v2), 1);
        0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

