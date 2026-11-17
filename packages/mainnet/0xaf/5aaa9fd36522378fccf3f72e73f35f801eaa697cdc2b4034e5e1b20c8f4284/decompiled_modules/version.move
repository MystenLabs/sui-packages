module 0xaf5aaa9fd36522378fccf3f72e73f35f801eaa697cdc2b4034e5e1b20c8f4284::version {
    public fun assert_version(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 900);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

