module 0xc9acdbdbddabf8dd7065eaeff2925aac048027f358125dd83f3ccc6ed0a3832e::version {
    public fun next_version() : u64 {
        0xc9acdbdbddabf8dd7065eaeff2925aac048027f358125dd83f3ccc6ed0a3832e::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xc9acdbdbddabf8dd7065eaeff2925aac048027f358125dd83f3ccc6ed0a3832e::constants::version(), 0xc9acdbdbddabf8dd7065eaeff2925aac048027f358125dd83f3ccc6ed0a3832e::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xc9acdbdbddabf8dd7065eaeff2925aac048027f358125dd83f3ccc6ed0a3832e::constants::version()
    }

    // decompiled from Move bytecode v6
}

