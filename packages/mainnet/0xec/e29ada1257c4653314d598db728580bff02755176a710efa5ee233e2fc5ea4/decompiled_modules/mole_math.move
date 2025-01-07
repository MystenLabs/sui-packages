module 0xece29ada1257c4653314d598db728580bff02755176a710efa5ee233e2fc5ea4::mole_math {
    public fun add_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) + (arg1 as u128)
    }

    public fun almost_equal(arg0: u64, arg1: u64, arg2: u64) : bool {
        let v0 = max(arg0, arg1);
        mul_to_u128(v0 - min(arg0, arg1), 10000) <= mul_to_u128(arg2, v0)
    }

    public fun almost_equal_u128(arg0: u128, arg1: u128, arg2: u64) : bool {
        let v0 = max_u128(arg0, arg1);
        (v0 - min_u128(arg0, arg1)) * (10000 as u128) <= v0 * (arg2 as u128)
    }

    public fun max(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= arg1) {
            return arg0
        };
        arg1
    }

    public fun max_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 >= arg1) {
            return arg0
        };
        arg1
    }

    public fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            return arg0
        };
        arg1
    }

    public fun min_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 < arg1) {
            return arg0
        };
        arg1
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 != 0, 2000);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun mul_div128(arg0: u64, arg1: u64, arg2: u128) : u64 {
        assert!(arg2 != 0, 2000);
        (((arg0 as u128) * (arg1 as u128) / arg2) as u64)
    }

    public fun mul_div_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 != 0, 2000);
        (((arg0 as u256) * (arg1 as u256) / (arg2 as u256)) as u128)
    }

    public fun mul_to_u128(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    // decompiled from Move bytecode v6
}

