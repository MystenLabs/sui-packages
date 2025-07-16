module 0x9ce340dd3df6d3a1bab732b3ebb0d299d75b4f1df216db8de62342c36ed1f168::safe_math {
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
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = v7 + arg0 / v7 >> 1;
        let v9 = v8 + arg0 / v8 >> 1;
        let v10 = v9 + arg0 / v9 >> 1;
        let v11 = arg0 / v10;
        if (v10 < v11) {
            v10
        } else {
            v11
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

