module 0x46bc54e0adfa1eb7a5589c0d4431a71fee938c06d5b60576b033d60672759e81::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x46bc54e0adfa1eb7a5589c0d4431a71fee938c06d5b60576b033d60672759e81::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

