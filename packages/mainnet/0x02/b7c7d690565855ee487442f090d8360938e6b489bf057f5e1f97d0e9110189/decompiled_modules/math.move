module 0x2b7c7d690565855ee487442f090d8360938e6b489bf057f5e1f97d0e9110189::math {
    public fun ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + ((arg2 - 1) as u128)) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

