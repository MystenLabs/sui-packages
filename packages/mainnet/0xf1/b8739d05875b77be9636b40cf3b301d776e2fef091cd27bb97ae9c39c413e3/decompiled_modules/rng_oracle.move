module 0xf1b8739d05875b77be9636b40cf3b301d776e2fef091cd27bb97ae9c39c413e3::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

