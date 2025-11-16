module 0xe1050352fb6c4dbf459d510878f3edc67bb2f7031a94ab32c2221ef4dff8cbdc::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x195dae755ccc7d61bec62f1814b48b8dd95b27a38e118f80a3e711f1bad67ce7::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

