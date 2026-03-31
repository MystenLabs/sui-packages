module 0x5bc67dd6b5b150939ae3406f2f8a305a4749d89b60e7f4fa31fbfc3390b49419::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOraclePriceUpdateRequest<0x8d8b4b5bcfca1e497b4aff33100a521ac4e253d9a96ac44bb3bfe1bde7038ccd::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::set_primary_price<0x8d8b4b5bcfca1e497b4aff33100a521ac4e253d9a96ac44bb3bfe1bde7038ccd::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::XOraclePriceUpdateRequest<0x8d8b4b5bcfca1e497b4aff33100a521ac4e253d9a96ac44bb3bfe1bde7038ccd::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::x_oracle::set_secondary_price<0x8d8b4b5bcfca1e497b4aff33100a521ac4e253d9a96ac44bb3bfe1bde7038ccd::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xcde8e9f40019620c316c66627733237292e11f33ff2d0bffb1d4c2b3fed1646e::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

