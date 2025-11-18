module 0x8b4a56d1811aeaeecfda30975d286200e5f27d11622246b3acf6115399b51592::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

