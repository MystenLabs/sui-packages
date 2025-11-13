module 0x7264c7a35fa3057ede9be33866f3e38cb91a2322773ed9bfa9f20e5783f69fc4::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

