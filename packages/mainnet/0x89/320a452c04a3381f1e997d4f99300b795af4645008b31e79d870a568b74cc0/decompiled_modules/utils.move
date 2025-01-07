module 0x89320a452c04a3381f1e997d4f99300b795af4645008b31e79d870a568b74cc0::utils {
    public(friend) fun calc_leverage_ratio(arg0: u64, arg1: u64) : u64 {
        ((1000000000000000000 / (1000000000000000000 - (calc_loan_to_value(arg0, arg1) as u128))) as u64)
    }

    public(friend) fun calc_loan_to_value(arg0: u64, arg1: u64) : u64 {
        ((1000000000000000000 * (arg1 as u128) / (arg0 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

