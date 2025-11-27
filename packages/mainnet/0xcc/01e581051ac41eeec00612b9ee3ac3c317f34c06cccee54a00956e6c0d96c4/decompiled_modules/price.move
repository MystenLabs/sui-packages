module 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::price {
    public fun get_price(arg0: &0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::price_feed::PriceFeed>(v0, arg1), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::price_feed::last_updated(v1), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

