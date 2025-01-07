module 0xba6c820b580f95719e82c1a1b70a9e2d6fd7ab4efc897c0ba90d7a40f7e6520b::math {
    public fun add(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        if (arg1 > arg0) {
            0
        } else {
            arg0 - arg1
        }
    }

    // decompiled from Move bytecode v6
}

