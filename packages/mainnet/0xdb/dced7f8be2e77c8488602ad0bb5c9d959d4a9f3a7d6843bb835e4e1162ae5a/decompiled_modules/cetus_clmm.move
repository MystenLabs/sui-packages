module 0xdbdced7f8be2e77c8488602ad0bb5c9d959d4a9f3a7d6843bb835e4e1162ae5a::cetus_clmm {
    public fun new<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : 0xdbdced7f8be2e77c8488602ad0bb5c9d959d4a9f3a7d6843bb835e4e1162ae5a::price::Price {
        0xdbdced7f8be2e77c8488602ad0bb5c9d959d4a9f3a7d6843bb835e4e1162ae5a::price::new(parse_sqrt_price_to_decimal(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), false), 0x2::clock::timestamp_ms(arg1))
    }

    public fun new_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: &0x2::clock::Clock) : 0xdbdced7f8be2e77c8488602ad0bb5c9d959d4a9f3a7d6843bb835e4e1162ae5a::price::Price {
        0xdbdced7f8be2e77c8488602ad0bb5c9d959d4a9f3a7d6843bb835e4e1162ae5a::price::new(parse_sqrt_price_to_decimal(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg0), true), 0x2::clock::timestamp_ms(arg1))
    }

    fun parse_sqrt_price_to_decimal(arg0: u128, arg1: bool) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 18446744073709551616;
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from_u128(arg0), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from_u128(v0)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from_u128(arg0), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from_u128(v0)));
        let v2 = v1;
        if (arg1) {
            v2 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(1), v1);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

