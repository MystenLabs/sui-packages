module 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

