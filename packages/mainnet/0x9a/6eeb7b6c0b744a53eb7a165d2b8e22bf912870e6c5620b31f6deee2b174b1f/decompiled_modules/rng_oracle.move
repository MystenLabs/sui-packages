module 0x9a6eeb7b6c0b744a53eb7a165d2b8e22bf912870e6c5620b31f6deee2b174b1f::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

