module 0x4ce40eff613f34003745e8591e3772a54a8e32f1cef508e76ec560155c4d8aa6::math {
    public fun average(arg0: u64, arg1: u64) : u64 {
        (arg0 & arg1) + (arg0 ^ arg1) / 2
    }

    public fun ceil_div(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun exp(arg0: u64, arg1: u64) : u64 {
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

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun quadratic(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        exp(arg0, 2) / 65536 * arg1 / 65536 + arg2 * arg0 / 65536 + arg3
    }

    public fun sqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1;
        let v1 = v0;
        let v2 = arg0;
        if (arg0 >> 32 > 0) {
            v2 = arg0 >> 32;
            v1 = v0 << 16;
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

    public fun sqrt_rounding(arg0: u64, arg1: u8) : u64 {
        let v0 = sqrt(arg0);
        let v1 = v0;
        if (arg1 == 0 && v0 * v0 < arg0) {
            v1 = v0 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

