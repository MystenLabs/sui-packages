module 0x759366c50b45ac5370a2e6c32d15743e439ae51ce01f7bae93f9508689eeb76d::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOraclePriceUpdateRequest<0x83d0ae985369a6c7077d1cff28b625b8fc6df3b0dbfb0c28cb0726ece0fe85c3::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::set_primary_price<0x83d0ae985369a6c7077d1cff28b625b8fc6df3b0dbfb0c28cb0726ece0fe85c3::coin_gr::COIN_GR, Rule>(v0, arg0, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOraclePriceUpdateRequest<0x83d0ae985369a6c7077d1cff28b625b8fc6df3b0dbfb0c28cb0726ece0fe85c3::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::set_secondary_price<0x83d0ae985369a6c7077d1cff28b625b8fc6df3b0dbfb0c28cb0726ece0fe85c3::coin_gr::COIN_GR, Rule>(v0, arg0, 0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

