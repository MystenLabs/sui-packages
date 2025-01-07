module 0x55211eed3629b86b391725d9ab6493e7e102084d2acfaab30e654ca39855ddb5::utils {
    fun d(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 + arg0 * arg0 * arg0
    }

    fun f(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 * arg1 + arg0 * arg0 * arg0 * arg1
    }

    public fun get_input_price_stable(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = (100000000 as u256);
        let v1 = (arg2 as u256) * v0 / (arg5 as u256);
        (((v1 - get_y((((arg0 as u256) * v0 / (arg4 as u256)) as u256) * ((10000 - (arg3 as u128)) as u256) / (10000 as u256) + (arg1 as u256) * v0 / (arg4 as u256), lp_value((arg1 as u128), arg4, (arg2 as u128), arg5), v1)) * (arg5 as u256) / v0) as u64)
    }

    public fun get_input_price_uncorrelated(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128) * (10000 - (arg3 as u128));
        ((v0 * (arg2 as u128) / ((arg1 as u128) * 10000 + v0)) as u64)
    }

    fun get_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        let v1 = 1;
        while (v0 < 255) {
            let v2 = f(arg0, arg2);
            let v3 = if (arg1 > v2) {
                let v4 = (arg1 - v2) / d(arg0, arg2) + v1;
                arg2 = arg2 + v4;
                v4
            } else {
                let v5 = (v2 - arg1) / d(arg0, arg2) + v1;
                arg2 = arg2 - v5;
                v5
            };
            if (v3 <= v1) {
                return arg2
            };
            v0 = v0 + 1;
        };
        arg2
    }

    public fun lp_value(arg0: u128, arg1: u64, arg2: u128, arg3: u64) : u256 {
        let v0 = (100000000 as u256);
        let v1 = (arg0 as u256) * v0 / (arg1 as u256);
        let v2 = (arg2 as u256) * v0 / (arg3 as u256);
        v1 * v2 * (v1 * v1 + v2 * v2)
    }

    // decompiled from Move bytecode v6
}

