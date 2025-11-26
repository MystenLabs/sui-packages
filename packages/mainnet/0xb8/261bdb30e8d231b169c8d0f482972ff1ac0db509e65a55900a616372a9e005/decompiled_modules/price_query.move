module 0xb8261bdb30e8d231b169c8d0f482972ff1ac0db509e65a55900a616372a9e005::price_query {
    public fun get_price_u64<T0>(arg0: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::prices(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::PriceFeed>(v0, v1), 0);
        let v2 = 0x2::table::borrow<0x1::type_name::TypeName, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::PriceFeed>(v0, v1);
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 == 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::last_updated(v2), 1);
        0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::value(v2)
    }

    // decompiled from Move bytecode v6
}

