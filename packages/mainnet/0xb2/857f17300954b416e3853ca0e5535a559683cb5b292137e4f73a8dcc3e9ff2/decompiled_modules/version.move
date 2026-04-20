module 0xb2857f17300954b416e3853ca0e5535a559683cb5b292137e4f73a8dcc3e9ff2::version {
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

