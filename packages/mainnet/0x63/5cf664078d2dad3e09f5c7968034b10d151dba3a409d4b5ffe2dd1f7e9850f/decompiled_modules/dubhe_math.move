module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dubhe_math {
    public fun log2_down(arg0: u256) : u8 {
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 >> 128 > 0) {
            v0 = arg0 >> 128;
            v2 = v1 + 128;
        };
        if (v0 >> 64 > 0) {
            v0 = v0 >> 64;
            v2 = v2 + 64;
        };
        if (v0 >> 32 > 0) {
            v0 = v0 >> 32;
            v2 = v2 + 32;
        };
        if (v0 >> 16 > 0) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 >> 8 > 0) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 >> 4 > 0) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 >> 2 > 0) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 >> 1 > 0) {
            v2 = v2 + 1;
        };
        v2
    }

    public fun min(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun safe_div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 0);
        arg0 / arg1
    }

    public fun safe_mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        assert!(v0 / arg0 == arg1, 0);
        v0
    }

    public fun safe_mul_div(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg1 == arg2) {
            return arg0
        };
        if (arg0 == arg2) {
            return arg1
        };
        let v0 = arg0 / arg2;
        let v1 = arg0 % arg2;
        let v2 = arg1 / arg2;
        let v3 = arg1 % arg2;
        v0 * v2 * arg2 + v0 * v3 + v1 * v2 + v1 * v3 / arg2
    }

    public fun safe_mul_sqrt(arg0: u256, arg1: u256) : u256 {
        if (arg0 < 340282366920938463463374607431768211455 && arg1 < 340282366920938463463374607431768211455) {
            sqrt_down(arg0 * arg1)
        } else {
            sqrt_down(arg0) * sqrt_down(arg1)
        }
    }

    public fun sqrt_down(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << ((log2_down(arg0) >> 1) as u8);
        let v1 = v0 + arg0 / v0 >> 1;
        let v2 = v1 + arg0 / v1 >> 1;
        let v3 = v2 + arg0 / v2 >> 1;
        let v4 = v3 + arg0 / v3 >> 1;
        let v5 = v4 + arg0 / v4 >> 1;
        let v6 = v5 + arg0 / v5 >> 1;
        let v7 = v6 + arg0 / v6 >> 1;
        min(v7, arg0 / v7)
    }

    public(friend) fun windows(arg0: &vector<u256>, arg1: u64) : vector<vector<u256>> {
        assert!(arg1 > 0, 0);
        let v0 = 0x1::vector::empty<vector<u256>>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(arg0) - arg1 + 1) {
            let v2 = 0x1::vector::empty<u256>();
            let v3 = 0;
            while (v3 < arg1) {
                0x1::vector::push_back<u256>(&mut v2, *0x1::vector::borrow<u256>(arg0, v1 + v3));
                v3 = v3 + 1;
            };
            0x1::vector::push_back<vector<u256>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

