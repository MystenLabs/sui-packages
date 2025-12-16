module 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xfdf81885becfaa2f617bb179da217a833dae1be112733c36d17e7213668478ba::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

