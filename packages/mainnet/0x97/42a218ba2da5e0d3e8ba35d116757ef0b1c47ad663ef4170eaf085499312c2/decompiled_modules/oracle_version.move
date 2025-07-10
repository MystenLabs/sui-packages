module 0x9742a218ba2da5e0d3e8ba35d116757ef0b1c47ad663ef4170eaf085499312c2::oracle_version {
    public fun next_version() : u64 {
        0x9742a218ba2da5e0d3e8ba35d116757ef0b1c47ad663ef4170eaf085499312c2::oracle_constants::version() + 1
    }

    public fun pre_check_version(arg0: u64) {
        assert!(arg0 == 0x9742a218ba2da5e0d3e8ba35d116757ef0b1c47ad663ef4170eaf085499312c2::oracle_constants::version(), 0x9742a218ba2da5e0d3e8ba35d116757ef0b1c47ad663ef4170eaf085499312c2::oracle_error::incorrect_version());
    }

    public fun this_version() : u64 {
        0x9742a218ba2da5e0d3e8ba35d116757ef0b1c47ad663ef4170eaf085499312c2::oracle_constants::version()
    }

    // decompiled from Move bytecode v6
}

