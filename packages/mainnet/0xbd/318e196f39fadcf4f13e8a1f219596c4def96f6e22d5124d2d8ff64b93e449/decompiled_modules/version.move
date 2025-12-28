module 0xbd318e196f39fadcf4f13e8a1f219596c4def96f6e22d5124d2d8ff64b93e449::version {
    public fun check_version(arg0: u64) {
        assert!(get_version() == arg0, 1001);
    }

    public fun get_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

