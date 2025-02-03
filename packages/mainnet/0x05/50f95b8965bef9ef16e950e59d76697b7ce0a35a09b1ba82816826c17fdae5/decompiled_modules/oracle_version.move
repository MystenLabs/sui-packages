module 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_version {
    public fun next_version() : u64 {
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::version(), 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

