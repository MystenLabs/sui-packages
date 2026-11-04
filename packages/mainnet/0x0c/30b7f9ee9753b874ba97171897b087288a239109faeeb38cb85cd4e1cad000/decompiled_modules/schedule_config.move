module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::schedule_config {
    struct ScheduleConfig has copy, drop, store {
        release_count: u64,
        delay_until_first_release_in_ms: u64,
        period_between_releases_in_ms: u64,
        initial_release_portion_in_bps: u16,
    }

    public fun calculate_unlocked(arg0: ScheduleConfig, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 > arg3) {
            return 0
        };
        let v0 = arg3 - arg2;
        let ScheduleConfig {
            release_count                   : v1,
            delay_until_first_release_in_ms : v2,
            period_between_releases_in_ms   : v3,
            initial_release_portion_in_bps  : v4,
        } = arg0;
        if (v0 < v2) {
            return 0
        };
        if (v0 >= v2 + v3 * (v1 - 1)) {
            return arg1
        };
        let v5 = (arg1 as u128) * (v4 as u128) / 10000;
        let v6 = v5;
        if (v0 - v2 >= v3) {
            v6 = v5 + ((arg1 as u128) - v5) * (((v0 - v2) / v3) as u128) / ((v1 as u128) - 1);
        };
        (v6 as u64)
    }

    public fun delay_until_first_release_in_ms(arg0: &ScheduleConfig) : u64 {
        arg0.delay_until_first_release_in_ms
    }

    public fun initial_release_portion_in_bps(arg0: &ScheduleConfig) : u16 {
        arg0.initial_release_portion_in_bps
    }

    public fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u16) : ScheduleConfig {
        assert!(arg0 > 0, 1);
        if (arg0 == 1) {
            assert!(arg3 == 10000, 2);
            assert!(arg2 == 0, 3);
        } else {
            assert!(arg3 < 10000, 0);
            assert!(arg2 > 0, 4);
        };
        assert!((arg1 as u128) + (arg2 as u128) * ((arg0 - 1) as u128) <= 18446744073709551615, 5);
        ScheduleConfig{
            release_count                   : arg0,
            delay_until_first_release_in_ms : arg1,
            period_between_releases_in_ms   : arg2,
            initial_release_portion_in_bps  : arg3,
        }
    }

    public fun period_between_releases_in_ms(arg0: &ScheduleConfig) : u64 {
        arg0.period_between_releases_in_ms
    }

    public fun release_count(arg0: &ScheduleConfig) : u64 {
        arg0.release_count
    }

    // decompiled from Move bytecode v7
}

