module 0xe596d8ae7010a101545d84cdead3c7c4bcb475c3bd614fc13e456adff21fafe::version {
    public fun assert_version(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 900);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

