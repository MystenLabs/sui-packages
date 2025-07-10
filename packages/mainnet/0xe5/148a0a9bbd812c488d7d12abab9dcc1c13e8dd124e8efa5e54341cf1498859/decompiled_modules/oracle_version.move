module 0xe5148a0a9bbd812c488d7d12abab9dcc1c13e8dd124e8efa5e54341cf1498859::oracle_version {
    public fun next_version() : u64 {
        0xe5148a0a9bbd812c488d7d12abab9dcc1c13e8dd124e8efa5e54341cf1498859::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xe5148a0a9bbd812c488d7d12abab9dcc1c13e8dd124e8efa5e54341cf1498859::oracle_constants::version(), 0xe5148a0a9bbd812c488d7d12abab9dcc1c13e8dd124e8efa5e54341cf1498859::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xe5148a0a9bbd812c488d7d12abab9dcc1c13e8dd124e8efa5e54341cf1498859::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

