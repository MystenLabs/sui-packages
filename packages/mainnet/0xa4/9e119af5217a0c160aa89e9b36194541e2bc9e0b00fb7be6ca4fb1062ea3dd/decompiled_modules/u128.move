module 0xa49e119af5217a0c160aa89e9b36194541e2bc9e0b00fb7be6ca4fb1062ea3dd::u128 {
    public fun checked_mul(arg0: u128, arg1: u128) : u128 {
        assert!(is_safe_mul(arg0, arg1), 1003);
        arg0 * arg1
    }

    public fun is_safe_mul(arg0: u128, arg1: u128) : bool {
        340282366920938463463374607431768211455 / arg0 >= arg1
    }

    public fun mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        let (v0, v1) = if (arg0 >= arg1) {
            (arg0, arg1)
        } else {
            (arg1, arg0)
        };
        assert!(arg2 > 0, 1002);
        if (!is_safe_mul(v0, v1)) {
            checked_mul(v0 / arg2, v1) + checked_mul(v0 % arg2, v1) / arg2
        } else {
            v0 * v1 / arg2
        }
    }

    // decompiled from Move bytecode v6
}

