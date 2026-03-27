module 0x44077b4aa4f39ba33b5bf96c28984955cffa6a5a1523d9b45181bd633be9a77d::fee_scheduler {
    struct FeeSchedule has copy, drop, store {
        initial_fee_bps: u64,
        duration_ms: u64,
    }

    public fun default_launch_schedule() : FeeSchedule {
        FeeSchedule{
            initial_fee_bps : 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_launch_fee_bps(),
            duration_ms     : 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::fifteen_minutes_ms(),
        }
    }

    public fun duration_ms(arg0: &FeeSchedule) : u64 {
        arg0.duration_ms
    }

    public fun fee_scale() : u64 {
        0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::total_fee_bps()
    }

    public fun get_current_fee(arg0: &FeeSchedule, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg0.duration_ms == 0) {
            return arg1
        };
        if (arg1 >= arg0.initial_fee_bps) {
            return arg1
        };
        if (arg3 <= arg2) {
            return arg0.initial_fee_bps
        };
        let v0 = arg3 - arg2;
        if (v0 >= arg0.duration_ms) {
            return arg1
        };
        let v1 = 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::fee_precision_scale();
        let v2 = ((arg0.initial_fee_bps - arg1) as u128) * (v0 as u128) * v1 / (arg0.duration_ms as u128) / v1;
        assert!(v2 <= (arg0.initial_fee_bps as u128), 2);
        let v3 = arg0.initial_fee_bps - (v2 as u64);
        if (v3 < arg1) {
            arg1
        } else {
            v3
        }
    }

    public fun initial_fee_bps(arg0: &FeeSchedule) : u64 {
        arg0.initial_fee_bps
    }

    public fun max_duration_ms() : u64 {
        0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::one_day_ms()
    }

    public fun max_initial_fee_bps() : u64 {
        0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_launch_fee_bps()
    }

    public fun new_schedule(arg0: u64, arg1: u64) : FeeSchedule {
        assert!(arg0 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::max_launch_fee_bps(), 0);
        assert!(arg1 <= 0xada535b9a93c1785cb9bc8918c6f133da5f167ab3c9f189c7eda8f2fa82cb6a3::constants::one_day_ms(), 1);
        FeeSchedule{
            initial_fee_bps : arg0,
            duration_ms     : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

