module 0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle_version {
    public fun next_version() : u64 {
        0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle_constants::version(), 0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xb5f575201e77ede61f5ce124d54855b3832ea948efa58820afe69e9a2d2f0cf4::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

