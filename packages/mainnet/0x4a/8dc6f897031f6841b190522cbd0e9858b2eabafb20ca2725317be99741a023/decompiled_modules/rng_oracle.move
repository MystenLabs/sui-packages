module 0x4a8dc6f897031f6841b190522cbd0e9858b2eabafb20ca2725317be99741a023::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

