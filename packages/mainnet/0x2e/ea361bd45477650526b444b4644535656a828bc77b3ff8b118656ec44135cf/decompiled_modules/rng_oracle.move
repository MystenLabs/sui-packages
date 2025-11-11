module 0x2eea361bd45477650526b444b4644535656a828bc77b3ff8b118656ec44135cf::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

