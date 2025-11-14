module 0x6ab6188534da5b40e54141ab9df82cbc5e46e7d513557d2bb4fc6f14132a33b6::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

