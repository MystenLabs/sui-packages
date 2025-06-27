module 0xd8dfd56641cc53d87988bcb519d49fdc4c217f21a5c47c7e52715b2e0e06799d::oracle_version {
    public fun next_version() : u64 {
        0xd8dfd56641cc53d87988bcb519d49fdc4c217f21a5c47c7e52715b2e0e06799d::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xd8dfd56641cc53d87988bcb519d49fdc4c217f21a5c47c7e52715b2e0e06799d::oracle_constants::version(), 0xd8dfd56641cc53d87988bcb519d49fdc4c217f21a5c47c7e52715b2e0e06799d::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xd8dfd56641cc53d87988bcb519d49fdc4c217f21a5c47c7e52715b2e0e06799d::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

