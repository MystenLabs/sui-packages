module 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::price {
    public fun get_price(arg0: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::PriceFeed>(v0, arg1), 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::PriceFeed>(v0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::last_updated(v1), 0x8ea7d7dcfcaf5dff6c24a73caf6c1171a16d7677a6b12cf3c93011eeb84bb44f::error::oracle_stale_price_error());
        0x1::fixed_point32::create_from_rational(0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::value(v1), 0x2::math::pow(10, 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

