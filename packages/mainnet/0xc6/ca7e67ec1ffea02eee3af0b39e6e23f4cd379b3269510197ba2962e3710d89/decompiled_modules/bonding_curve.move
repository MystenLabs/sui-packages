module 0xc6ca7e67ec1ffea02eee3af0b39e6e23f4cd379b3269510197ba2962e3710d89::bonding_curve {
    public fun compute_k(arg0: u64, arg1: u64) : u128 {
        (arg0 as u128) * (arg1 as u128)
    }

    public fun graduation_progress_bps(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 10000
        };
        let v0 = (arg0 as u128) * 10000 / (arg1 as u128);
        if (v0 > 10000) {
            return 10000
        };
        (v0 as u64)
    }

    public fun is_graduated(arg0: u64, arg1: u64) : bool {
        arg0 >= arg1
    }

    public fun split_fee(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = arg0 * arg1 / 100;
        let v1 = arg0 * arg2 / 100;
        (v0, v1, arg0 - v0 - v1)
    }

    public fun spot_price_mist(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public fun sui_in_for_tokens(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 > 0, 0);
        assert!((arg3 as u128) < (arg2 as u128), 1);
        let v0 = (arg1 as u128);
        let v1 = arg0 / ((arg2 as u128) - (arg3 as u128)) + 1;
        assert!(v1 > v0, 2);
        ((v1 - v0) as u64)
    }

    public fun sui_out_gross(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 > 0, 0);
        let v0 = (arg1 as u128);
        let v1 = arg0 / ((arg2 as u128) + (arg3 as u128));
        assert!(v1 < v0, 1);
        ((v0 - v1) as u64)
    }

    public fun tokens_out(arg0: u128, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 > 0, 0);
        let v0 = (arg2 as u128);
        let v1 = arg0 / ((arg1 as u128) + (arg3 as u128));
        assert!(v1 < v0, 1);
        ((v0 - v1) as u64)
    }

    // decompiled from Move bytecode v7
}

