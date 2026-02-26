module 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x4c91e97c92d1da87211f110d0b1191d4d157a8f47924b129c5febbaf03457711::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

