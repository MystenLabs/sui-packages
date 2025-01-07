module 0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::math {
    public(friend) fun find_amount_with_fee(arg0: u64, arg1: u64) : u64 {
        ((((arg0 * 10000) as u128) / ((10000 - arg1) as u128)) as u64)
    }

    public(friend) fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg1 as u128) * (arg0 as u128) / ((arg2 - arg0) as u128)) as u64)
    }

    public(friend) fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public(friend) fun get_fee_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    // decompiled from Move bytecode v6
}

