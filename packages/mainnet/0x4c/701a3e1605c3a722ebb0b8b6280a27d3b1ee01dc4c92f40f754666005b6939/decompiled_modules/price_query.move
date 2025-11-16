module 0x4c701a3e1605c3a722ebb0b8b6280a27d3b1ee01dc4c92f40f754666005b6939::price_query {
    public fun get_price_u64<T0>(arg0: &0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::price_feed::last_updated(v2), 1);
        0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

