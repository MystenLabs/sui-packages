module 0xcf5c5e48f8daabddebc95bb10943747f02924a5b9d85f5359efa76e235c34b97::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

