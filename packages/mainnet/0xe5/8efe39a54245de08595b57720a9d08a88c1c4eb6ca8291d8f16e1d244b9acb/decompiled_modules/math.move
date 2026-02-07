module 0xe58efe39a54245de08595b57720a9d08a88c1c4eb6ca8291d8f16e1d244b9acb::math {
    public fun div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        (((arg0 as u128) / (arg1 as u128)) as u64)
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

