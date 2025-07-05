module 0x59a8b2b45f4ea0770e3231e758c6edb9bb62317ed177911dc52abd4ebff605cc::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

