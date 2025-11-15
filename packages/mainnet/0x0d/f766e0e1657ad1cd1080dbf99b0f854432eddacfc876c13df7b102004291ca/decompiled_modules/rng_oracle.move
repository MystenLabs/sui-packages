module 0xdf766e0e1657ad1cd1080dbf99b0f854432eddacfc876c13df7b102004291ca::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

