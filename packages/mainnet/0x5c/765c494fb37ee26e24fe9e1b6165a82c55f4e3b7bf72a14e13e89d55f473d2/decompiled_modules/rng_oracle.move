module 0x5c765c494fb37ee26e24fe9e1b6165a82c55f4e3b7bf72a14e13e89d55f473d2::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

