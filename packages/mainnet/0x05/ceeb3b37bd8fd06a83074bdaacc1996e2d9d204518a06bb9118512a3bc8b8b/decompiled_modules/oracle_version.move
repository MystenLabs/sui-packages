module 0x5ceeb3b37bd8fd06a83074bdaacc1996e2d9d204518a06bb9118512a3bc8b8b::oracle_version {
    public fun next_version() : u64 {
        0x5ceeb3b37bd8fd06a83074bdaacc1996e2d9d204518a06bb9118512a3bc8b8b::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x5ceeb3b37bd8fd06a83074bdaacc1996e2d9d204518a06bb9118512a3bc8b8b::oracle_constants::version(), 0x5ceeb3b37bd8fd06a83074bdaacc1996e2d9d204518a06bb9118512a3bc8b8b::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x5ceeb3b37bd8fd06a83074bdaacc1996e2d9d204518a06bb9118512a3bc8b8b::oracle_constants::version()
    }

    // decompiled from Move bytecode v7
}

