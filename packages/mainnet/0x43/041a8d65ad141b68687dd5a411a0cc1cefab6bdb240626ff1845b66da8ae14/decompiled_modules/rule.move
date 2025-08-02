module 0x43041a8d65ad141b68687dd5a411a0cc1cefab6bdb240626ff1845b66da8ae14::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::new(5, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::price_feed::new(5, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

