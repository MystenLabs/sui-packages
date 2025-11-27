module 0x89af15150e44afcde29770692b3dc390556339a6a65ae8724e3a99bdd4e72f09::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOraclePriceUpdateRequest<0xdf2e95a5c115c25c26c2c584a326c4b7b19315ae2c81a1f3b20f4c5ec17618a7::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::set_primary_price<0xdf2e95a5c115c25c26c2c584a326c4b7b19315ae2c81a1f3b20f4c5ec17618a7::coin_gr::COIN_GR, Rule>(v0, arg0, 0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOraclePriceUpdateRequest<0xdf2e95a5c115c25c26c2c584a326c4b7b19315ae2c81a1f3b20f4c5ec17618a7::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::set_secondary_price<0xdf2e95a5c115c25c26c2c584a326c4b7b19315ae2c81a1f3b20f4c5ec17618a7::coin_gr::COIN_GR, Rule>(v0, arg0, 0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

