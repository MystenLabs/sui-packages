module 0x3bea1aaf8822efd005bfeedeff8f80c33cb56ebc2218775e9ba39a886e1f1ab7::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

