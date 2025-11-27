module 0x84f5b46cb359947db3d05f97ee8a6d102d4a104eb54d1918b74c3db7a23ee11e::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x84f5b46cb359947db3d05f97ee8a6d102d4a104eb54d1918b74c3db7a23ee11e::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

