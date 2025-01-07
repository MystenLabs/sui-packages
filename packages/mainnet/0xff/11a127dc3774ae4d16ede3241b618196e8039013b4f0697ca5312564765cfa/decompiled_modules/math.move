module 0xff11a127dc3774ae4d16ede3241b618196e8039013b4f0697ca5312564765cfa::math {
    public fun saturating_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

