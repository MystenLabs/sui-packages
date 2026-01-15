module 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::time {
    public fun has_n_days_passed(arg0: u64, arg1: u64, arg2: u64) : bool {
        has_n_seconds_passed_(arg0, arg1, arg2 * 86400, 21600)
    }

    public fun has_n_hours_passed(arg0: u64, arg1: u64, arg2: u64) : bool {
        has_n_seconds_passed_(arg0, arg1, arg2 * 3600, 3600)
    }

    public fun has_n_minutes_passed(arg0: u64, arg1: u64, arg2: u64) : bool {
        has_n_seconds_passed_(arg0, arg1, arg2 * 60, 30)
    }

    public fun has_n_months_passed(arg0: u64, arg1: u64, arg2: u64) : bool {
        has_n_seconds_passed_(arg0, arg1, arg2 * 2419200, 86400)
    }

    public fun has_n_seconds_passed(arg0: u64, arg1: u64, arg2: u64) : bool {
        has_n_seconds_passed_(arg0, arg1, arg2, 15)
    }

    fun has_n_seconds_passed_(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : bool {
        assert!(arg0 >= arg1, 0);
        let v0 = if (arg3 >= arg2) {
            0
        } else {
            arg2 - arg3
        };
        arg0 - arg1 >= v0
    }

    public fun has_n_weeks_passed(arg0: u64, arg1: u64, arg2: u64) : bool {
        has_n_seconds_passed_(arg0, arg1, arg2 * 604800, 86400)
    }

    // decompiled from Move bytecode v6
}

