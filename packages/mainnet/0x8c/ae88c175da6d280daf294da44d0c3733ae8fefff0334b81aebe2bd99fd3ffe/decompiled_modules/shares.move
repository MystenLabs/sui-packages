module 0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0x8cae88c175da6d280daf294da44d0c3733ae8fefff0334b81aebe2bd99fd3ffe::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

