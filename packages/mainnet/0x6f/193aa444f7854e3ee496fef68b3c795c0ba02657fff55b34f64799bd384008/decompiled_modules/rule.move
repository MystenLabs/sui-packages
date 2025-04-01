module 0x6f193aa444f7854e3ee496fef68b3c795c0ba02657fff55b34f64799bd384008::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun assert_price_not_stale(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0 >= v0 - 60, 70658);
        assert!(arg0 <= v0 + 10, 70659);
    }

    fun get_switchboard_price<T0>(arg0: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg1: &0x6f193aa444f7854e3ee496fef68b3c795c0ba02657fff55b34f64799bd384008::switchboard_registry::SwitchboardRegistry, arg2: &0x2::clock::Clock) : 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::PriceFeed {
        0x6f193aa444f7854e3ee496fef68b3c795c0ba02657fff55b34f64799bd384008::switchboard_registry::assert_switchboard_aggregator<T0>(arg1, arg0);
        let (v0, v1) = 0x6f193aa444f7854e3ee496fef68b3c795c0ba02657fff55b34f64799bd384008::switchboard_adaptor::get_switchboard_price(arg0);
        let v2 = v0 / (0x1::u64::pow(10, 18 - 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::decimals()) as u128);
        assert!(v2 > 0 && v2 < 18446744073709551615, 70657);
        assert_price_not_stale(v1, arg2);
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::new((v2 as u64), v1)
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x6f193aa444f7854e3ee496fef68b3c795c0ba02657fff55b34f64799bd384008::switchboard_registry::SwitchboardRegistry, arg3: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::set_primary_price<T0, Rule>(v0, arg0, get_switchboard_price<T0>(arg1, arg2, arg3));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0xc3c7e6eb7202e9fb0389a2f7542b91cc40e4f7a33c02554fec11c4c92f938ea3::aggregator::Aggregator, arg2: &0x6f193aa444f7854e3ee496fef68b3c795c0ba02657fff55b34f64799bd384008::switchboard_registry::SwitchboardRegistry, arg3: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, get_switchboard_price<T0>(arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

