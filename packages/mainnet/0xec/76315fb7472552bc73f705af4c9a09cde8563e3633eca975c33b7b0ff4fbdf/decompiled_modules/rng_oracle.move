module 0xc04019567fddb33fab28ab016dde34a518aad824668411fb4a18fe4a11916e38::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

