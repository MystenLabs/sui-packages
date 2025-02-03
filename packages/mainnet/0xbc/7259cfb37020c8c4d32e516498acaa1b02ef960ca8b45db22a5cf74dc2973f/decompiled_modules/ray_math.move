module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math {
    public fun log2(arg0: u256) : u8 {
        let v0 = 0;
        let v1 = v0;
        if (arg0 >> 128 > 0) {
            arg0 = arg0 >> 128;
            v1 = v0 + 128;
        };
        if (arg0 >> 64 > 0) {
            arg0 = arg0 >> 64;
            v1 = v1 + 64;
        };
        if (arg0 >> 32 > 0) {
            arg0 = arg0 >> 32;
            v1 = v1 + 32;
        };
        if (arg0 >> 16 > 0) {
            arg0 = arg0 >> 16;
            v1 = v1 + 16;
        };
        if (arg0 >> 8 > 0) {
            arg0 = arg0 >> 8;
            v1 = v1 + 8;
        };
        if (arg0 >> 4 > 0) {
            arg0 = arg0 >> 4;
            v1 = v1 + 4;
        };
        if (arg0 >> 2 > 0) {
            arg0 = arg0 >> 2;
            v1 = v1 + 2;
        };
        if (arg0 >> 1 > 0) {
            v1 = v1 + 1;
        };
        v1
    }

    public fun max(arg0: u256, arg1: u256) : u256 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun ray() : u256 {
        1000000000000000000000000000
    }

    public fun ray_div(arg0: u256, arg1: u256) : u256 {
        (arg0 * 1000000000000000000000000000 + arg1 / 2) / arg1
    }

    public fun ray_ln2() : u256 {
        693147180559945309417232121
    }

    public fun ray_log2(arg0: u256) : u256 {
        assert!(arg0 >= 1000000000000000000000000000, 0);
        let v0 = log2(arg0 / 1000000000000000000000000000);
        let v1 = (v0 as u256) * 1000000000000000000000000000;
        let v2 = v1;
        let v3 = arg0 >> v0;
        let v4 = v3;
        if (v3 == 1000000000000000000000000000) {
            return v1
        };
        let v5 = 500000000000000000000000000;
        while (v5 > 0) {
            v4 = v4 * v4 / 1000000000000000000000000000;
            if (v4 >= 2000000000000000000000000000) {
                v2 = v2 + v5;
                v4 = v4 >> 1;
            };
            v5 = v5 >> 1;
        };
        v2
    }

    public fun ray_mul(arg0: u256, arg1: u256) : u256 {
        (arg0 * arg1 + 1000000000000000000000000000 / 2) / 1000000000000000000000000000
    }

    // decompiled from Move bytecode v6
}

