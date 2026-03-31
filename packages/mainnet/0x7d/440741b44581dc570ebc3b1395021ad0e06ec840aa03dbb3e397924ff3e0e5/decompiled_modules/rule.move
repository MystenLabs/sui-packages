module 0x7d440741b44581dc570ebc3b1395021ad0e06ec840aa03dbb3e397924ff3e0e5::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOraclePriceUpdateRequest<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::set_primary_price<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOraclePriceUpdateRequest<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::set_secondary_price<0xfed4826846f281385e9b6eac8c116b6302105dbd30eebc5509b634e64b1bb818::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

