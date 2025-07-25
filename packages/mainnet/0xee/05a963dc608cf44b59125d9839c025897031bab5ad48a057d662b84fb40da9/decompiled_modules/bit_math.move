module 0xee05a963dc608cf44b59125d9839c025897031bab5ad48a057d662b84fb40da9::bit_math {
    public fun closest_bit_left(arg0: u128, arg1: u8) : u128 {
        let v0 = arg0 >> arg1;
        if (v0 == 0) {
            340282366920938463463374607431768211455
        } else {
            (least_significant_bit(v0) as u128) + (arg1 as u128)
        }
    }

    public fun closest_bit_left_u256(arg0: u256, arg1: u8) : u256 {
        let v0 = arg0 >> arg1;
        if (v0 == 0) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            (least_significant_bit_u256(v0) as u256) + (arg1 as u256)
        }
    }

    public fun closest_bit_right(arg0: u128, arg1: u8) : u128 {
        assert!(arg1 < 128, 0);
        let v0 = if (arg1 >= 127) {
            0
        } else {
            127 - arg1
        };
        let v1 = arg0 << v0;
        if (v1 == 0) {
            340282366920938463463374607431768211455
        } else {
            (most_significant_bit(v1) as u128) - (v0 as u128)
        }
    }

    public fun closest_bit_right_u256(arg0: u256, arg1: u8) : u256 {
        assert!(arg1 < 255, 0);
        let v0 = if (arg1 >= 255) {
            0
        } else {
            255 - arg1
        };
        let v1 = arg0 << v0;
        if (v1 == 0) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            (most_significant_bit_u256(v1) as u256) - (v0 as u256)
        }
    }

    public fun least_significant_bit(arg0: u128) : u8 {
        if (arg0 == 0) {
            return 127
        };
        let v0 = 0;
        let v1 = arg0 << 64;
        if (v1 != 0) {
            arg0 = v1;
            v0 = 64;
        };
        let v2 = arg0 << 32;
        if (v2 != 0) {
            arg0 = v2;
            v0 = v0 + 32;
        };
        let v3 = arg0 << 16;
        if (v3 != 0) {
            arg0 = v3;
            v0 = v0 + 16;
        };
        let v4 = arg0 << 8;
        if (v4 != 0) {
            arg0 = v4;
            v0 = v0 + 8;
        };
        let v5 = arg0 << 4;
        if (v5 != 0) {
            arg0 = v5;
            v0 = v0 + 4;
        };
        let v6 = arg0 << 2;
        if (v6 != 0) {
            arg0 = v6;
            v0 = v0 + 2;
        };
        if (arg0 << 1 != 0) {
            v0 = v0 + 1;
        };
        127 - v0
    }

    public fun least_significant_bit_u256(arg0: u256) : u8 {
        if (arg0 == 0) {
            return 255
        };
        let v0 = 0;
        let v1 = arg0 << 128;
        if (v1 != 0) {
            arg0 = v1;
            v0 = 128;
        };
        let v2 = arg0 << 64;
        if (v2 != 0) {
            arg0 = v2;
            v0 = v0 + 64;
        };
        let v3 = arg0 << 32;
        if (v3 != 0) {
            arg0 = v3;
            v0 = v0 + 32;
        };
        let v4 = arg0 << 16;
        if (v4 != 0) {
            arg0 = v4;
            v0 = v0 + 16;
        };
        let v5 = arg0 << 8;
        if (v5 != 0) {
            arg0 = v5;
            v0 = v0 + 8;
        };
        let v6 = arg0 << 4;
        if (v6 != 0) {
            arg0 = v6;
            v0 = v0 + 4;
        };
        let v7 = arg0 << 2;
        if (v7 != 0) {
            arg0 = v7;
            v0 = v0 + 2;
        };
        if (arg0 << 1 != 0) {
            v0 = v0 + 1;
        };
        255 - v0
    }

    public fun most_significant_bit(arg0: u128) : u8 {
        let v0 = 0;
        if (arg0 > 18446744073709551615) {
            arg0 = arg0 >> 64;
            v0 = 64;
        };
        if (arg0 > 4294967295) {
            arg0 = arg0 >> 32;
            v0 = v0 + 32;
        };
        if (arg0 > 65535) {
            arg0 = arg0 >> 16;
            v0 = v0 + 16;
        };
        if (arg0 > 255) {
            arg0 = arg0 >> 8;
            v0 = v0 + 8;
        };
        if (arg0 > 15) {
            arg0 = arg0 >> 4;
            v0 = v0 + 4;
        };
        if (arg0 > 3) {
            arg0 = arg0 >> 2;
            v0 = v0 + 2;
        };
        if (arg0 > 1) {
            v0 = v0 + 1;
        };
        v0
    }

    public fun most_significant_bit_u128(arg0: u128) : u8 {
        most_significant_bit(arg0)
    }

    public fun most_significant_bit_u256(arg0: u256) : u8 {
        let v0 = 0;
        if (arg0 > 340282366920938463463374607431768211455) {
            arg0 = arg0 >> 128;
            v0 = 128;
        };
        if (arg0 > 18446744073709551615) {
            arg0 = arg0 >> 64;
            v0 = v0 + 64;
        };
        if (arg0 > 4294967295) {
            arg0 = arg0 >> 32;
            v0 = v0 + 32;
        };
        if (arg0 > 65535) {
            arg0 = arg0 >> 16;
            v0 = v0 + 16;
        };
        if (arg0 > 255) {
            arg0 = arg0 >> 8;
            v0 = v0 + 8;
        };
        if (arg0 > 15) {
            arg0 = arg0 >> 4;
            v0 = v0 + 4;
        };
        if (arg0 > 3) {
            arg0 = arg0 >> 2;
            v0 = v0 + 2;
        };
        if (arg0 > 1) {
            v0 = v0 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

