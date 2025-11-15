module 0xa124c1d8626858592b70a37f0a6fbae84a0f69d3d185e3ee8405e68e4c504a52::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

