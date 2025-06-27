module 0xc60e154662882d928a895110b99b602e4d64e7dfc83eaab0412e91f463e49a8b::safe_math {
    public fun mul_div(arg0: u128, arg1: u64, arg2: u64) : u128 {
        if (arg1 == 0) {
            return 0
        };
        assert!(arg2 > 0, 100);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= 340282366920938463463374607431768211455, 101);
        (v0 as u128)
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 100);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1) {
            return arg0 * arg1 / arg2
        };
        if (arg1 > arg2) {
            let v0 = arg1 / arg2;
            if (arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v0) {
                return arg0 * v0
            };
        };
        let v1 = arg0 / arg2;
        assert!(v1 > 0, 101);
        v1 * arg1
    }

    public fun safe_add_u256(arg0: u256, arg1: u256) : u256 {
        assert!(arg0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1, 109);
        arg0 + arg1
    }

    public fun safe_u128_to_u32(arg0: u128) : u32 {
        assert!(arg0 <= 4294967295, 106);
        (arg0 as u32)
    }

    public fun safe_u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 102);
        (arg0 as u64)
    }

    public fun safe_u256_to_u128(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 104);
        (arg0 as u128)
    }

    public fun safe_u256_to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 105);
        (arg0 as u64)
    }

    public fun safe_u64_to_u128(arg0: u64) : u128 {
        (arg0 as u128)
    }

    public fun safe_u64_to_u16(arg0: u64) : u16 {
        assert!(arg0 <= 65535, 107);
        (arg0 as u16)
    }

    public fun safe_u64_to_u32(arg0: u64) : u32 {
        assert!(arg0 <= 4294967295, 103);
        (arg0 as u32)
    }

    public fun safe_u64_to_u8(arg0: u64) : u8 {
        assert!(arg0 <= 255, 108);
        (arg0 as u8)
    }

    // decompiled from Move bytecode v6
}

