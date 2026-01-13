module 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math {
    public fun get_u64_max_u256() : u256 {
        18446744073709551615
    }

    public fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) + (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 103);
        (v0 as u64)
    }

    public fun safe_div_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 != 0, 105);
        arg0 / arg1
    }

    public fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 103);
        (v0 as u64)
    }

    public fun safe_sub_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 104);
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

