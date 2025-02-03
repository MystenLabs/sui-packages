module 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::price {
    public fun get_price(arg0: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::price_feed::PriceFeed>(v0, arg1), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::price_feed::last_updated(v1), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

