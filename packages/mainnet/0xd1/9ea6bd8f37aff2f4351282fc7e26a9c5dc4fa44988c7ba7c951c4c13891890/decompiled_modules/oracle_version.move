module 0xd19ea6bd8f37aff2f4351282fc7e26a9c5dc4fa44988c7ba7c951c4c13891890::oracle_version {
    public fun next_version() : u64 {
        0xd19ea6bd8f37aff2f4351282fc7e26a9c5dc4fa44988c7ba7c951c4c13891890::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xd19ea6bd8f37aff2f4351282fc7e26a9c5dc4fa44988c7ba7c951c4c13891890::oracle_constants::version(), 0xd19ea6bd8f37aff2f4351282fc7e26a9c5dc4fa44988c7ba7c951c4c13891890::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xd19ea6bd8f37aff2f4351282fc7e26a9c5dc4fa44988c7ba7c951c4c13891890::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

