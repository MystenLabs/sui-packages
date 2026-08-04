module 0xa744554a387f5807940e1d8fba183ce997f8c3ccc4a3c56398830441a4c49323::version {
    public fun next_version() : u64 {
        1 + 1
    }

    public fun pre_check_version(arg0: u64, arg1: u64) {
        assert!(arg0 == 1, arg1);
    }

    public fun this_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

