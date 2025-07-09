module 0x95b0454c6f5a1258b922ee3edc0f5d287511cf56197677feaf58dc6dfafc5916::oracle_version {
    public fun next_version() : u64 {
        0x95b0454c6f5a1258b922ee3edc0f5d287511cf56197677feaf58dc6dfafc5916::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x95b0454c6f5a1258b922ee3edc0f5d287511cf56197677feaf58dc6dfafc5916::oracle_constants::version(), 0x95b0454c6f5a1258b922ee3edc0f5d287511cf56197677feaf58dc6dfafc5916::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x95b0454c6f5a1258b922ee3edc0f5d287511cf56197677feaf58dc6dfafc5916::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

