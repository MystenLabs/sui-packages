module 0xf18d0a83480bf6a34edd6a6e6cc2b162d3dbd2c7affa88b69d71f9f73b367ad::profitability {
    public fun check_profitability(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (arg1 <= arg0 + arg2) {
            return false
        };
        (arg1 - arg0 - arg2) * 10000 >= arg3 * arg0
    }

    // decompiled from Move bytecode v6
}

