module 0x4066c0d138884b0c32a6791c46190101011563a00e1916d31798df2eeb0d68d0::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

