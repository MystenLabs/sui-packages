module 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::u128x128 {
    public fun pow(arg0: u256, arg1: 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::I32) : u256 {
        let v0 = false;
        let v1 = v0;
        if (arg0 == 0) {
            return 0
        };
        if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::eq(arg1, 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::zero())) {
            return 1 << 128
        };
        let v2 = (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::abs_u32(arg1) as u128);
        assert!(v2 < 1048576, 3);
        if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i32::is_neg(arg1)) {
            v1 = !v0;
        };
        let v3 = 0;
        if (v2 < 1048576) {
            v3 = 1 << 128;
            let v4 = arg0;
            if (arg0 >= 1 << 128) {
                v4 = max_u() / arg0;
                v1 = !v1;
            };
            let v5 = 1;
            while (v5 <= v2) {
                if (v2 & v5 != 0) {
                    let v6 = v3 * v4;
                    v3 = v6 >> 128;
                };
                let v7 = v4 * v4;
                v4 = v7 >> 128;
                v5 = v5 << 1;
            };
        };
        if (v3 == 0) {
            abort 13906834771344293896
        };
        if (v1) {
            max_u() / v3
        } else {
            v3
        }
    }

    public fun from_u128x128(arg0: u256) : (u128, u128) {
        (((arg0 >> 128) as u128), ((arg0 & 340282366920938463463374607431768211455) as u128))
    }

    public fun from_u128x128_dec(arg0: u256, arg1: u8) : (u128, u128) {
        let v0 = 0;
        let v1 = 1;
        while (v1 < 128) {
            if (((arg0 & 340282366920938463463374607431768211455) as u128) & 1 << 128 - v1 != 0) {
                let v2 = 0x1::u128::pow(10, arg1 + 5) / 0x1::u128::pow(2, v1);
                if (v2 == 0) {
                    break
                };
                v0 = v0 + v2;
            };
            v1 = v1 + 1;
        };
        (((arg0 >> 128) as u128), v0 / 0x1::u128::pow(10, 5))
    }

    public fun log2(arg0: u256) : (u256, bool) {
        if (arg0 == 1) {
            return (to_u128x128(128, 0), false)
        };
        if (arg0 == 0) {
            abort 13906834423451811846
        };
        let v0 = arg0 >> 128 - 127;
        arg0 = v0;
        let v1 = if (v0 >= 170141183460469231731687303715884105728) {
            true
        } else {
            arg0 = 28948022309329048855892746252171976963317496166410141009864396001978282409984 / v0;
            false
        };
        let (v2, _) = 0xfd4fb46fa9cab466edbc46e95c9f647644018022780041b53c0f39602dfb8d8a::bit_math::most_significant_bit(((arg0 >> 127) as u256));
        let v4 = (v2 as u256) << 127;
        let v5 = arg0 >> v2;
        let v6 = v5;
        if (v5 != 170141183460469231731687303715884105728) {
            let v7 = 1 << 127 - 1;
            while (v7 > 0) {
                v6 = v6 * v6 >> 127;
                if (v6 >= 1 << 127 + 1) {
                    v4 = v4 + v7;
                    v6 = v6 >> 1;
                };
                v7 = v7 >> 1;
            };
        };
        (v4 << 128 - 127, v1)
    }

    fun max_u() : u256 {
        let v0 = (128 as u16) + (128 as u16);
        assert!(v0 <= 256, 13906834586660241407);
        if (v0 == 256) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            (1 << 128 + 128) - 1
        }
    }

    public fun to_u128x128(arg0: u128, arg1: u8) : u256 {
        ((arg0 as u256) << 128) / 0x1::u256::pow(10, arg1)
    }

    // decompiled from Move bytecode v6
}

