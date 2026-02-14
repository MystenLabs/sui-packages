module 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::math {
    public fun ceil_div(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    public fun compute_merge_pairs(arg0: u64, arg1: u64, arg2: u128) : u64 {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = v0 + v1;
        (((v2 - sqrt(v2 * v2 - 4 * (v0 * v1 - arg2))) / 2) as u64)
    }

    public fun sqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        if (arg0 <= 3) {
            return 1
        };
        let v0 = arg0 / 2 + 1;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

