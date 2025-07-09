module 0x37b46b17052e589a9f7bd7c1b957bf8a83c82c794e998a714a7b4018a227f0e9::math {
    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            0
        } else if (arg0 <= 340282366920938463463374607431768211455) {
            (0x1::u128::sqrt((arg0 as u128)) as u256)
        } else {
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
    }

    // decompiled from Move bytecode v6
}

