module 0x6cc50f391b12babf92c375f6886a11a8743096fd9f004fe0b4f78e886fe3f540::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > arg2, 0);
        let v0 = 0x6cc50f391b12babf92c375f6886a11a8743096fd9f004fe0b4f78e886fe3f540::full_math_u64::mul_div_ceil(arg0, arg1, arg1 - arg2);
        assert!(v0 >= arg0, 1);
        v0 - arg0
    }

    public fun calculate_sui_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 + arg0 > arg2, 2);
        let v0 = 0x6cc50f391b12babf92c375f6886a11a8743096fd9f004fe0b4f78e886fe3f540::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0);
        assert!(arg1 >= v0, 3);
        arg1 - v0
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 + arg0 > arg1, 4);
        let v0 = 0x6cc50f391b12babf92c375f6886a11a8743096fd9f004fe0b4f78e886fe3f540::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0);
        assert!(arg2 >= v0, 5);
        arg2 - v0
    }

    // decompiled from Move bytecode v6
}

