module 0x81960fc8b5740b161eb9c5b8db631b97878cdeb7676c9d5acb5ccade9276c233::math {
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

