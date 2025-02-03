module 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price {
    public fun get_price(arg0: &0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price_feed::PriceFeed>(v0, arg1), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price_feed::last_updated(v1), 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

