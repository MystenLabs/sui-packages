module 0x255520616883ea884aefed74f8395856157358f6aecefae66341f9785345d7a7::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x7e75fed10f064037b2d88c93a2b07e58043180ad339c964989fd6968ab30a64e::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

