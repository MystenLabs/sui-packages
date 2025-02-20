module 0xeedca51c1e3302970446810ac44ae813c1313a18f149f6e97f5bbeed035fed7a::utils {
    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

