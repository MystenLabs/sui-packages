module 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::u64 {
    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::u128::mul_div((arg0 as u128), (arg1 as u128), (arg2 as u128));
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    // decompiled from Move bytecode v6
}

