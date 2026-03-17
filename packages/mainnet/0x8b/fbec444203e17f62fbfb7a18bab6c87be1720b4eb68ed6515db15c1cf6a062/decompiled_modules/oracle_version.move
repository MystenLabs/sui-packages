module 0x8bfbec444203e17f62fbfb7a18bab6c87be1720b4eb68ed6515db15c1cf6a062::oracle_version {
    public fun next_version() : u64 {
        0x8bfbec444203e17f62fbfb7a18bab6c87be1720b4eb68ed6515db15c1cf6a062::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x8bfbec444203e17f62fbfb7a18bab6c87be1720b4eb68ed6515db15c1cf6a062::oracle_constants::version(), 0x8bfbec444203e17f62fbfb7a18bab6c87be1720b4eb68ed6515db15c1cf6a062::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x8bfbec444203e17f62fbfb7a18bab6c87be1720b4eb68ed6515db15c1cf6a062::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

