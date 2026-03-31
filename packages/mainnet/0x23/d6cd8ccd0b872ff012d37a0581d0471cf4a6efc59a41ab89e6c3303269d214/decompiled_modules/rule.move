module 0x23d6cd8ccd0b872ff012d37a0581d0471cf4a6efc59a41ab89e6c3303269d214::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOraclePriceUpdateRequest<0xb4750bda19507f781fa9131b362810012d0bc198e93270cf5ba8dd5aada923d::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::set_primary_price<0xb4750bda19507f781fa9131b362810012d0bc198e93270cf5ba8dd5aada923d::coin_gr::COIN_GR, Rule>(v0, arg0, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOraclePriceUpdateRequest<0xb4750bda19507f781fa9131b362810012d0bc198e93270cf5ba8dd5aada923d::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::set_secondary_price<0xb4750bda19507f781fa9131b362810012d0bc198e93270cf5ba8dd5aada923d::coin_gr::COIN_GR, Rule>(v0, arg0, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

