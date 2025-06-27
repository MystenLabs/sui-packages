module 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::price_helper {
    public fun get_base(arg0: u16) : u256 {
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::scale();
        v0 + 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint256x256_math::mul_div_round_down((arg0 as u256), v0, (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::basis_point_max() as u256))
    }

    public fun get_exponent(arg0: u32) : u256 {
        assert!(arg0 >= 7340032 && arg0 <= 9437184, 501);
        let v0 = (arg0 as u256);
        if (v0 >= 8388608) {
            v0 - 8388608
        } else {
            115792089237316195423570985008687907853269984665640564039457584007913129639935 - 8388608 - v0 + 1
        }
    }

    public fun get_id_for_price_one() : u32 {
        (8388608 as u32)
    }

    public fun get_id_from_price(arg0: u256, arg1: u16) : u32 {
        assert!(arg0 > 0, 500);
        let v0 = 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint256x256_math::mul_div_round_down(0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint128x128_math::log2(arg0), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::scale(), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint128x128_math::log2(get_base(arg1))) >> 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::constants::scale_offset();
        let v1 = if (!(v0 > 57896044618658097711785492504343953926634992332820282019728792003956564819967)) {
            let v2 = 8388608 + v0;
            assert!(v2 <= (9437184 as u256), 501);
            (v2 as u32)
        } else {
            let v3 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - v0 + 1;
            assert!(v3 <= 8388608 - (7340032 as u256), 501);
            ((8388608 - v3) as u32)
        };
        assert!(v1 >= 7340032 && v1 <= 9437184, 501);
        v1
    }

    public fun get_price_from_id(arg0: u32, arg1: u16) : u256 {
        0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::uint128x128_math::pow(get_base(arg1), get_exponent(arg0))
    }

    public fun get_valid_id_range() : (u32, u32) {
        (7340032, 9437184)
    }

    public fun is_valid_id(arg0: u32) : bool {
        arg0 >= 7340032 && arg0 <= 9437184
    }

    // decompiled from Move bytecode v6
}

