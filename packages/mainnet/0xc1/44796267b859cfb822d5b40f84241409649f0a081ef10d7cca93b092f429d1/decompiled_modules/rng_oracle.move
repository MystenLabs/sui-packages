module 0xc144796267b859cfb822d5b40f84241409649f0a081ef10d7cca93b092f429d1::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

