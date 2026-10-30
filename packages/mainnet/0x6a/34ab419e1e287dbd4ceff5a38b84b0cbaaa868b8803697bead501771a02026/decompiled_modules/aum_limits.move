module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::aum_limits {
    struct AumLimits has store {
        increase_bps: u64,
        decrease_bps: u64,
        cumulative_increase_bps: u64,
        cumulative_decrease_bps: u64,
        window_open: bool,
        window_start_ms: u64,
        window_base: u64,
        window_increase: u64,
        window_decrease: u64,
    }

    fun assert_bps(arg0: u64, arg1: u64) {
        assert!(arg0 <= 10000 && arg1 <= 10000, 13835058892801114118);
    }

    public fun cumulative_decrease_bps(arg0: &AumLimits) : u64 {
        arg0.cumulative_decrease_bps
    }

    public fun cumulative_increase_bps(arg0: &AumLimits) : u64 {
        arg0.cumulative_increase_bps
    }

    public fun decrease_bps(arg0: &AumLimits) : u64 {
        arg0.decrease_bps
    }

    public fun increase_bps(arg0: &AumLimits) : u64 {
        arg0.increase_bps
    }

    fun is_within(arg0: u128, arg1: u64, arg2: u64) : bool {
        arg0 * 10000 <= (arg1 as u128) * (arg2 as u128)
    }

    public(friend) fun new(arg0: u64, arg1: u64) : AumLimits {
        assert_bps(arg0, arg1);
        AumLimits{
            increase_bps            : arg0,
            decrease_bps            : arg1,
            cumulative_increase_bps : 1000,
            cumulative_decrease_bps : 500,
            window_open             : false,
            window_start_ms         : 0,
            window_base             : 0,
            window_increase         : 0,
            window_decrease         : 0,
        }
    }

    public(friend) fun record_deployment(arg0: &mut AumLimits, arg1: u64) {
        if (!arg0.window_open) {
            return
        };
        arg0.window_base = arg0.window_base + 0x1::u64::min(arg1, 18446744073709551615 - arg0.window_base);
    }

    public(friend) fun record_report(arg0: &mut AumLimits, arg1: u64, arg2: u64, arg3: u64) {
        if (arg2 == arg1) {
            return
        };
        assert!(arg1 != 0, 13835902969839288332);
        let v0 = arg2 > arg1;
        let v1 = 0x1::u64::diff(arg2, arg1);
        let v2 = if (v0) {
            arg0.increase_bps
        } else {
            arg0.decrease_bps
        };
        assert!(is_within((v1 as u128), v2, arg1), 13835340037065474056);
        if (!arg0.window_open || arg3 - arg0.window_start_ms >= 86400000) {
            arg0.window_open = true;
            arg0.window_start_ms = arg3;
            arg0.window_base = arg1;
            arg0.window_increase = 0;
            arg0.window_decrease = 0;
        };
        let (v3, v4) = if (v0) {
            (arg0.window_increase, arg0.cumulative_increase_bps)
        } else {
            (arg0.window_decrease, arg0.cumulative_decrease_bps)
        };
        let v5 = (v3 as u128) + (v1 as u128);
        assert!(is_within(v5, v4, arg0.window_base), 13835621576466825226);
        if (v0) {
            arg0.window_increase = (v5 as u64);
        } else {
            arg0.window_decrease = (v5 as u64);
        };
    }

    public(friend) fun record_return(arg0: &mut AumLimits, arg1: u64) {
        if (!arg0.window_open) {
            return
        };
        arg0.window_base = arg0.window_base - 0x1::u64::min(arg1, arg0.window_base);
    }

    public(friend) fun set_cumulative_limits(arg0: &mut AumLimits, arg1: u64, arg2: u64) {
        assert_bps(arg1, arg2);
        arg0.cumulative_increase_bps = arg1;
        arg0.cumulative_decrease_bps = arg2;
        arg0.window_open = false;
        arg0.window_base = 0;
        arg0.window_increase = 0;
        arg0.window_decrease = 0;
    }

    public(friend) fun set_report_limits(arg0: &mut AumLimits, arg1: u64, arg2: u64) : bool {
        assert_bps(arg1, arg2);
        let v0 = arg0.increase_bps != arg1 || arg0.decrease_bps != arg2;
        arg0.increase_bps = arg1;
        arg0.decrease_bps = arg2;
        v0
    }

    public fun window_base(arg0: &AumLimits) : u64 {
        arg0.window_base
    }

    public fun window_decrease(arg0: &AumLimits) : u64 {
        arg0.window_decrease
    }

    public fun window_increase(arg0: &AumLimits) : u64 {
        arg0.window_increase
    }

    public fun window_open(arg0: &AumLimits) : bool {
        arg0.window_open
    }

    public fun window_start_ms(arg0: &AumLimits) : u64 {
        arg0.window_start_ms
    }

    // decompiled from Move bytecode v7
}

