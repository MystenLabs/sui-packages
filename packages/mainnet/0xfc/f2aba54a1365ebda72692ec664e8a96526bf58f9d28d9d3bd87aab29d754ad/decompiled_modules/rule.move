module 0xfcf2aba54a1365ebda72692ec664e8a96526bf58f9d28d9d3bd87aab29d754ad::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOraclePriceUpdateRequest<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::set_primary_price<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOraclePriceUpdateRequest<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::set_secondary_price<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

