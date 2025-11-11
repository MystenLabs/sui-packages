module 0xd13044b1e42bc8962270f031c8408d679855d97deba3cb047834a185bb7145e2::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        (arg0 * 1103515245 + 12345) % arg1
    }

    // decompiled from Move bytecode v6
}

