module 0xa5e4c8b1e53e82eb9e7b07cd819247265d9e1ad8c8fd7295c60d907e5c0fea0d::price_query {
    public fun get_price_u64<T0>(arg0: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::last_updated(v2), 1);
        0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

