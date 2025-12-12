module 0xc7fe578d40f0ba552aeedf83bb61bca2eaef4af005877a1f85c45347fcaa9660::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOraclePriceUpdateRequest<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::set_primary_price<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOraclePriceUpdateRequest<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::set_secondary_price<0x9017953faf6b8ba1889fee20a49837b406d45f664097b0312c688fae536e2719::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

