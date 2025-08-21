module 0xa391020a5b8cf54c903b11d6c436bfa2803f1bc32d0a4bde7d2a610104bbab46::math {
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

