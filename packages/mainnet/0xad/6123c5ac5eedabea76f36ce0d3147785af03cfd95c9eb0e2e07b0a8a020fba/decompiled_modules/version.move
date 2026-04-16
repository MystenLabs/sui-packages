module 0xad6123c5ac5eedabea76f36ce0d3147785af03cfd95c9eb0e2e07b0a8a020fba::version {
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

