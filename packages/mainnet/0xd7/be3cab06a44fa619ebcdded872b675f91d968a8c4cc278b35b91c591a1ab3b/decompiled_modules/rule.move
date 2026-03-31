module 0xd7be3cab06a44fa619ebcdded872b675f91d968a8c4cc278b35b91c591a1ab3b::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOraclePriceUpdateRequest<0xdb3b83fe3f9103baee5bc8e3a734d2b3082f5a1d6ef100029cb09233bbe6a36b::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::set_primary_price<0xdb3b83fe3f9103baee5bc8e3a734d2b3082f5a1d6ef100029cb09233bbe6a36b::coin_gr::COIN_GR, Rule>(v0, arg0, 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOraclePriceUpdateRequest<0xdb3b83fe3f9103baee5bc8e3a734d2b3082f5a1d6ef100029cb09233bbe6a36b::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::set_secondary_price<0xdb3b83fe3f9103baee5bc8e3a734d2b3082f5a1d6ef100029cb09233bbe6a36b::coin_gr::COIN_GR, Rule>(v0, arg0, 0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

