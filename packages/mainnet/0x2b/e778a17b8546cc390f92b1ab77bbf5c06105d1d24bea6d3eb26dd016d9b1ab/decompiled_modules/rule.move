module 0x2be778a17b8546cc390f92b1ab77bbf5c06105d1d24bea6d3eb26dd016d9b1ab::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOraclePriceUpdateRequest<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::set_primary_price<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOraclePriceUpdateRequest<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::set_secondary_price<0x1e1f71a94e5207c310a3b13edc038e0aa3104cf8f9c9918548b233133987cd6a::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

