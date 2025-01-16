module 0x923dfcc4e38715d1e3bc21d3d9fbe19a126f9396bbecc203fc27415433a5425b::amm_math {
    public fun safe_compare_mul_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg0 as u128) * (arg1 as u128) >= (arg2 as u128) * (arg3 as u128)
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

