module 0xf60a53b6e096f3f89f4da96a2ff8f30faa2a290498e071c7d6083ef30d7d828b::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOraclePriceUpdateRequest<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::set_primary_price<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOraclePriceUpdateRequest<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::set_secondary_price<0xc13fb492d0fd3bc1da07d90a5e3807288919884ab1ecc53894295be3c169b459::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

