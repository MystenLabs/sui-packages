module 0x287fa70a38322de1ef11b549da1bd079a66deeb07de6f5ca89ec9ce9e7f35628::math {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 500);
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 501);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

