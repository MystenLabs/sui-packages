module 0xfc858dd9bc837d7396301fbe8f0a320612901150419846fc894a7fd56fc6263f::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOraclePriceUpdateRequest<0x304bb65b2ded359f6cc086417100b801e6f58d319e6d89e70e33ad764664c20a::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::set_primary_price<0x304bb65b2ded359f6cc086417100b801e6f58d319e6d89e70e33ad764664c20a::coin_gr::COIN_GR, Rule>(v0, arg0, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOraclePriceUpdateRequest<0x304bb65b2ded359f6cc086417100b801e6f58d319e6d89e70e33ad764664c20a::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::set_secondary_price<0x304bb65b2ded359f6cc086417100b801e6f58d319e6d89e70e33ad764664c20a::coin_gr::COIN_GR, Rule>(v0, arg0, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

