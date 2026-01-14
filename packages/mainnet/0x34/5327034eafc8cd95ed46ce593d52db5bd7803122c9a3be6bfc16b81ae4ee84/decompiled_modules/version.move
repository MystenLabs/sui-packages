module 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::version {
    public fun next_version() : u64 {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::version(), 0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x3de5911958782460ef07eaf0bd9c9f3a64d0911d1c885ebdf2fd93090308512::constants::version()
    }

    // decompiled from Move bytecode v6
}

