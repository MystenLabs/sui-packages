module 0x4dcbdb9de03c817ef507846a54f090c9d6d7b15d3b14f1439c65ba6ab9db6c67::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x4dcbdb9de03c817ef507846a54f090c9d6d7b15d3b14f1439c65ba6ab9db6c67::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

