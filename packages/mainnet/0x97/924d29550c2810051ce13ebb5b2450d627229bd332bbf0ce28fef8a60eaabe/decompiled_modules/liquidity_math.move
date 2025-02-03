module 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::liquidity_math {
    public fun add_delta(arg0: u128, arg1: 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i128::I128) : u128 {
        let v0 = 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i128::abs_u128(arg1);
        if (0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::i128::is_neg(arg1)) {
            assert!(arg0 >= v0, 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::errors::insufficient_liquidity());
            arg0 - v0
        } else {
            assert!(v0 < 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::constants::max_u128() - arg0, 0x97924d29550c2810051ce13ebb5b2450d627229bd332bbf0ce28fef8a60eaabe::errors::insufficient_liquidity());
            arg0 + v0
        }
    }

    // decompiled from Move bytecode v6
}

