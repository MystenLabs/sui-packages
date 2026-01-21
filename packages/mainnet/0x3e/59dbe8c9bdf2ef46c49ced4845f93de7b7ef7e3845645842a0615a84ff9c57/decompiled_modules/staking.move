module 0x3e59dbe8c9bdf2ef46c49ced4845f93de7b7ef7e3845645842a0615a84ff9c57::staking {
    public fun calculate_claim_penalty(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        assert!(arg1 >= arg0, 0);
        if (arg1 - arg0 >= 604800000) {
            (arg2, 0)
        } else {
            let v2 = arg2 * 2000 / 10000;
            (arg2 - v2, v2)
        }
    }

    public fun calculate_points_penalty(arg0: u64, arg1: u64, arg2: u128) : (u128, u128) {
        assert!(arg1 >= arg0, 0);
        if (arg1 - arg0 >= 604800000) {
            (arg2, 0)
        } else {
            let v2 = arg2 * (2000 as u128) / (10000 as u128);
            (arg2 - v2, v2)
        }
    }

    public fun can_claim_without_penalty(arg0: u64, arg1: u64) : bool {
        if (arg1 < arg0) {
            return false
        };
        arg1 - arg0 >= 604800000
    }

    public fun get_bps_base() : u64 {
        10000
    }

    public fun get_min_staking_period() : u64 {
        604800000
    }

    public fun get_penalty_bps() : u64 {
        2000
    }

    public fun get_time_until_penalty_free(arg0: u64, arg1: u64) : u64 {
        if (arg1 < arg0) {
            return 604800000
        };
        let v0 = arg1 - arg0;
        if (v0 >= 604800000) {
            0
        } else {
            604800000 - v0
        }
    }

    // decompiled from Move bytecode v6
}

