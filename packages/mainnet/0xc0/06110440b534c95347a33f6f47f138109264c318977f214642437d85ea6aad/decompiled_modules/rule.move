module 0xc006110440b534c95347a33f6f47f138109264c318977f214642437d85ea6aad::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOraclePriceUpdateRequest<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::set_primary_price<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR, Rule>(v0, arg0, 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::XOraclePriceUpdateRequest<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::x_oracle::set_secondary_price<0x807a782a780a1f14aef17bf528762be0f01237b427cb37834a9113c7eb28b883::coin_gr::COIN_GR, Rule>(v0, arg0, 0xa5e8e2f789e62771d342ec92fd6597f8f5b3c68193f1ac46f4c4b12cd8b4a63f::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

