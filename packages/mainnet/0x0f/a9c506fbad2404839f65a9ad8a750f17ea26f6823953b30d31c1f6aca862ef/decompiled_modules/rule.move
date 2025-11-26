module 0xfa9c506fbad2404839f65a9ad8a750f17ea26f6823953b30d31c1f6aca862ef::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOraclePriceUpdateRequest<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::set_primary_price<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOraclePriceUpdateRequest<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::set_secondary_price<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

