module 0x588b808c89a54527de1fa5b00d1c0e355cd20d5c1061619c9a97c99edb7c040::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOraclePriceUpdateRequest<0xc0d898ea4adacaa2ad976d431aa0fb4eca15a580aa40ba97727e8ab88c5f0e50::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::set_primary_price<0xc0d898ea4adacaa2ad976d431aa0fb4eca15a580aa40ba97727e8ab88c5f0e50::coin_gr::COIN_GR, Rule>(v0, arg0, 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOraclePriceUpdateRequest<0xc0d898ea4adacaa2ad976d431aa0fb4eca15a580aa40ba97727e8ab88c5f0e50::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::set_secondary_price<0xc0d898ea4adacaa2ad976d431aa0fb4eca15a580aa40ba97727e8ab88c5f0e50::coin_gr::COIN_GR, Rule>(v0, arg0, 0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

