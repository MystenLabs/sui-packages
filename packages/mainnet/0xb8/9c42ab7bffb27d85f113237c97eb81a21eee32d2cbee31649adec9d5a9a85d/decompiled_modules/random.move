module 0xb89c42ab7bffb27d85f113237c97eb81a21eee32d2cbee31649adec9d5a9a85d::random {
    struct Random has copy, drop, store {
        seed: u64,
    }

    public fun new(arg0: u64) : Random {
        Random{seed: arg0}
    }

    public fun rand(arg0: &mut Random) : u64 {
        arg0.seed = ((9223372036854775783 * (arg0.seed as u128) + 999983 >> 1 & 18446744073709551615) as u64);
        arg0.seed
    }

    public fun rand_n(arg0: &mut Random, arg1: u64) : u64 {
        arg0.seed = ((9223372036854775783 * ((arg0.seed as u128) + 999983) >> 1 & 18446744073709551615) as u64);
        arg0.seed % arg1
    }

    public fun seed(arg0: &mut Random, arg1: u64) {
        arg0.seed = (((arg0.seed as u128) + (arg1 as u128) & 18446744073709551615) as u64);
    }

    public fun seed_rand(arg0: &mut Random, arg1: u64) : u64 {
        arg0.seed = (((arg0.seed as u128) + (arg1 as u128) & 18446744073709551615) as u64);
        arg0.seed = ((9223372036854775783 * ((arg0.seed as u128) + 999983) >> 1 & 18446744073709551615) as u64);
        arg0.seed
    }

    // decompiled from Move bytecode v6
}

