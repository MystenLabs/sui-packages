module 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_math {
    public fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) + (arg1 as u128)) as u64)
    }

    public fun safe_div_u128_to_u64(arg0: u128, arg1: u128) : u64 {
        assert!(arg1 > 0, 0);
        ((arg0 / arg1) as u64)
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

