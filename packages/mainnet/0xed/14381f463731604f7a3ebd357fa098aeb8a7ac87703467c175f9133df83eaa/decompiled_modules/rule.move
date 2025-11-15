module 0xed14381f463731604f7a3ebd357fa098aeb8a7ac87703467c175f9133df83eaa::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x4b259760c965a5e4a9a9c809f73dce11aef06a401984c3dd4dfcdfb2b890db7a::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

