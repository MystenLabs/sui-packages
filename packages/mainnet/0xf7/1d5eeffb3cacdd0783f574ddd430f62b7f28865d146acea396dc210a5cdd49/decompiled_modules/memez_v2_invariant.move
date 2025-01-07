module 0xf71d5eeffb3cacdd0783f574ddd430f62b7f28865d146acea396dc210a5cdd49::memez_v2_invariant {
    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 != 0, 9223372114164187137);
        let v0 = if (arg1 != 0) {
            if (arg2 != 0) {
                arg2 > arg0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 9223372118459285507);
        let v1 = (arg0 as u256);
        let v2 = (arg1 as u256) * v1;
        let v3 = if (v2 == 0) {
            0
        } else {
            1 + (v2 - 1) / ((arg2 as u256) - v1)
        };
        (v3 as u64)
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 != 0, 9223372182883663873);
        assert!(arg1 != 0 && arg2 != 0, 9223372187178762243);
        let v0 = (arg0 as u256);
        (((arg2 as u256) * v0 / ((arg1 as u256) + v0)) as u64)
    }

    public fun invariant_(arg0: u64, arg1: u64) : u256 {
        (arg0 as u256) * (arg1 as u256)
    }

    // decompiled from Move bytecode v6
}

