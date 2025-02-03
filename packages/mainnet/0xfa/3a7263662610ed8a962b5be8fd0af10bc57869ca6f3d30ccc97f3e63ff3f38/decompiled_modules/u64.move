module 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

