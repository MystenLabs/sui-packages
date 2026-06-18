module 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::sqrt {
    public fun sqrt_u128(arg0: u128) : u128 {
        let v0 = 0;
        let v1 = if (arg0 < 18446744073709551615) {
            arg0
        } else {
            18446744073709551615
        };
        let v2 = v1;
        let v3 = 0;
        while (v0 <= v2) {
            let v4 = v0 + (v2 - v0 >> 1);
            if ((v4 as u256) * (v4 as u256) <= (arg0 as u256)) {
                v3 = v4;
                v0 = v4 + 1;
                continue
            };
            if (v4 == 0) {
                break
            };
            v2 = v4 - 1;
        };
        v3
    }

    public fun sqrt_u128_ceil(arg0: u128) : u128 {
        let v0 = sqrt_u128(arg0);
        if (v0 * v0 == arg0) {
            v0
        } else {
            v0 + 1
        }
    }

    public fun sqrt_u256(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 < 4) {
            return 1
        };
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >= 340282366920938463463374607431768211456) {
            v2 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (v2 >= 18446744073709551616) {
            v2 = v2 >> 64;
            v1 = v1 + 64;
        };
        if (v2 >= 4294967296) {
            v2 = v2 >> 32;
            v1 = v1 + 32;
        };
        if (v2 >= 65536) {
            v2 = v2 >> 16;
            v1 = v1 + 16;
        };
        if (v2 >= 256) {
            v2 = v2 >> 8;
            v1 = v1 + 8;
        };
        if (v2 >= 16) {
            v2 = v2 >> 4;
            v1 = v1 + 4;
        };
        if (v2 >= 4) {
            v1 = v1 + 2;
        };
        let v3 = 1 << (v1 >> 1) + 1;
        let v4 = 0;
        while (v4 < 128) {
            let v5 = v3 + arg0 / v3 >> 1;
            if (v5 >= v3) {
                break
            };
            v3 = v5;
            v4 = v4 + 1;
        };
        if (v3 > 0 && v3 > arg0 / v3) {
            v3 - 1
        } else {
            v3
        }
    }

    public fun sqrt_u64(arg0: u64) : u64 {
        let v0 = 0;
        let v1 = if (arg0 < 4294967295) {
            arg0
        } else {
            4294967295
        };
        let v2 = v1;
        let v3 = 0;
        while (v0 <= v2) {
            let v4 = v0 + (v2 - v0 >> 1);
            if ((v4 as u128) * (v4 as u128) <= (arg0 as u128)) {
                v3 = v4;
                v0 = v4 + 1;
                continue
            };
            if (v4 == 0) {
                break
            };
            v2 = v4 - 1;
        };
        v3
    }

    public fun sqrt_u64_ceil(arg0: u64) : u64 {
        let v0 = sqrt_u64(arg0);
        if (v0 * v0 == arg0) {
            v0
        } else {
            v0 + 1
        }
    }

    // decompiled from Move bytecode v7
}

