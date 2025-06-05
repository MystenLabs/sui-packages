module 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::mmt_v3 {
    public fun new<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock) : 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::Price {
        0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::new(parse_sqrt_price_to_decimal(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0), arg1, false), 0x2::clock::timestamp_ms(arg2))
    }

    public fun new_reverse<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T1, T0>, arg1: u8, arg2: &0x2::clock::Clock) : 0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::Price {
        0xf2b4e4a3cffd9f8439c7113774f1a6a57cd12cd93ac2aad4b6b497a6eed9c038::price::new(parse_sqrt_price_to_decimal(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T1, T0>(arg0), arg1, true), 0x2::clock::timestamp_ms(arg2))
    }

    fun parse_sqrt_price_to_decimal(arg0: u128, arg1: u8, arg2: bool) : u256 {
        let v0 = (arg0 as u256);
        let v1 = 18446744073709551616;
        if (arg2) {
            v0 * (0x2::math::pow(10, arg1) as u256) / v1 * v0 / v1
        } else {
            v1 * (0x2::math::pow(10, arg1) as u256) / v0 * v1 / v0
        }
    }

    // decompiled from Move bytecode v6
}

