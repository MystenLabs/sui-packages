module 0xe17cfcdd6b7cb905f7efbe13357eea5a04fee08da7523b1b02dd26208dbada68::cetus_clmm {
    public fun new<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock) : 0xe17cfcdd6b7cb905f7efbe13357eea5a04fee08da7523b1b02dd26208dbada68::price::Price {
        0xe17cfcdd6b7cb905f7efbe13357eea5a04fee08da7523b1b02dd26208dbada68::price::new(parse_sqrt_price_to_decimal(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg0), arg1, false), 0x2::clock::timestamp_ms(arg2))
    }

    public fun new_reverse<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg1: u8, arg2: &0x2::clock::Clock) : 0xe17cfcdd6b7cb905f7efbe13357eea5a04fee08da7523b1b02dd26208dbada68::price::Price {
        0xe17cfcdd6b7cb905f7efbe13357eea5a04fee08da7523b1b02dd26208dbada68::price::new(parse_sqrt_price_to_decimal(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T1, T0>(arg0), arg1, true), 0x2::clock::timestamp_ms(arg2))
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

