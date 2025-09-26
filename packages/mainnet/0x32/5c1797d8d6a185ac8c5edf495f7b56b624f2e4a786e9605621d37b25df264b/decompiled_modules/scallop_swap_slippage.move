module 0x325c1797d8d6a185ac8c5edf495f7b56b624f2e4a786e9605621d37b25df264b::scallop_swap_slippage {
    public fun check_slippage<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) {
        assert!(arg2 <= 10000, 0);
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 >= arg1) {
            return
        };
        assert!(0x795ba4c936a59cf8daf05b5f695656cd42b6bb131f5c14c99a03c536bba72a2a::decimal::ge(0x795ba4c936a59cf8daf05b5f695656cd42b6bb131f5c14c99a03c536bba72a2a::decimal::from(v0), 0x795ba4c936a59cf8daf05b5f695656cd42b6bb131f5c14c99a03c536bba72a2a::decimal::sub(0x795ba4c936a59cf8daf05b5f695656cd42b6bb131f5c14c99a03c536bba72a2a::decimal::from(arg1), 0x795ba4c936a59cf8daf05b5f695656cd42b6bb131f5c14c99a03c536bba72a2a::decimal::mul(0x795ba4c936a59cf8daf05b5f695656cd42b6bb131f5c14c99a03c536bba72a2a::decimal::from(arg1), 0x795ba4c936a59cf8daf05b5f695656cd42b6bb131f5c14c99a03c536bba72a2a::decimal::from_bps(arg2)))), 1);
    }

    // decompiled from Move bytecode v6
}

