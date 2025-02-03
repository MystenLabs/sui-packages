module 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_version {
    public fun next_version() : u64 {
        0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_constants::version(), 0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x7c1aa540ad611dedbea1b70f4947347837f28c2e12b7ea611901853216edbeb2::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

