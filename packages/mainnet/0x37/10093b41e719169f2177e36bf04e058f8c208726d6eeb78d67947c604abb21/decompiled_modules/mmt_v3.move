module 0x3710093b41e719169f2177e36bf04e058f8c208726d6eeb78d67947c604abb21::mmt_v3 {
    public fun new<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : 0x3710093b41e719169f2177e36bf04e058f8c208726d6eeb78d67947c604abb21::price::Price {
        0x3710093b41e719169f2177e36bf04e058f8c208726d6eeb78d67947c604abb21::price::new(parse_sqrt_price_to_decimal(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), false), 0x2::clock::timestamp_ms(arg1))
    }

    public fun new_reverse<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: &0x2::clock::Clock) : 0x3710093b41e719169f2177e36bf04e058f8c208726d6eeb78d67947c604abb21::price::Price {
        0x3710093b41e719169f2177e36bf04e058f8c208726d6eeb78d67947c604abb21::price::new(parse_sqrt_price_to_decimal(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg0), true), 0x2::clock::timestamp_ms(arg1))
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

