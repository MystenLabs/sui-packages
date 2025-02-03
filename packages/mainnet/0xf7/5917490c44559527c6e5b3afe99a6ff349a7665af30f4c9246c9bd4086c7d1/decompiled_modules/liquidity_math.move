module 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::liquidity_math {
    public fun add_delta(arg0: u128, arg1: 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::I128) : u128 {
        let v0 = 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::abs_u128(arg1);
        if (0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::i128::is_neg(arg1)) {
            assert!(arg0 >= v0, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::insufficient_liquidity());
            arg0 - v0
        } else {
            assert!(v0 < 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::constants::max_u128() - arg0, 0xf75917490c44559527c6e5b3afe99a6ff349a7665af30f4c9246c9bd4086c7d1::errors::insufficient_liquidity());
            arg0 + v0
        }
    }

    // decompiled from Move bytecode v6
}

