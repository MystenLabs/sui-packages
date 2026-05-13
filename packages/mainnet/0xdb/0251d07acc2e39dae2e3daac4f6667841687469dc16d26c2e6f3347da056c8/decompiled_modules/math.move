module 0xdb0251d07acc2e39dae2e3daac4f6667841687469dc16d26c2e6f3347da056c8::math {
    public fun calc_fee(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64)
    }

    public fun calc_sui_for_tokens_fixed(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 700);
        let v0 = ((arg0 as u128) + (arg1 as u128) - 1) / (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 701);
        (v0 as u64)
    }

    public fun calc_tokens_fixed(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= (18446744073709551615 as u128), 701);
        (v0 as u64)
    }

    public fun fee_denominator() : u64 {
        10000
    }

    // decompiled from Move bytecode v7
}

