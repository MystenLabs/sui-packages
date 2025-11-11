module 0x4a03d5ea4a8aedce398bc55b2858ec4c7058c908ba670220de985687ca2d8fb7::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

