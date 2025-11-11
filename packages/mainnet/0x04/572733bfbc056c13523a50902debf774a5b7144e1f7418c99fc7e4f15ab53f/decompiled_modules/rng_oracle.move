module 0x4572733bfbc056c13523a50902debf774a5b7144e1f7418c99fc7e4f15ab53f::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

