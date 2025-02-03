module 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::price {
    public fun get_price(arg0: &0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::price_feed::PriceFeed>(v0, arg1), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::price_feed::last_updated(v1), 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::error::oracle_stale_price_error());
        assert!(v2 > 0, 0xa9cdb9d8e80465c75dcdad061cf1d462a9cf662da071412ca178d579d8df2855::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x3658f5650dd8943ee6de53465a6d1cdc58e015348e8650ff5e69ee8201350a45::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

