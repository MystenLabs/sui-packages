module 0x7f573fefe6717f4bd3d1ebacc51f0d89cb26b39af82ed705a94da2f71f3098e2::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

