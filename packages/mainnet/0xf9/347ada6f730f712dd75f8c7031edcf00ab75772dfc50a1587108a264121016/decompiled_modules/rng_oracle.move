module 0xf9347ada6f730f712dd75f8c7031edcf00ab75772dfc50a1587108a264121016::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

