module 0xefb37677c5c43eb19e019186f0769be08dd42ab18ab1ba7d8dd0a8021d32ede1::sqrt_limit {
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

