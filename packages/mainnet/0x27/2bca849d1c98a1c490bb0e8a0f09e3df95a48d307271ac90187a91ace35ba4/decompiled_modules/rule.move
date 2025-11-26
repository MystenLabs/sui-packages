module 0x272bca849d1c98a1c490bb0e8a0f09e3df95a48d307271ac90187a91ace35ba4::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOraclePriceUpdateRequest<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::set_primary_price<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOraclePriceUpdateRequest<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::set_secondary_price<0x1ad0ff481b24a7d182ba9f6784522bdea412d9d65d07c0d278cfa5f2281c0abd::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

