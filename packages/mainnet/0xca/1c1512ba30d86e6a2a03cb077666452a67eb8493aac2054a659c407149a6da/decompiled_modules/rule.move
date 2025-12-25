module 0xca1c1512ba30d86e6a2a03cb077666452a67eb8493aac2054a659c407149a6da::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOraclePriceUpdateRequest<0x4e1df7e71ef964a685eb26a65ba3a45d2feb94005014fdc510e61f1392981916::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::set_primary_price<0x4e1df7e71ef964a685eb26a65ba3a45d2feb94005014fdc510e61f1392981916::coin_gr::COIN_GR, Rule>(v0, arg0, 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOraclePriceUpdateRequest<0x4e1df7e71ef964a685eb26a65ba3a45d2feb94005014fdc510e61f1392981916::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::set_secondary_price<0x4e1df7e71ef964a685eb26a65ba3a45d2feb94005014fdc510e61f1392981916::coin_gr::COIN_GR, Rule>(v0, arg0, 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

