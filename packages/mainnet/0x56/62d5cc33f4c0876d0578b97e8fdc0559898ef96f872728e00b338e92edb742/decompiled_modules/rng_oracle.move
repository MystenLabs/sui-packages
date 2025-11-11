module 0x5662d5cc33f4c0876d0578b97e8fdc0559898ef96f872728e00b338e92edb742::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

