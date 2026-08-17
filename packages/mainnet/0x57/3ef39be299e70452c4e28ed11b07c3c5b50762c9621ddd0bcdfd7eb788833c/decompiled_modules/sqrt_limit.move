module 0x570a3a82addc51476c6b9d5635e909d4eb5608f08fdc4a685f2443e9e5ddc9f4::sqrt_limit {
    public(friend) fun bounded(arg0: u128, arg1: bool, arg2: u128, arg3: u128) : u128 {
        if (arg1) {
            let v1 = arg0 * (10000 - 500) / 10000;
            if (v1 < arg2) {
                arg2
            } else {
                v1
            }
        } else {
            let v2 = arg0 * (10000 + 500) / 10000;
            if (v2 > arg3) {
                arg3
            } else {
                v2
            }
        }
    }

    public(friend) fun usable(arg0: u128, arg1: u128, arg2: bool) : bool {
        arg2 && arg1 < arg0 || arg1 > arg0
    }

    // decompiled from Move bytecode v7
}

