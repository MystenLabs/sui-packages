module 0x70d2356a951ed0c3c4fe08fc300a09422dd22f63b27471eb6e4d184a9ae240dc::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

