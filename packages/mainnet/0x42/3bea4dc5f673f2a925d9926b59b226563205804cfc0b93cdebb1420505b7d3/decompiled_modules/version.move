module 0x423bea4dc5f673f2a925d9926b59b226563205804cfc0b93cdebb1420505b7d3::version {
    public fun next_version() : u64 {
        0x423bea4dc5f673f2a925d9926b59b226563205804cfc0b93cdebb1420505b7d3::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x423bea4dc5f673f2a925d9926b59b226563205804cfc0b93cdebb1420505b7d3::constants::version(), 0x423bea4dc5f673f2a925d9926b59b226563205804cfc0b93cdebb1420505b7d3::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x423bea4dc5f673f2a925d9926b59b226563205804cfc0b93cdebb1420505b7d3::constants::version()
    }

    // decompiled from Move bytecode v6
}

