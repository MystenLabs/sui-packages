module 0x3dcbc91de8f756f6d3adb847ed7cc5a002f12f8fb6b9568e794661adf5a1ff33::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOraclePriceUpdateRequest<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::set_primary_price<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOraclePriceUpdateRequest<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::set_secondary_price<0x1d703f494d69529c135b2f8de14da5638d94cf127b6e8ca2b42d2d5658a0f11::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

