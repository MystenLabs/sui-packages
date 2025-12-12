module 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xd8fabdb51dd60097fe6c582f62b82404596b1f3a5081a18bbd47118ea1ba863f::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

