module 0x6849e7792791ce81072dfb2eab468aa7f5077700a12b70509f8d405f66a73d86::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

