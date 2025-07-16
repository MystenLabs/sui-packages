module 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::price_helper {
    public fun get_base(arg0: u16) : u128 {
        let v0 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::scale_64x64();
        v0 + 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::mul_div_u128((arg0 as u128), v0, (0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::constants::basis_point_max() as u128))
    }

    public fun get_exponent(arg0: u32) : u128 {
        assert!(arg0 >= 7340033 && arg0 <= 9437183, 501);
        let v0 = (arg0 as u128);
        let v1 = (8388608 as u128);
        if (v0 >= v1) {
            v0 - v1
        } else {
            340282366920938463463374607431768211455 - v1 - v0 + 1
        }
    }

    public fun get_id_for_price_one() : u32 {
        8388608
    }

    public fun get_id_from_price(arg0: u128, arg1: u16) : u32 {
        assert!(arg0 > 0, 500);
        if (arg0 < 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::scale_64x64() >> 40) {
            return 7340033
        };
        let v0 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::log2(arg0);
        if (v0 > 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::scale_64x64() >> 8) {
            return 9437183
        };
        let v1 = 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::div(v0, 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::log2(get_base(arg1))) >> 0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::constants::scale_offset();
        let v2 = if (!(v1 > 170141183460469231731687303715884105727)) {
            let v3 = (8388608 as u128) + v1;
            assert!(v3 <= (9437183 as u128), 501);
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u32(v3)
        } else {
            let v4 = 340282366920938463463374607431768211455 - v1 + 1;
            assert!(v4 <= (8388608 as u128) - (7340033 as u128), 501);
            0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::safe_math::u128_to_u32((8388608 as u128) - v4)
        };
        assert!(v2 >= 7340033 && v2 <= 9437183, 501);
        v2
    }

    public fun get_price_from_id(arg0: u32, arg1: u16) : u128 {
        0xfa6ab4a4828995e6fc9c348d675185ba581450273f6398640d9fb151492b6a9c::q64x64::pow(get_base(arg1), get_exponent(arg0))
    }

    public fun get_valid_id_range() : (u32, u32) {
        (7340033, 9437183)
    }

    public fun is_valid_id(arg0: u32) : bool {
        arg0 >= 7340033 && arg0 <= 9437183
    }

    // decompiled from Move bytecode v6
}

