module 0xaf01b7e38e520727daa7a253e536747d8eacd9bc86ab6e61894a69e27520b8cc::oracle_version {
    public fun next_version() : u64 {
        0xaf01b7e38e520727daa7a253e536747d8eacd9bc86ab6e61894a69e27520b8cc::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xaf01b7e38e520727daa7a253e536747d8eacd9bc86ab6e61894a69e27520b8cc::oracle_constants::version(), 0xaf01b7e38e520727daa7a253e536747d8eacd9bc86ab6e61894a69e27520b8cc::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xaf01b7e38e520727daa7a253e536747d8eacd9bc86ab6e61894a69e27520b8cc::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

