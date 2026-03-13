module 0x45c82249c59ef5c50b9a8ccaba962fa5d441aa869f5f2611c02e3714dba5de27::constraints {
    struct Constraints has copy, drop, store {
        max_spend_per_execution: u64,
        time_window_start: u64,
        time_window_end: u64,
        max_total_executions: u64,
        cooldown_ms: u64,
    }

    public fun cooldown_ms(arg0: &Constraints) : u64 {
        arg0.cooldown_ms
    }

    public fun max_spend_per_execution(arg0: &Constraints) : u64 {
        arg0.max_spend_per_execution
    }

    public fun max_total_executions(arg0: &Constraints) : u64 {
        arg0.max_total_executions
    }

    public fun new_constraints(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Constraints {
        if (arg1 > 0 && arg2 > 0) {
            assert!(arg2 > arg1, 1);
        };
        if (arg4 > 0) {
            assert!(arg4 <= 2592000000, 2);
        };
        Constraints{
            max_spend_per_execution : arg0,
            time_window_start       : arg1,
            time_window_end         : arg2,
            max_total_executions    : arg3,
            cooldown_ms             : arg4,
        }
    }

    public fun time_window_end(arg0: &Constraints) : u64 {
        arg0.time_window_end
    }

    public fun time_window_start(arg0: &Constraints) : u64 {
        arg0.time_window_start
    }

    public fun verify(arg0: &Constraints, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg0.time_window_start > 0) {
            assert!(v0 >= arg0.time_window_start, 3);
        };
        if (arg0.time_window_end > 0) {
            assert!(v0 <= arg0.time_window_end, 4);
        };
        if (arg0.max_total_executions > 0) {
            assert!(arg1 < arg0.max_total_executions, 5);
        };
        if (arg0.cooldown_ms > 0 && arg2 > 0) {
            assert!(v0 >= arg2 + arg0.cooldown_ms, 6);
        };
    }

    // decompiled from Move bytecode v6
}

