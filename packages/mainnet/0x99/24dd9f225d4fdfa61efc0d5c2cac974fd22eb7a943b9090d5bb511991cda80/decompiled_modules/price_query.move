module 0x9924dd9f225d4fdfa61efc0d5c2cac974fd22eb7a943b9090d5bb511991cda80::price_query {
    public fun get_price_u64<T0>(arg0: &0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::last_updated(v2), 1);
        0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

