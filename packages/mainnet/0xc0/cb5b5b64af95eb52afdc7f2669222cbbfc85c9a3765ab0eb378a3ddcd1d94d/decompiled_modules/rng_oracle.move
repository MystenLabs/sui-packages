module 0xc0cb5b5b64af95eb52afdc7f2669222cbbfc85c9a3765ab0eb378a3ddcd1d94d::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

