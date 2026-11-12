module 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::version {
    public fun next_version() : u64 {
        0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::constants::version(), 0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x51e18f149666eff167d6bcaf59d0b9edcf6affe7650bb2bc3d5167a8c9f6f6d0::constants::version()
    }

    // decompiled from Move bytecode v7
}

