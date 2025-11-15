module 0x1a2ae1d2b89ad02db07bf56eb595e248dd5c2230b11a1b38a5043b4e54e853a::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

