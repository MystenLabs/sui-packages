module 0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::liquidity_math {
    public fun get_amounts_for_liquidity(arg0: u256, arg1: u256, arg2: u256, arg3: u128) : (u64, u64) {
        0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_amounts_for_liquidity(arg0, arg1, arg2, arg3)
    }

    public fun get_liquidity_for_amounts(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64) : u128 {
        0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::get_liquidity_for_amounts(arg0, arg1, arg2, arg3, arg4)
    }

    public fun max_u256(arg0: u256, arg1: u256) : u256 {
        0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::max_u256(arg0, arg1)
    }

    public fun min_u256(arg0: u256, arg1: u256) : u256 {
        0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::min_u256(arg0, arg1)
    }

    public fun mul_div_u256(arg0: u256, arg1: u256, arg2: u256) : u256 {
        0xb073375aba97556eff7a6263fe686a421e3365877dedb6f68ea938e234d0bf85::tick_math::mul_div_u256(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

