module 0xfa3a7263662610ed8a962b5be8fd0af10bc57869ca6f3d30ccc97f3e63ff3f38::u256 {
    public fun checked_mul(arg0: u256, arg1: u256) : u256 {
        assert!(is_safe_mul(arg0, arg1), 1003);
        arg0 * arg1
    }

    public fun is_safe_mul(arg0: u256, arg1: u256) : bool {
        115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg0 >= arg1
    }

    public fun mul_div(arg0: u256, arg1: u256, arg2: u256) : u256 {
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

