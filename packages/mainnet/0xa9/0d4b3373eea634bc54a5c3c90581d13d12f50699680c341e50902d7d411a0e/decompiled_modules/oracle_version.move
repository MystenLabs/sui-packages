module 0xa90d4b3373eea634bc54a5c3c90581d13d12f50699680c341e50902d7d411a0e::oracle_version {
    public fun next_version() : u64 {
        0xa90d4b3373eea634bc54a5c3c90581d13d12f50699680c341e50902d7d411a0e::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xa90d4b3373eea634bc54a5c3c90581d13d12f50699680c341e50902d7d411a0e::oracle_constants::version(), 0xa90d4b3373eea634bc54a5c3c90581d13d12f50699680c341e50902d7d411a0e::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xa90d4b3373eea634bc54a5c3c90581d13d12f50699680c341e50902d7d411a0e::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

