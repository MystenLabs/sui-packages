module 0xf3c69c55d51f9bc610f71c3b926f351b956a84712465a9ffc2115bfec54671b2::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

