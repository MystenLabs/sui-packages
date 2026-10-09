module 0xb65bd0ca915c375402e54dc3c49b128e87db045ccf0b2c8cb3cff6f5fc6722e5::version {
    public fun assert_is_current(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public fun current() : u64 {
        1
    }

    // decompiled from Move bytecode v7
}

