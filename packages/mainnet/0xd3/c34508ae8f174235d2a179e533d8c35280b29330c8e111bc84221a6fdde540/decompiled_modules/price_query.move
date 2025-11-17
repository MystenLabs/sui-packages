module 0xd3c34508ae8f174235d2a179e533d8c35280b29330c8e111bc84221a6fdde540::price_query {
    public fun get_price_u64<T0>(arg0: &0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::price_feed::last_updated(v2), 1);
        0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

