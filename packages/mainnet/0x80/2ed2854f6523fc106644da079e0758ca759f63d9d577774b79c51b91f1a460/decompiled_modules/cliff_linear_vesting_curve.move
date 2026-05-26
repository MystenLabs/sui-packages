module 0x802ed2854f6523fc106644da079e0758ca759f63d9d577774b79c51b91f1a460::cliff_linear_vesting_curve {
    public fun cliff_remaining_time(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg0 + arg2;
        if (arg1 >= v0) {
            0
        } else {
            v0 - arg1
        }
    }

    public fun has_cliff_ended(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 > arg0 + arg2
    }

    public fun is_in_cliff_period(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg1 <= arg0 + arg2
    }

    public fun remaining_vesting_time(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1 + arg0;
        if (arg2 >= v0) {
            0
        } else {
            v0 - arg2
        }
    }

    public fun unvested_payout_at_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        arg0 - vested_payout_at_time(arg0, arg1, arg2, arg3)
    }

    public fun unvested_payout_with_cliff(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        arg0 - vested_payout_with_cliff(arg0, arg1, arg2, arg3, arg4)
    }

    public fun validate_parameters(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 1);
    }

    public fun vested_payout_at_time(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        vested_payout_with_cliff(arg0, arg1, arg2, arg3, 300)
    }

    public fun vested_payout_with_cliff(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg4 >= arg1) {
            if (arg3 >= arg2 + arg4) {
                return arg0
            };
            return 0
        };
        if (arg3 <= arg2 + arg4) {
            0
        } else if (arg3 >= arg2 + arg1) {
            arg0
        } else {
            arg0 * (arg3 - arg2 - arg4) / (arg1 - arg4)
        }
    }

    public fun vesting_progress(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 <= arg1 + arg3) {
            0
        } else if (arg2 >= arg1 + arg0) {
            10000
        } else {
            (arg2 - arg1 - arg3) * 10000 / (arg0 - arg3)
        }
    }

    // decompiled from Move bytecode v7
}

