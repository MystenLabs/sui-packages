module 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::strategy {
    public fun is_oracle_price_fresh(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg0 < arg1) {
            return false
        };
        arg0 - arg1 < arg2
    }

    public fun validate_price_difference(arg0: u256, arg1: u256, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u8 {
        let v0 = 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_utils::calculate_amplitude(arg0, arg1);
        if (v0 < arg2) {
            return 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_constants::level_normal()
        };
        if (v0 > arg3) {
            return 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_constants::level_critical()
        };
        if (arg6 > 0 && arg4 > arg5 + arg6) {
            return 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_constants::level_major()
        };
        0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_constants::level_warning()
    }

    public fun validate_price_range_and_history(arg0: u256, arg1: u256, arg2: u256, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u64) : bool {
        if (arg1 > 0 && arg0 > arg1) {
            return false
        };
        if (arg0 < arg2) {
            return false
        };
        if (arg4 - arg7 < arg5) {
            if (0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_utils::calculate_amplitude(arg6, arg0) > arg3) {
                return false
            };
        };
        true
    }

    // decompiled from Move bytecode v6
}

