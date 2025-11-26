module 0x627aae0e6d3412fd8906eaca8b4ed272e406b3cbb6821e61afb09913893012ae::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::XOraclePriceUpdateRequest<0x353b21ffdefc521819b1b3ac7e7ddb557784e5d9f13a6d883798697bbd94c050::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::set_primary_price<0x353b21ffdefc521819b1b3ac7e7ddb557784e5d9f13a6d883798697bbd94c050::coin_gr::COIN_GR, Rule>(v0, arg0, 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::XOraclePriceUpdateRequest<0x353b21ffdefc521819b1b3ac7e7ddb557784e5d9f13a6d883798697bbd94c050::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::x_oracle::set_secondary_price<0x353b21ffdefc521819b1b3ac7e7ddb557784e5d9f13a6d883798697bbd94c050::coin_gr::COIN_GR, Rule>(v0, arg0, 0xfb72716f86820f2666a01e472bd5f5b69c801cb922a44230e7ea3d8bc14e716::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

