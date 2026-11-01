module 0x36b4a91087080d013a45cc5d1ff62d9248719e8375a33b93d3f5696222effde7::bridge {
    public fun active_amount(arg0: bool, arg1: u64) : u64 {
        if (arg0) {
            arg1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

