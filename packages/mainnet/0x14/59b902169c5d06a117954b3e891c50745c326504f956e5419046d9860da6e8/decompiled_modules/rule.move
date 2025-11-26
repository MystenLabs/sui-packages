module 0x1459b902169c5d06a117954b3e891c50745c326504f956e5419046d9860da6e8::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOraclePriceUpdateRequest<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::set_primary_price<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::XOraclePriceUpdateRequest<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::x_oracle::set_secondary_price<0xacfaad705364d31ef81a5a62779bbc162ff64e64b05b1c3be65ea160eeb8ef44::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x2c5f882fd7b3de81592adedb695799b0245c785684b3fbd61a4af17808f107dc::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

