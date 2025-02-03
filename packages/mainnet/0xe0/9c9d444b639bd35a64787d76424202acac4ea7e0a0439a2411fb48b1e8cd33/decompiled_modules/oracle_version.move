module 0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_version {
    public fun next_version() : u64 {
        0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_constants::version(), 0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xe09c9d444b639bd35a64787d76424202acac4ea7e0a0439a2411fb48b1e8cd33::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

