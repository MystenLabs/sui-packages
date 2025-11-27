module 0x9adf3e7cbd29a12b8310f15013460bec2283b70755e05a48a4bab768fe23e61a::price_query {
    public fun get_price_u64<T0>(arg0: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::last_updated(v2), 1);
        0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

