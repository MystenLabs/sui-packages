module 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::liquidity_math {
    public fun add_delta(arg0: u128, arg1: 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i128::I128) : u128 {
        let v0 = 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i128::abs_u128(arg1);
        if (0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::i128::is_neg(arg1)) {
            assert!(arg0 >= v0, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::insufficient_liquidity());
            arg0 - v0
        } else {
            assert!(v0 < 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::constants::max_u128() - arg0, 0x7dc900773da3c15a4ae6f37e9ffd0770223facdacb0da045295f1d7639622ef6::errors::insufficient_liquidity());
            arg0 + v0
        }
    }

    // decompiled from Move bytecode v6
}

