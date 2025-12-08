module 0xc4142a3e1f23704d8ea55941fa7681f0a6c02b0add710e34155e01973a314fa5::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOraclePriceUpdateRequest<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::set_primary_price<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::XOraclePriceUpdateRequest<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::x_oracle::set_secondary_price<0x6634b0ffe24d3764c6863c80385a6ab436411431938d056636377e33ad11eb06::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xce91f0478d12ae82a78c09db1bcffb873242d242976d9f721a76a1a40e2d8bc4::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

