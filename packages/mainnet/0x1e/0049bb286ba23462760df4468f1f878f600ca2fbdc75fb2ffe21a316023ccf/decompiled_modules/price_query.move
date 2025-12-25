module 0x1e0049bb286ba23462760df4468f1f878f600ca2fbdc75fb2ffe21a316023ccf::price_query {
    public fun get_price_u64<T0>(arg0: &0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::last_updated(v2), 1);
        0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

