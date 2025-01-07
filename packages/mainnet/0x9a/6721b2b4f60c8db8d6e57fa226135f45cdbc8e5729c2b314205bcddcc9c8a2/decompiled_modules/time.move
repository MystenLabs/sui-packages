module 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::time {
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
        arg0 - arg1 >= arg2 - arg3
    }

    public fun has_n_weeks_passed(arg0: u64, arg1: u64, arg2: u64) : bool {
        has_n_seconds_passed_(arg0, arg1, arg2 * 604800, 86400)
    }

    // decompiled from Move bytecode v6
}

