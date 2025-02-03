module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util {
    public fun count_rounds(arg0: u64, arg1: u64) : u64 {
        (arg1 - arg0) / 150000
    }

    public fun count_rounds_and_elapsed_time_in_round(arg0: u64, arg1: u64) : (u64, u64, bool) {
        let v0 = arg1 - arg0;
        let v1 = v0 % 150000;
        (v0 / 150000, v1, v1 < 150000 / 2)
    }

    public fun elapsed_time_after_round(arg0: u64, arg1: u64, arg2: u64) : u64 {
        arg1 - arg0 - arg2 * 150000
    }

    public fun is_in_first_half_of_round(arg0: u64, arg1: u64, arg2: u64) : bool {
        elapsed_time_after_round(arg0, arg1, arg2) < 150000 / 2
    }

    public fun round_duration_ms() : u64 {
        150000
    }

    public fun round_started_at(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1 * 150000
    }

    // decompiled from Move bytecode v6
}

