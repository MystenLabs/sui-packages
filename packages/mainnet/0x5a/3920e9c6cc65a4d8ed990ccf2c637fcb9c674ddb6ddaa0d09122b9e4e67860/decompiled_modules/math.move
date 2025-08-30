module 0x5a3920e9c6cc65a4d8ed990ccf2c637fcb9c674ddb6ddaa0d09122b9e4e67860::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

