module 0x73ade49d2459c3a2a27c70d32680fe0a97bc90a5c15954d248cc424510618c22::oracle_version {
    public fun next_version() : u64 {
        0x73ade49d2459c3a2a27c70d32680fe0a97bc90a5c15954d248cc424510618c22::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x73ade49d2459c3a2a27c70d32680fe0a97bc90a5c15954d248cc424510618c22::oracle_constants::version(), 0x73ade49d2459c3a2a27c70d32680fe0a97bc90a5c15954d248cc424510618c22::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x73ade49d2459c3a2a27c70d32680fe0a97bc90a5c15954d248cc424510618c22::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

