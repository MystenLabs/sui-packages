module 0x82dc3c35c611d3a21522699f7482013cb73a5850aec2330d27bc4908220528be::version {
    public fun next_version() : u64 {
        0x82dc3c35c611d3a21522699f7482013cb73a5850aec2330d27bc4908220528be::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x82dc3c35c611d3a21522699f7482013cb73a5850aec2330d27bc4908220528be::constants::version(), 0x82dc3c35c611d3a21522699f7482013cb73a5850aec2330d27bc4908220528be::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x82dc3c35c611d3a21522699f7482013cb73a5850aec2330d27bc4908220528be::constants::version()
    }

    // decompiled from Move bytecode v6
}

