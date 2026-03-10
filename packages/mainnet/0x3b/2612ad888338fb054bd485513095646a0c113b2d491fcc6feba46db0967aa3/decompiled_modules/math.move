module 0x4cf881ad2ba05c0eb54b599897b3606b438b10136f5a6eb52d56781ef5d6f37e::math {
    public(friend) fun find_amount_with_fee(arg0: u64, arg1: u64) : u64 {
        ((((arg0 * 10000) as u128) / ((10000 - arg1) as u128)) as u64)
    }

    public(friend) fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = ((arg2 - arg0) as u128);
        ((((arg1 as u128) * (arg0 as u128) + v0 - 1) / v0) as u64)
    }

    public(friend) fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg2 as u128) / ((arg1 as u128) + (arg0 as u128))) as u64)
    }

    public(friend) fun get_fee_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    // decompiled from Move bytecode v6
}

