module 0x83c472b0e83b5c586e46e35e06e90b64e88e17bd19aa9e58206a15bb852d1f4::price_query {
    public fun get_price_u64<T0>(arg0: &0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::price_feed::last_updated(v2), 1);
        0x8dec57a53d049b83996302aa67fae5896c441af9cfad52e27ebe50ea2df6f925::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

