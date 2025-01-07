module 0x1d489da3a71fd450e934c890d62d39a14f453ae3f74d2880c563793ce4297756::curves {
    public fun calculate_liquidity_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > arg2, 0);
        let v0 = 0x1d489da3a71fd450e934c890d62d39a14f453ae3f74d2880c563793ce4297756::full_math_u64::mul_div_ceil(arg0, arg1, arg1 - arg2);
        assert!(v0 >= arg0, 1);
        v0 - arg0
    }

    public fun calculate_sui_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 + arg0 > arg2, 2);
        let v0 = 0x1d489da3a71fd450e934c890d62d39a14f453ae3f74d2880c563793ce4297756::full_math_u64::mul_div_ceil(arg1, arg2, arg2 + arg0);
        assert!(arg1 >= v0, 3);
        arg1 - v0
    }

    public fun calculate_token_return(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 + arg0 > arg1, 4);
        let v0 = 0x1d489da3a71fd450e934c890d62d39a14f453ae3f74d2880c563793ce4297756::full_math_u64::mul_div_ceil(arg1, arg2, arg1 + arg0);
        assert!(arg2 >= v0, 5);
        arg2 - v0
    }

    // decompiled from Move bytecode v6
}

