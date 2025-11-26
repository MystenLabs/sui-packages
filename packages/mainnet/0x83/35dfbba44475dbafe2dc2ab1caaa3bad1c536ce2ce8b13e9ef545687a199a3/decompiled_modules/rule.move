module 0x8335dfbba44475dbafe2dc2ab1caaa3bad1c536ce2ce8b13e9ef545687a199a3::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::XOraclePriceUpdateRequest<0xacb2fe6e0066e77f940173eae445674e04c7c62cc2f329ca2a61bd7429bba3f6::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::set_primary_price<0xacb2fe6e0066e77f940173eae445674e04c7c62cc2f329ca2a61bd7429bba3f6::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::XOraclePriceUpdateRequest<0xacb2fe6e0066e77f940173eae445674e04c7c62cc2f329ca2a61bd7429bba3f6::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::set_secondary_price<0xacb2fe6e0066e77f940173eae445674e04c7c62cc2f329ca2a61bd7429bba3f6::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

