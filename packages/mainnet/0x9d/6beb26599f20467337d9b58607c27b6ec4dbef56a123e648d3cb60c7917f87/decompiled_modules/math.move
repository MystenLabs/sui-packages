module 0x9d6beb26599f20467337d9b58607c27b6ec4dbef56a123e648d3cb60c7917f87::math {
    public fun fee_denom() : u64 {
        10000
    }

    public fun get_amount_in(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0 && arg2 > arg0, 101);
        assert!(arg3 < 10000, 102);
        (((arg1 as u128) * (arg0 as u128) * (10000 as u128) / ((arg2 - arg0) as u128) * ((10000 - arg3) as u128)) as u64) + 1
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg0 > 0, 100);
        assert!(arg1 > 0 && arg2 > 0, 101);
        assert!(arg3 < 10000, 102);
        let v0 = (arg0 as u128) * ((10000 - arg3) as u128);
        ((v0 * (arg2 as u128) / ((arg1 as u128) * (10000 as u128) + v0)) as u64)
    }

    // decompiled from Move bytecode v7
}

