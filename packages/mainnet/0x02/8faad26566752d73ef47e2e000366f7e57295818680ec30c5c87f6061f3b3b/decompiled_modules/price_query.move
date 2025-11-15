module 0x28faad26566752d73ef47e2e000366f7e57295818680ec30c5c87f6061f3b3b::price_query {
    public fun get_price_u64<T0>(arg0: &0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::price_feed::last_updated(v2), 1);
        0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

