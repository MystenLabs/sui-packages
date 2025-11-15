module 0x1d80e02ac7edf91c972ccf659c15c29ba36a3c289c9826419fafafa5915a7943::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x1de275d42b793e8344be670cc301b11e66606a9d16f71e6375bb52f950bbb8e::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

