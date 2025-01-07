module 0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_registry::SupraRegistry, arg3: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_adaptor::get_supra_price(arg1, 0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_registry::get_supra_pair_id<T0>(arg2));
        let v3 = 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::decimals();
        let v4 = if (v1 < v3) {
            v0 * 0x2::math::pow(10, v3 - v1)
        } else {
            v0 / 0x2::math::pow(10, v1 - v3)
        };
        assert!(v4 > 0, 70401);
        let v5 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v2 >= v5 - 60, 70404);
        assert!(v2 <= v5 + 10, 70405);
        let v6 = Rule{dummy_field: false};
        0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::x_oracle::set_primary_price<T0, Rule>(v6, arg0, 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::new(v4, v2));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: &0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_registry::SupraRegistry, arg3: &0x2::clock::Clock) {
        let (v0, v1, v2) = 0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_adaptor::get_supra_price(arg1, 0xa0e9549b50bcb11d22b251593f5409cb51dad06af8599e7ba4732876292592bc::supra_registry::get_supra_pair_id<T0>(arg2));
        let v3 = 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::decimals();
        let v4 = if (v1 < v3) {
            v0 * 0x2::math::pow(10, v3 - v1)
        } else {
            v0 / 0x2::math::pow(10, v1 - v3)
        };
        assert!(v4 > 0, 70401);
        let v5 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v2 >= v5 - 60, 70404);
        assert!(v2 <= v5 + 10, 70405);
        let v6 = Rule{dummy_field: false};
        0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::x_oracle::set_secondary_price<T0, Rule>(v6, arg0, 0xe11209515f632fbc9280b09dcc25869f1efa02a675a96b92497857562f9a8a8f::price_feed::new(v4, v2));
    }

    // decompiled from Move bytecode v6
}

