module 0x91d64ad889e04532351a2a0b02e5261f28f203d767746048c5b1805af3bd3fc::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOraclePriceUpdateRequest<0x3127118fd70299172297d09ad9ba65b69ef704e96f2939083cdc777e1b16f7b9::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::set_primary_price<0x3127118fd70299172297d09ad9ba65b69ef704e96f2939083cdc777e1b16f7b9::coin_gr::COIN_GR, Rule>(v0, arg0, 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOraclePriceUpdateRequest<0x3127118fd70299172297d09ad9ba65b69ef704e96f2939083cdc777e1b16f7b9::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::set_secondary_price<0x3127118fd70299172297d09ad9ba65b69ef704e96f2939083cdc777e1b16f7b9::coin_gr::COIN_GR, Rule>(v0, arg0, 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

