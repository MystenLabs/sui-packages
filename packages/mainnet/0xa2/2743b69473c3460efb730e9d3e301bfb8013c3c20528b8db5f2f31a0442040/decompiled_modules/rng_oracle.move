module 0xa22743b69473c3460efb730e9d3e301bfb8013c3c20528b8db5f2f31a0442040::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

