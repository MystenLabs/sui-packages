module 0xaa64c15da021785a57258a2bb98baa2c436512b3256adaea505b345c09605602::price_query {
    public fun get_price_u64<T0>(arg0: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::last_updated(v2), 1);
        0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

