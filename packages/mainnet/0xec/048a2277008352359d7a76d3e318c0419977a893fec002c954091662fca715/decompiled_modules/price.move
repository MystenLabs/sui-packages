module 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::price {
    public fun get_price(arg0: &0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::PriceFeed>(v0, arg1), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::PriceFeed>(v0, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::last_updated(v1), 0xec048a2277008352359d7a76d3e318c0419977a893fec002c954091662fca715::error::oracle_stale_price_error());
        0x1::fixed_point32::create_from_rational(0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::value(v1), 0x2::math::pow(10, 0xcd9bf99ee89711edd5084fbd67aee0865b866f0bb3262701ec487cd45b0d3041::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

