module 0x1b627e98a0fc27907aee56b80741fc5c16956d6b61de23d8590e1f5d5498e04d::price_query {
    public fun get_price_u64<T0>(arg0: &0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::price_feed::last_updated(v2), 1);
        0x596c9c56aac834623862292183657900609cb2e309f40608398bea4a704fb4d1::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

