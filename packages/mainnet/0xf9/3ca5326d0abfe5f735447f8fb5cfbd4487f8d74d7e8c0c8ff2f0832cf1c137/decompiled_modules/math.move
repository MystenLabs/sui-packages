module 0xf93ca5326d0abfe5f735447f8fb5cfbd4487f8d74d7e8c0c8ff2f0832cf1c137::math {
    public fun find_amount_with_fee(arg0: u64, arg1: u64) : u64 {
        ((((arg0 * 10000) as u128) / ((10000 - arg1) as u128)) as u64)
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / ((arg2 - arg0) as u128)) as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public fun get_fee_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    // decompiled from Move bytecode v6
}

