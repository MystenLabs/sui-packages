module 0xae3ca299062e6181fe24188a1c41207eaae40ea046becbc10e1fe45ab5198155::math {
    public fun saturating_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

