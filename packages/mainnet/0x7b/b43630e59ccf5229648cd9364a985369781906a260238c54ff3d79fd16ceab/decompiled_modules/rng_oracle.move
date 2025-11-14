module 0x7bb43630e59ccf5229648cd9364a985369781906a260238c54ff3d79fd16ceab::rng_oracle {
    public fun pick(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            arg0 % arg1
        }
    }

    // decompiled from Move bytecode v6
}

