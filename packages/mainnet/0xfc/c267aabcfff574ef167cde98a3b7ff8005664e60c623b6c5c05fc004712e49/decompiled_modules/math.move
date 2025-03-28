module 0xfcc267aabcfff574ef167cde98a3b7ff8005664e60c623b6c5c05fc004712e49::math {
    public fun saturating_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

