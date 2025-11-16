module 0xf1c4f8287dfdb3028e4e3411cd522b4a6f25c0e45b69bb030ca21be0ccbca012::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0xafc61c21f98f44466f686b26ef3fa9f35a6762cbf078d1018124ad88416a13df::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

