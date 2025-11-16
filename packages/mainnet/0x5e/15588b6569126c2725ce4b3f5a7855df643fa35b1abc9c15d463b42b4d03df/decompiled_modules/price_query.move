module 0x5e15588b6569126c2725ce4b3f5a7855df643fa35b1abc9c15d463b42b4d03df::price_query {
    public fun get_price_u64<T0>(arg0: &0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::price_feed::last_updated(v2), 1);
        0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

