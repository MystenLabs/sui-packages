module 0x564a4809351af6b73137a842902efa626a6f78806130295d738f0c8da46af951::oracle_version {
    public fun next_version() : u64 {
        0x564a4809351af6b73137a842902efa626a6f78806130295d738f0c8da46af951::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x564a4809351af6b73137a842902efa626a6f78806130295d738f0c8da46af951::oracle_constants::version(), 0x564a4809351af6b73137a842902efa626a6f78806130295d738f0c8da46af951::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x564a4809351af6b73137a842902efa626a6f78806130295d738f0c8da46af951::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

