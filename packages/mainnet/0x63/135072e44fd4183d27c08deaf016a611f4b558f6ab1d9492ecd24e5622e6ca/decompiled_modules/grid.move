module 0x7452c8ce8db1991fe41e500a4778b04f5b1d8891528b0376988f966cbdae5409::grid {
    public fun geometric(arg0: u64, arg1: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < arg1 && arg0 > 0) {
            0x1::vector::push_back<u64>(&mut v0, arg0);
            arg0 = arg0 / 2;
            v1 = v1 + 1;
        };
        assert!(!0x1::vector::is_empty<u64>(&v0), 1);
        v0
    }

    // decompiled from Move bytecode v7
}

