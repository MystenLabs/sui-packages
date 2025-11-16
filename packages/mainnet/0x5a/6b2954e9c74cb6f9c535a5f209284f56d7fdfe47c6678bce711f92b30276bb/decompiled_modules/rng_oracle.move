module 0x5a6b2954e9c74cb6f9c535a5f209284f56d7fdfe47c6678bce711f92b30276bb::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

