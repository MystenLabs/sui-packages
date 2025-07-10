module 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::version {
    public fun next_version() : u64 {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::constants::version(), 0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::error::incorrect_version());
    }

    public fun this_version() : u64 {
        0xdd5bfdba545e030c5259e14a1626aaa162034f8fa44fc95c17f6ddc92f0986ca::constants::version()
    }

    // decompiled from Move bytecode v6
}

