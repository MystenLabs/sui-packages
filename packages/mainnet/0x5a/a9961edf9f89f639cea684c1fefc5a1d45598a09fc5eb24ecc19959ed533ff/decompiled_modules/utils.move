module 0x5aa9961edf9f89f639cea684c1fefc5a1d45598a09fc5eb24ecc19959ed533ff::utils {
    public fun precision_scalar() : u256 {
        1000000000000
    }

    public fun u256_sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            0
        } else if (arg0 <= 3) {
            1
        } else {
            let v1 = (arg0 + 1) / 2;
            while (v1 < arg0) {
                let v2 = arg0 / v1 + v1;
                v1 = v2 / 2;
            };
            arg0
        }
    }

    // decompiled from Move bytecode v6
}

