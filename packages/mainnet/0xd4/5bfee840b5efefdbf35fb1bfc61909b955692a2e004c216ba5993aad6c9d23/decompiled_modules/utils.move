module 0xd45bfee840b5efefdbf35fb1bfc61909b955692a2e004c216ba5993aad6c9d23::utils {
    public(friend) fun calc_leverage_ratio(arg0: u64, arg1: u64) : u64 {
        ((1000000000000000000 / (1000000000000000000 - (calc_loan_to_value(arg0, arg1) as u128))) as u64)
    }

    public(friend) fun calc_loan_to_value(arg0: u64, arg1: u64) : u64 {
        ((1000000000000000000 * (arg1 as u128) / (arg0 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

