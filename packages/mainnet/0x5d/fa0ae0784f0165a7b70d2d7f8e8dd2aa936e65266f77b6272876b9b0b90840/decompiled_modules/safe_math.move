module 0x5dfa0ae0784f0165a7b70d2d7f8e8dd2aa936e65266f77b6272876b9b0b90840::safe_math {
    public fun sqrt(arg0: u256) : u256 {
        let v0 = 0x1::u256::try_as_u128(arg0);
        if (0x1::option::is_some<u128>(&v0)) {
            return (0x1::u128::sqrt((arg0 as u128)) as u256)
        };
        let v1 = arg0;
        let v2 = 1;
        let v3 = v2;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v1 = arg0 >> 128;
            v3 = v2 << 64;
        };
        if (v1 >= 18446744073709551616) {
            v1 = v1 >> 64;
            v3 = v3 << 32;
        };
        if (v1 >= 4294967296) {
            v1 = v1 >> 32;
            v3 = v3 << 16;
        };
        if (v1 >= 65536) {
            v1 = v1 >> 16;
            v3 = v3 << 8;
        };
        if (v1 >= 256) {
            v1 = v1 >> 8;
            v3 = v3 << 4;
        };
        if (v1 >= 16) {
            v1 = v1 >> 4;
            v3 = v3 << 2;
        };
        if (v1 >= 8) {
            v3 = v3 << 1;
        };
        let v4 = 0;
        while (v4 < 7) {
            let v5 = v3 + arg0 / v3;
            v3 = v5 >> 1;
            v4 = v4 + 1;
        };
        let v6 = arg0 / v3;
        if (v3 < v6) {
            v3
        } else {
            v6
        }
    }

    public fun mul_div_Q64(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 >> 64
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

