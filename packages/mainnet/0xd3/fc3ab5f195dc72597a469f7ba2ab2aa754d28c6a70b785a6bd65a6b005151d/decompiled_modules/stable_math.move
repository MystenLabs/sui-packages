module 0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::stable_math {
    fun calculate_constant_k(arg0: u256, arg1: u256) : u256 {
        arg0 * arg0 * arg0 * arg1 + arg1 * arg1 * arg1 * arg0
    }

    public fun compute_initial_lp(arg0: u64, arg1: u64) : u64 {
        (0xd3fc3ab5f195dc72597a469f7ba2ab2aa754d28c6a70b785a6bd65a6b005151d::math128::sqrt((arg0 as u128) * (arg1 as u128)) as u64)
    }

    fun d(arg0: u256, arg1: u256) : u256 {
        3 * arg0 * arg1 * arg1 + arg0 * arg0 * arg0
    }

    fun f(arg0: u256, arg1: u256) : u256 {
        arg0 * arg1 * arg1 * arg1 + arg0 * arg0 * arg0 * arg1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg2 as u256) - get_y(((arg0 + arg1) as u256), calculate_constant_k((arg1 as u256), (arg2 as u256)), (arg2 as u256))) as u64)
    }

    fun get_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = 0;
        while (v0 < 255) {
            let v1 = arg2;
            let v2 = f(arg0, arg2);
            if (v2 < arg1) {
                let v3 = (arg1 - v2) / d(arg0, arg2);
                arg2 = arg2 + v3;
            } else {
                let v4 = (v2 - arg1) / d(arg0, arg2);
                arg2 = arg2 - v4;
            };
            if (arg2 > v1) {
                if (arg2 - v1 <= 1) {
                    return arg2
                };
            } else if (v1 - arg2 <= 1) {
                return arg2
            };
            v0 = v0 + 1;
        };
        arg2
    }

    // decompiled from Move bytecode v6
}

