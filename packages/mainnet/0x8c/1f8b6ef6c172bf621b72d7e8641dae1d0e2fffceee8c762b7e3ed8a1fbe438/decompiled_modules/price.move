module 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::price {
    public fun get_price(arg0: &0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::PriceFeed>(v0, arg1), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::last_updated(v1), 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x8c1f8b6ef6c172bf621b72d7e8641dae1d0e2fffceee8c762b7e3ed8a1fbe438::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

