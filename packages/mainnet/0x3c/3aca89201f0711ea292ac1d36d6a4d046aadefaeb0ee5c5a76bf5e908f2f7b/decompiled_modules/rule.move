module 0x3c3aca89201f0711ea292ac1d36d6a4d046aadefaeb0ee5c5a76bf5e908f2f7b::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOraclePriceUpdateRequest<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::set_primary_price<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOraclePriceUpdateRequest<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::set_secondary_price<0xbde45b30c9c6831246128c97d2d37b1c127eb743a83c27d2b2f6e8d00fadf245::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

