module 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle_version {
    public fun next_version() : u64 {
        0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle_constants::version(), 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

