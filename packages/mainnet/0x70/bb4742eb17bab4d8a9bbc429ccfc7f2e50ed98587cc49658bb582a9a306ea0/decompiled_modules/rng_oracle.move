module 0x70bb4742eb17bab4d8a9bbc429ccfc7f2e50ed98587cc49658bb582a9a306ea0::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

