module 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::price {
    public fun get_price(arg0: &0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::price_feed::PriceFeed>(v0, arg1), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::price_feed::last_updated(v1), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

