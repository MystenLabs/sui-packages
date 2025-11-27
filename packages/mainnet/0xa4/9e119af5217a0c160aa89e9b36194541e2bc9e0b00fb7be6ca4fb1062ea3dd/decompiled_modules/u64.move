module 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

