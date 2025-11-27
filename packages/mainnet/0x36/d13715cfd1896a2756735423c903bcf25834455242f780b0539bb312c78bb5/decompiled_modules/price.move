module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price {
    public fun get_price(arg0: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::PriceFeed>(v0, arg1), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::last_updated(v1), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

