module 0x30683aa5e953b67a31af7b213bb9c4cd3b41c98d1821065d50f6fd67e111a9dd::math {
    public fun compute_weight(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 == 0) {
            let v1 = mul_factor(arg0, arg2, arg3);
            assert!(v1 > 0, 2);
            v1
        } else {
            assert!(arg1 >= arg2 && arg1 <= arg3, 1);
            let v2 = mul_factor(arg0, arg2, arg3);
            let v3 = mul_factor(arg0, arg1, arg3);
            assert!(v2 > 0, 2);
            assert!(v3 > 0, 2);
            v2 + v3
        }
    }

    public fun mul_factor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0, 0);
        ((((arg0 as u128) * (arg1 as u128) + (arg2 as u128) / 2) / (arg2 as u128)) as u64)
    }

    public fun mul_factor_u128(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 0);
        (arg0 * arg1 + arg2 / 2) / arg2
    }

    // decompiled from Move bytecode v6
}

