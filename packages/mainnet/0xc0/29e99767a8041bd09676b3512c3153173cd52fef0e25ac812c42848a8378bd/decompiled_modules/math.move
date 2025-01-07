module 0x6138d631442c9efaa8c83c2396e843521579ff5d8eb1e6d7bd9845c67aede200::math {
    public fun saturating_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

