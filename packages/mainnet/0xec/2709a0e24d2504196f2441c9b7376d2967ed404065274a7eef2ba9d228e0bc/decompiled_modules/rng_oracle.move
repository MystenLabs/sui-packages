module 0xec2709a0e24d2504196f2441c9b7376d2967ed404065274a7eef2ba9d228e0bc::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

