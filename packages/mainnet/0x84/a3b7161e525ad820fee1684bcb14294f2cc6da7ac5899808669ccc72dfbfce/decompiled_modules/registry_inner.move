module 0x84a3b7161e525ad820fee1684bcb14294f2cc6da7ac5899808669ccc72dfbfce::registry_inner {
    public(friend) fun calculate_betting_close(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 - arg1) * 1000 / 10000;
        let v1 = v0;
        if (v0 < 3600000) {
            v1 = 3600000;
        };
        if (v1 > 86400000) {
            v1 = 86400000;
        };
        arg0 - v1
    }

    public(friend) fun calculate_fees(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u64) {
        (arg0 * arg1 / 10000, arg0 * arg2 / 10000, arg0 * arg3 / 10000)
    }

    public(friend) fun calculate_payout(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 0);
        (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    public(friend) fun validate_fees(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 + arg1 + arg2 < 10000
    }

    // decompiled from Move bytecode v6
}

