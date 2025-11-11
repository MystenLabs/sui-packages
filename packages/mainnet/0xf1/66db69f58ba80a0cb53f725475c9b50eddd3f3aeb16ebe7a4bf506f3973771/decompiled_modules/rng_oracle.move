module 0xf166db69f58ba80a0cb53f725475c9b50eddd3f3aeb16ebe7a4bf506f3973771::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

