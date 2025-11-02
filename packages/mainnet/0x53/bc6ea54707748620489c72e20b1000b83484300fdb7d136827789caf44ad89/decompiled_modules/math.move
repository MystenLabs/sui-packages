module 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::math {
    public fun safe_div(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 > 0, 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::errors::division_by_zero());
        arg0 / arg1
    }

    public fun safe_mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::errors::arithmetic_overflow());
        (v0 as u64)
    }

    public fun safe_mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::errors::division_by_zero());
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 0x53bc6ea54707748620489c72e20b1000b83484300fdb7d136827789caf44ad89::errors::arithmetic_overflow());
        (v0 as u64)
    }

    // decompiled from Move bytecode v6
}

