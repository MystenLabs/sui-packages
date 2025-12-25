module 0x7e3a0fb851187c878f59775635bcd90c7afe717cf7e9e2b4d79578be310ec3d6::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOraclePriceUpdateRequest<0x52089e3cdc392f57e5706e0e5ab1fc689c41c128f933e32c7209e8e10bafda73::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::set_primary_price<0x52089e3cdc392f57e5706e0e5ab1fc689c41c128f933e32c7209e8e10bafda73::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::XOraclePriceUpdateRequest<0x52089e3cdc392f57e5706e0e5ab1fc689c41c128f933e32c7209e8e10bafda73::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::x_oracle::set_secondary_price<0x52089e3cdc392f57e5706e0e5ab1fc689c41c128f933e32c7209e8e10bafda73::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xc591cdee730dde36263a49ccbfa624d2c031aa81e2b2af1e84dc7488b3f374a5::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

