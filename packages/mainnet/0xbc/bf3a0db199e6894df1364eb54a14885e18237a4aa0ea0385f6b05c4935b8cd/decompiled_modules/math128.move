module 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::math128 {
    public fun average(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0 + (arg1 - arg0) / 2
        } else {
            arg1 + (arg0 - arg1) / 2
        }
    }

    public fun ceil_div(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            assert!(arg1 != 0, 4);
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun clamp(arg0: u128, arg1: u128, arg2: u128) : u128 {
        min(arg2, max(arg1, arg0))
    }

    public fun floor_log2(arg0: u128) : u8 {
        let v0 = 0;
        assert!(arg0 != 0, 1);
        let v1 = 64;
        while (v1 > 0) {
            if (arg0 >= 1 << v1) {
                arg0 = arg0 >> v1;
                v0 = v0 + v1;
            };
            v1 = v1 >> 1;
        };
        v0
    }

    public fun gcd(arg0: u128, arg1: u128) : u128 {
        let (v0, v1) = if (arg0 > arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        let v2 = v1;
        let v3 = v0;
        while (v2 != 0) {
            let v4 = v2;
            v2 = v0 % v2;
            v3 = v4;
        };
        v3
    }

    public fun log2(arg0: u128) : 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point32::FixedPoint32 {
        let v0 = floor_log2(arg0);
        let v1 = if (arg0 >= 4294967296) {
            arg0 >> v0 - 32
        } else {
            arg0 << 32 - v0
        };
        let v2 = 0;
        let v3 = 2147483648;
        while (v3 != 0) {
            let v4 = v1 * v1 >> 32;
            v1 = v4;
            if (v4 >= 8589934592) {
                v2 = v2 + v3;
                v1 = v4 >> 1;
            };
            v3 = v3 >> 1;
        };
        0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point32::create_from_raw_value(((v0 as u64) << 32) + v2)
    }

    public fun log2_64(arg0: u128) : 0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::FixedPoint64 {
        let v0 = floor_log2(arg0);
        let v1 = if (arg0 >= 9223372036854775808) {
            arg0 >> v0 - 63
        } else {
            arg0 << 63 - v0
        };
        let v2 = 0;
        let v3 = 9223372036854775808;
        while (v3 != 0) {
            let v4 = v1 * v1 >> 63;
            v1 = v4;
            if (v4 >= 18446744073709551616) {
                v2 = v2 + v3;
                v1 = v4 >> 1;
            };
            v3 = v3 >> 1;
        };
        0x751ee08016d4c231062752e62d85bb0ee2eade627cd7637bf170645720e708b5::fixed_point64::create_from_raw_value(((v0 as u128) << 64) + v2)
    }

    public fun max(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 4);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun pow(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0;
        if (arg1 == 0) {
            1
        } else {
            let v2 = 1;
            while (arg1 > 1) {
                if (arg1 % 2 == 1) {
                    v2 = v2 * v0;
                };
                arg1 = arg1 / 2;
                v0 = v0 * v0;
            };
            v2 * v0
        }
    }

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << floor_log2(arg0) + 1 >> 1;
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        min(v5, arg0 / v5)
    }

    // decompiled from Move bytecode v6
}

