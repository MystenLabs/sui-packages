module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::price {
    public fun get_price(arg0: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(v0, arg1), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::last_updated(v1), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

