module 0xb78109a6bb238208ce4b7fcad7765b966349ca83580ac3bfbfbb615095d2aa2d::price_query {
    public fun get_price_u64<T0>(arg0: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::last_updated(v2), 1);
        0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

