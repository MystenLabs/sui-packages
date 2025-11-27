module 0x211089e09b7037327702a40dd2949b73c4f743156cf95af37c097eee2f8b4b27::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOraclePriceUpdateRequest<0x11cf68ee99d7b237470eb68a714a8de80ffe5d1d97a1c19366afdb685d9bd7a5::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::set_primary_price<0x11cf68ee99d7b237470eb68a714a8de80ffe5d1d97a1c19366afdb685d9bd7a5::coin_gr::COIN_GR, Rule>(v0, arg0, 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOraclePriceUpdateRequest<0x11cf68ee99d7b237470eb68a714a8de80ffe5d1d97a1c19366afdb685d9bd7a5::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::set_secondary_price<0x11cf68ee99d7b237470eb68a714a8de80ffe5d1d97a1c19366afdb685d9bd7a5::coin_gr::COIN_GR, Rule>(v0, arg0, 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

