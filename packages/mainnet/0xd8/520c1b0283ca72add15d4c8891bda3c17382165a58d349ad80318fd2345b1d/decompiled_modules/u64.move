module 0xd8520c1b0283ca72add15d4c8891bda3c17382165a58d349ad80318fd2345b1d::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xd8520c1b0283ca72add15d4c8891bda3c17382165a58d349ad80318fd2345b1d::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

