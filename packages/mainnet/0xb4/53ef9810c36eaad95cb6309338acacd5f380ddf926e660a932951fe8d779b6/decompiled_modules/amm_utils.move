module 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_utils {
    public fun calculate_swap_amount_after_fee(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg0 - 0xb453ef9810c36eaad95cb6309338acacd5f380ddf926e660a932951fe8d779b6::amm_math::safe_mul_div_u64(arg0, arg2, arg1)
    }

    public fun compute_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        arg2 - (((arg1 as u128) * (arg2 as u128) / ((arg1 + calculate_swap_amount_after_fee(arg0, arg3, arg4)) as u128)) as u64)
    }

    // decompiled from Move bytecode v6
}

