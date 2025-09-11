module 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle_version {
    public fun next_version() : u64 {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle_constants::version(), 0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x9df3b93cfc12b0a8dfa8c89712b001ef1cc28f2bb2b1bb82d6daa3573846c5b7::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

