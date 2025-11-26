module 0xf156ff65c6f6b524a4054cb65cf783675854b3fa2f6f01e0c4c4fcf418130b3f::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::XOraclePriceUpdateRequest<0x2ac3481f33175edb5dec99d633376c0f6bf11a36224f45281e981b188480d099::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::set_primary_price<0x2ac3481f33175edb5dec99d633376c0f6bf11a36224f45281e981b188480d099::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::XOraclePriceUpdateRequest<0x2ac3481f33175edb5dec99d633376c0f6bf11a36224f45281e981b188480d099::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::set_secondary_price<0x2ac3481f33175edb5dec99d633376c0f6bf11a36224f45281e981b188480d099::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

