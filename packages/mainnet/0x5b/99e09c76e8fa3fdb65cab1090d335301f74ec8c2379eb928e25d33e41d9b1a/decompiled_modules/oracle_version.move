module 0x5b99e09c76e8fa3fdb65cab1090d335301f74ec8c2379eb928e25d33e41d9b1a::oracle_version {
    public fun next_version() : u64 {
        0x5b99e09c76e8fa3fdb65cab1090d335301f74ec8c2379eb928e25d33e41d9b1a::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x5b99e09c76e8fa3fdb65cab1090d335301f74ec8c2379eb928e25d33e41d9b1a::oracle_constants::version(), 0x5b99e09c76e8fa3fdb65cab1090d335301f74ec8c2379eb928e25d33e41d9b1a::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x5b99e09c76e8fa3fdb65cab1090d335301f74ec8c2379eb928e25d33e41d9b1a::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

