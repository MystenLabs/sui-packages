module 0xcd6a6152b61f25e24d97d6b77d2eeab7b1850c4a7e9a588064888c7a7bed2ed::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

