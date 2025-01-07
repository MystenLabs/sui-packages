module 0xaef8e66f7dfdd7d211cabb7b8212a883f1ef5e739b35448360e22ae342593397::safe_math {
    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

