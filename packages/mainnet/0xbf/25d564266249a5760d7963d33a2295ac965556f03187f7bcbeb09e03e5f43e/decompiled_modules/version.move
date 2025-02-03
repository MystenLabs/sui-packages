module 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::version {
    public fun next_version() : u64 {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::constants::version(), 0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x2add082237648e5c24efbbe86abb18ce2520d5361a23204c58ed0cd034a1e492::constants::version()
    }

    // decompiled from Move bytecode v6
}

