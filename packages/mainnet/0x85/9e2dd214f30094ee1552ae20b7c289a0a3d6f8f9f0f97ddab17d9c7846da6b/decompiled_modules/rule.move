module 0x859e2dd214f30094ee1552ae20b7c289a0a3d6f8f9f0f97ddab17d9c7846da6b::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOraclePriceUpdateRequest<0xd2e5cb84b33e2acadff5d1c8a30181e8871de44b5bfbea5b8c615ec6218b2fca::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::set_primary_price<0xd2e5cb84b33e2acadff5d1c8a30181e8871de44b5bfbea5b8c615ec6218b2fca::coin_gr::COIN_GR, Rule>(v0, arg0, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOraclePriceUpdateRequest<0xd2e5cb84b33e2acadff5d1c8a30181e8871de44b5bfbea5b8c615ec6218b2fca::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::set_secondary_price<0xd2e5cb84b33e2acadff5d1c8a30181e8871de44b5bfbea5b8c615ec6218b2fca::coin_gr::COIN_GR, Rule>(v0, arg0, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

