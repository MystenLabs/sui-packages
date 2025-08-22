module 0x59a98b77a932ab36303e4539e3efb8e88109703156591c36b45f47b955ca3938::math {
    public fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) + (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 1001);
        (v0 as u64)
    }

    public fun safe_div_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 != 0, 1003);
        arg0 / arg1
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 1001);
        (v0 as u64)
    }

    public fun safe_sub_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1002);
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

