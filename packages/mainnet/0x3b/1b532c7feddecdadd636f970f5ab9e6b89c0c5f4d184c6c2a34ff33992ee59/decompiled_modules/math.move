module 0xe76df21ae2a7b9e1c5742f3417fb72cd8b5a176e56c278b2df868b7fd2fd2892::math {
    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

