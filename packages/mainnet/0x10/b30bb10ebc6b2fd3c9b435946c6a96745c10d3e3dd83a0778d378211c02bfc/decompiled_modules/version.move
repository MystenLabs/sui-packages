module 0x10b30bb10ebc6b2fd3c9b435946c6a96745c10d3e3dd83a0778d378211c02bfc::version {
    public(friend) fun check_version(arg0: u64) {
        assert!(0 != current_version(), 0);
        assert!(arg0 == current_version(), 0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    // decompiled from Move bytecode v6
}

