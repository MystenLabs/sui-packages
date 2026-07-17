module 0xaea574ddfd8ef634d7ec98edc1ae94683a9eabd8c82459db416150d9385c84aa::oracle_version {
    public fun next_version() : u64 {
        0xaea574ddfd8ef634d7ec98edc1ae94683a9eabd8c82459db416150d9385c84aa::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xaea574ddfd8ef634d7ec98edc1ae94683a9eabd8c82459db416150d9385c84aa::oracle_constants::version(), 0xaea574ddfd8ef634d7ec98edc1ae94683a9eabd8c82459db416150d9385c84aa::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xaea574ddfd8ef634d7ec98edc1ae94683a9eabd8c82459db416150d9385c84aa::oracle_constants::version()
    }

    // decompiled from Move bytecode v7
}

