module 0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

