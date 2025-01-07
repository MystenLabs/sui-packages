module 0xdaf9d2d923b1c75f82870c17605163acd5f8aa172821f0356bf3fa4e5be7dad1::math_u128 {
    public fun average(arg0: u128, arg1: u128) : u128 {
        (arg0 & arg1) + (arg0 ^ arg1) / 2
    }

    public fun ceil_div(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun exp(arg0: u128, arg1: u128) : u128 {
        let v0 = 1;
        while (arg1 > 0) {
            if (arg1 & 1 > 0) {
                v0 = v0 * arg0;
            };
            arg1 = arg1 >> 1;
            arg0 = arg0 * arg0;
        };
        v0
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

    public fun quadratic(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : u128 {
        exp(arg0, 2) / 4294967296 * arg1 / 4294967296 + arg2 * arg0 / 4294967296 + arg3
    }

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >> 64 > 0) {
            v2 = arg0 >> 64;
            v1 = v0 << 32;
        };
        if (v2 >> 32 > 0) {
            v2 = v2 >> 32;
            v1 = v1 << 16;
        };
        if (v2 >> 16 > 0) {
            v2 = v2 >> 16;
            v1 = v1 << 8;
        };
        if (v2 >> 8 > 0) {
            v2 = v2 >> 8;
            v1 = v1 << 4;
        };
        if (v2 >> 4 > 0) {
            v2 = v2 >> 4;
            v1 = v1 << 2;
        };
        if (v2 >> 2 > 0) {
            v1 = v1 << 1;
        };
        let v3 = v1 + arg0 / v1 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        let v8 = v7 + arg0 / v7 >> 1;
        let v9 = v8 + arg0 / v8 >> 1;
        min(v9, arg0 / v9)
    }

    public fun sqrt_rounding(arg0: u128, arg1: u8) : u128 {
        let v0 = sqrt(arg0);
        let v1 = v0;
        if (arg1 == 0 && v0 * v0 < arg0) {
            v1 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

