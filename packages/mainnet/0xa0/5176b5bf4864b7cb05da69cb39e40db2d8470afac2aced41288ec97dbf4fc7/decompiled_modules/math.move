module 0x9c6b2ee8c54936e461fd1dc814093101b1c97658bffdeae56d6233b4aff064d::math {
    public fun saturating_sub_u64(arg0: u64, arg1: u64) : u64 {
        if (arg1 >= arg0) {
            return 0
        };
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

