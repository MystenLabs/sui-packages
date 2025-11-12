module 0x743f10827d7a7b755cc88e01015f39fbb8b5165a6b0d7254f4d34a1f8e1e63b1::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

