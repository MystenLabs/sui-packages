module 0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::shares {
    public fun mint(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        assert!(arg2 > 0, 100);
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div(arg0, arg1, arg2)
    }

    public fun redeem(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 <= arg1, 101);
        if (arg0 == 0) {
            return 0
        };
        0xfd3bbac03bacaa09904bc4d1529a0032aaa8b1bc575d884ae7767571cc5be8c8::math::mul_div(arg0, arg2, arg1)
    }

    // decompiled from Move bytecode v7
}

