module 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::price {
    public fun get_price(arg0: &0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::PriceFeed>(v0, arg1), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::last_updated(v1), 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x7ac3d8f55df5472a7f5e57da7e84f61a3f091fc1a912e140d347c0d7bf954d1d::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

