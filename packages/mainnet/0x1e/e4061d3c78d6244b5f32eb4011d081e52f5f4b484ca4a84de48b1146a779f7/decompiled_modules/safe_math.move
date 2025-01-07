module 0x1ee4061d3c78d6244b5f32eb4011d081e52f5f4b484ca4a84de48b1146a779f7::safe_math {
    public fun add(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0, 1001);
        v0
    }

    public fun div(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 > 0, 1004);
        arg0 / arg1
    }

    public fun min(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun mod(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 != 0, 1005);
        arg0 % arg1
    }

    public fun mul(arg0: u256, arg1: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = arg0 * arg1;
        assert!(v0 / arg0 == arg1, 1003);
        v0
    }

    public fun sub(arg0: u256, arg1: u256) : u256 {
        assert!(arg1 <= arg0, 1002);
        arg0 - arg1
    }

    // decompiled from Move bytecode v6
}

