module 0xa0549428639537b52743e1b15e0b5c477d36c4b6991b7a14b2308777003ee5e7::price_query {
    public fun get_price_u64<T0>(arg0: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::last_updated(v2), 1);
        0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

