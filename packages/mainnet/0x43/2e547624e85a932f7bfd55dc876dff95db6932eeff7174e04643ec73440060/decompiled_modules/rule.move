module 0x432e547624e85a932f7bfd55dc876dff95db6932eeff7174e04643ec73440060::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary<T0>(arg0: &mut 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::x_oracle::set_primary_price<T0, Rule>(v0, arg0, 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    public fun set_price_as_secondary<T0>(arg0: &mut 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::x_oracle::set_secondary_price<T0, Rule>(v0, arg0, 0x92f7604dd5ae0a23cd05b5702f94769df42d5e39cf87aad9c681d2e859fb0b91::price_feed::new(arg1, 0x2::clock::timestamp_ms(arg2) / 1000));
    }

    // decompiled from Move bytecode v6
}

