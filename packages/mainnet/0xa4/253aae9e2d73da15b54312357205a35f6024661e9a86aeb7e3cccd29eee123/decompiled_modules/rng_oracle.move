module 0xa4253aae9e2d73da15b54312357205a35f6024661e9a86aeb7e3cccd29eee123::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

