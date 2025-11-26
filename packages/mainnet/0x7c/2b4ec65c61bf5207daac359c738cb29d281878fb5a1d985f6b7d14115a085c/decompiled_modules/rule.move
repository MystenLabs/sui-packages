module 0x7c2b4ec65c61bf5207daac359c738cb29d281878fb5a1d985f6b7d14115a085c::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOraclePriceUpdateRequest<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::set_primary_price<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOraclePriceUpdateRequest<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::set_secondary_price<0xabb3631bd2a91461b61e0b16a8e4e4e88185a3dd410e12186f65f18b1b98da17::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

