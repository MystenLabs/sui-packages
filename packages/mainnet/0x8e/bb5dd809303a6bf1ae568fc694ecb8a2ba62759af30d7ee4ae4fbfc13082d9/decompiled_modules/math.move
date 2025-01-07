module 0x8ebb5dd809303a6bf1ae568fc694ecb8a2ba62759af30d7ee4ae4fbfc13082d9::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

