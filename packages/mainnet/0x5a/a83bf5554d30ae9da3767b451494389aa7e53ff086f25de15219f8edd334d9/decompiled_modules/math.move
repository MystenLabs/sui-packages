module 0x5aa83bf5554d30ae9da3767b451494389aa7e53ff086f25de15219f8edd334d9::math {
    public fun safe_compare_mul_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        (arg0 as u128) * (arg1 as u128) >= (arg2 as u128) * (arg3 as u128)
    }

    public fun safe_mul_div_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun safe_sub_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 1);
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

