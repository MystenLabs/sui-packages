module 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::price {
    public fun get_price(arg0: &0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::PriceFeed>(v0, arg1), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::last_updated(v1), 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x7dcc19ef54dc4866df5921dacc872cd341f403a0f6053a35ef834ebc67ab3092::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

