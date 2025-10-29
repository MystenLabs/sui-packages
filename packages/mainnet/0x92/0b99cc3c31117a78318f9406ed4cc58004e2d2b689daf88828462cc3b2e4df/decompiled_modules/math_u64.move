module 0x920b99cc3c31117a78318f9406ed4cc58004e2d2b689daf88828462cc3b2e4df::math_u64 {
    public(friend) fun mul_div(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : u64 {
        assert!(arg2 != 0, 1);
        let v0 = (arg0 as u128) * (arg1 as u128);
        if (v0 == 0) {
            return 0
        };
        if (arg3) {
            (((v0 - 1) / (arg2 as u128) + 1) as u64)
        } else {
            ((v0 / (arg2 as u128)) as u64)
        }
    }

    // decompiled from Move bytecode v6
}

