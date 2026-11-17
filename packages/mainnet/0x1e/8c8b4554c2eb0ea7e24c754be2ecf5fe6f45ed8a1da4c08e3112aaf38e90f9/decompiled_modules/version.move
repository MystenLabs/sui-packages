module 0x1e8c8b4554c2eb0ea7e24c754be2ecf5fe6f45ed8a1da4c08e3112aaf38e90f9::version {
    public fun assert_version(arg0: &0x2::vec_set::VecSet<u64>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(arg0, &v0), 900);
    }

    public fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

