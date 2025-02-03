module 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price {
    public fun get_price(arg0: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price_feed::PriceFeed>(v0, arg1), 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price_feed::last_updated(v1), 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

