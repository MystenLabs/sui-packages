module 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::bluefin_spot {
    public fun new<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock) : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::Price {
        0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::new(parse_sqrt_price_to_decimal(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), arg1, false), 0x2::clock::timestamp_ms(arg2))
    }

    public fun new_reverse<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg1: u8, arg2: &0x2::clock::Clock) : 0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::Price {
        0x9faa8b6dbb84540525c4198e6cbc7af494e00ebb16277c5f1962a6113fe341cc::price::new(parse_sqrt_price_to_decimal(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T1, T0>(arg0), arg1, true), 0x2::clock::timestamp_ms(arg2))
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

