module 0x63316497bf9ffac9e3cc4ce1644528796cb624aadd08d218ab7ae61975af1ecd::math {
    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun max_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
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

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun pow(arg0: u64, arg1: u8) : u64 {
        let v0 = 1;
        while (arg1 >= 1) {
            if (arg1 % 2 == 0) {
                arg0 = arg0 * arg0;
                arg1 = arg1 / 2;
                continue
            };
            v0 = v0 * arg0;
            arg1 = arg1 - 1;
        };
        v0
    }

    public fun sqrt(arg0: u64) : u64 {
        let v0 = 18446744073709551616;
        let v1 = 0;
        let v2 = (arg0 as u128);
        while (v0 != 0) {
            if (v2 >= v1 + v0) {
                v2 = v2 - v1 + v0;
                let v3 = v1 >> 1;
                v1 = v3 + v0;
            } else {
                v1 = v1 >> 1;
            };
            v0 = v0 >> 2;
        };
        (v1 as u64)
    }

    public fun sqrt_u128(arg0: u128) : u128 {
        let v0 = 340282366920938463463374607431768211456;
        let v1 = 0;
        let v2 = (arg0 as u256);
        while (v0 != 0) {
            if (v2 >= v1 + v0) {
                v2 = v2 - v1 + v0;
                let v3 = v1 >> 1;
                v1 = v3 + v0;
            } else {
                v1 = v1 >> 1;
            };
            v0 = v0 >> 2;
        };
        (v1 as u128)
    }

    // decompiled from Move bytecode v6
}

