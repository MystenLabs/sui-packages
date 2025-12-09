module 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::price {
    public fun get_price(arg0: &0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::PriceFeed>(v0, arg1), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::last_updated(v1), 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x1991c3eec81b64258e004c6a4e73f6d297d33426ee904512d18ac2103e29b5fb::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

