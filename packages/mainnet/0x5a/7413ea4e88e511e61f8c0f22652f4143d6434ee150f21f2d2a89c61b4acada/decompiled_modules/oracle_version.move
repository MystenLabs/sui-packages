module 0x5a7413ea4e88e511e61f8c0f22652f4143d6434ee150f21f2d2a89c61b4acada::oracle_version {
    public fun next_version() : u64 {
        0x5a7413ea4e88e511e61f8c0f22652f4143d6434ee150f21f2d2a89c61b4acada::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x5a7413ea4e88e511e61f8c0f22652f4143d6434ee150f21f2d2a89c61b4acada::oracle_constants::version(), 0x5a7413ea4e88e511e61f8c0f22652f4143d6434ee150f21f2d2a89c61b4acada::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x5a7413ea4e88e511e61f8c0f22652f4143d6434ee150f21f2d2a89c61b4acada::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

