module 0x6bc1b4b3df8e0abd34bc3882d5bdea2fd518be40a1a3ebe6242974529978ab2d::bridge {
    public fun active_amount(arg0: bool, arg1: u64) : u64 {
        if (arg0) {
            arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

