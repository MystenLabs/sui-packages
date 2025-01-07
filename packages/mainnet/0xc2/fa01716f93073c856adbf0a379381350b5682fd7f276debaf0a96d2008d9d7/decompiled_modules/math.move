module 0xd6a9f9a23ba4bcf9d2d6c37ba315fe6fa059949486b7247d2d25d5232629b0c8::math {
    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

