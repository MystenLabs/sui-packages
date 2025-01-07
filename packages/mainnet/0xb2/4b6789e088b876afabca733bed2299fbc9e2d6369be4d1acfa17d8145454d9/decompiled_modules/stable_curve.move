module 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_curve {
    public fun coin_in(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128) : u128 {
        let v0 = (arg2 as u256);
        let v1 = (arg1 as u256);
        let v2 = (arg4 as u256) * 1000000000 / v0;
        (((get_y((arg3 as u256) * 1000000000 / v1 - (arg0 as u256) * 1000000000 / v1, lp_value(arg4, arg2, arg3, arg1), v2) - v2) * v0 / 1000000000) as u128)
    }

    public fun coin_out(arg0: u128, arg1: u64, arg2: u64, arg3: u128, arg4: u128) : u128 {
        let v0 = (arg1 as u256);
        let v1 = (arg2 as u256);
        let v2 = (arg4 as u256) * 1000000000 / v1;
        (((v2 - get_y((arg0 as u256) * 1000000000 / v0 + (arg3 as u256) * 1000000000 / v0, lp_value(arg3, arg1, arg4, arg2), v2)) * v1 / 1000000000) as u128)
    }

    fun d(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 + arg0 * arg0 * arg0
    }

    fun f(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 * arg1 + arg1 * arg0 * arg0 * arg0
    }

    fun get_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        while (v0 < 255) {
            let v1 = f(arg0, arg2);
            let v2 = if (v1 < arg1) {
                let v3 = (arg1 - v1) / d(arg0, arg2) + 1;
                arg2 = arg2 + v3;
                v3
            } else {
                let v4 = (v1 - arg1) / d(arg0, arg2);
                arg2 = arg2 - v4;
                v4
            };
            if (v2 <= 1) {
                return arg2
            };
            v0 = v0 + 1;
        };
        arg2
    }

    public fun lp_value(arg0: u128, arg1: u64, arg2: u128, arg3: u64) : u256 {
        let v0 = (arg0 as u256) * 1000000000 / (arg1 as u256);
        let v1 = (arg2 as u256) * 1000000000 / (arg3 as u256);
        v0 * v1 * (v0 * v0 + v1 * v1)
    }

    // decompiled from Move bytecode v6
}

