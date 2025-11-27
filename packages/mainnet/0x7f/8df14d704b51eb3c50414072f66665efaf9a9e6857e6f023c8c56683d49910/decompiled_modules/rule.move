module 0x7f8df14d704b51eb3c50414072f66665efaf9a9e6857e6f023c8c56683d49910::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOraclePriceUpdateRequest<0x89137a0be13156a0b7c6f681842373f6c1fc5a5020243ab39f6ba291096ba027::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::set_primary_price<0x89137a0be13156a0b7c6f681842373f6c1fc5a5020243ab39f6ba291096ba027::coin_gr::COIN_GR, Rule>(v0, arg0, 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOraclePriceUpdateRequest<0x89137a0be13156a0b7c6f681842373f6c1fc5a5020243ab39f6ba291096ba027::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::set_secondary_price<0x89137a0be13156a0b7c6f681842373f6c1fc5a5020243ab39f6ba291096ba027::coin_gr::COIN_GR, Rule>(v0, arg0, 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

