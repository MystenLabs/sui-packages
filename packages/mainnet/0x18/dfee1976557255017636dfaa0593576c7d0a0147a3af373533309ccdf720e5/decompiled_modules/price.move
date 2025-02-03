module 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::price {
    public fun get_price(arg0: &0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::x_oracle::prices(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::price_feed::PriceFeed>(v0, arg1), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::error::oracle_price_not_found_error());
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::price_feed::PriceFeed>(v0, arg1);
        let v2 = 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::price_feed::value(v1);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 == 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::price_feed::last_updated(v1), 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::error::oracle_stale_price_error());
        assert!(v2 > 0, 0x18dfee1976557255017636dfaa0593576c7d0a0147a3af373533309ccdf720e5::error::oracle_zero_price_error());
        0x1::fixed_point32::create_from_rational(v2, 0x2::math::pow(10, 0x1b2edca7df0bb72e230fa1771e059bf20bd525a36a8653c61929ab6d9febb144::price_feed::decimals()))
    }

    // decompiled from Move bytecode v6
}

