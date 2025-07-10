module 0x7c6a8bdeb44b2f1fc4c2d8613756bbc617d14435c07177c17d076f4f06efe71e::oracle_version {
    public fun next_version() : u64 {
        0x7c6a8bdeb44b2f1fc4c2d8613756bbc617d14435c07177c17d076f4f06efe71e::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x7c6a8bdeb44b2f1fc4c2d8613756bbc617d14435c07177c17d076f4f06efe71e::oracle_constants::version(), 0x7c6a8bdeb44b2f1fc4c2d8613756bbc617d14435c07177c17d076f4f06efe71e::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x7c6a8bdeb44b2f1fc4c2d8613756bbc617d14435c07177c17d076f4f06efe71e::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

