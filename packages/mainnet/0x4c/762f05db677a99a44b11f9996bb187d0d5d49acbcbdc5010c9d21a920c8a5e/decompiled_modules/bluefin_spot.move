module 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::bluefin_spot {
    public fun new<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::Price {
        0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::new(parse_sqrt_price_to_decimal(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), false), 0x2::clock::timestamp_ms(arg1))
    }

    public fun new_reverse<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: &0x2::clock::Clock) : 0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::Price {
        0x4c762f05db677a99a44b11f9996bb187d0d5d49acbcbdc5010c9d21a920c8a5e::price::new(parse_sqrt_price_to_decimal(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg0), true), 0x2::clock::timestamp_ms(arg1))
    }

    fun parse_sqrt_price_to_decimal(arg0: u128, arg1: bool) : 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::Decimal {
        let v0 = 1 << 64;
        let v1 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::mul(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from_u128(arg0), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v0)), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from_u128(arg0), 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(v0)));
        let v2 = v1;
        if (arg1) {
            v2 = 0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::div(0xc5f0aa630b9e6de12ecdc2bbcd4307d1db3a90e1efec271f32d984b4b971c301::decimal::from(1), v1);
        };
        v2
    }

    // decompiled from Move bytecode v6
}

