module 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::price {
    public fun get_price(arg0: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::PriceFeed>(v0, arg1), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::last_updated(v1), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

