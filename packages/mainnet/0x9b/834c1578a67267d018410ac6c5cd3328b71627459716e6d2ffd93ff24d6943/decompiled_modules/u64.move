module 0x9b834c1578a67267d018410ac6c5cd3328b71627459716e6d2ffd93ff24d6943::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x9b834c1578a67267d018410ac6c5cd3328b71627459716e6d2ffd93ff24d6943::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

