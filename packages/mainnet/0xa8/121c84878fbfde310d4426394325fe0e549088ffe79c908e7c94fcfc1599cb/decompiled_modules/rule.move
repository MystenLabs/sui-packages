module 0xa8121c84878fbfde310d4426394325fe0e549088ffe79c908e7c94fcfc1599cb::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOraclePriceUpdateRequest<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::set_primary_price<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::XOraclePriceUpdateRequest<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::x_oracle::set_secondary_price<0x293cb7d3d070d4609d0654ee262b17f86d7c4f758e86707ec5f8602c0b9ca2a7::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xba8ce54a8b72c404990eafcee688689fe90a76657a14d1b7b528f419808833c8::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

